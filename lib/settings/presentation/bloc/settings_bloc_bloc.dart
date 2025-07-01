import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clear_app_helper/core/datasources/default_data.dart';
import 'package:clear_app_helper/core/domain/entities/ids_finded.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/hash_func.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:clear_app_helper/core/presentation/bloc_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_description_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_and_stream.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_description_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/domain/usecase/settings_description_use_case.dart';
import 'package:clear_app_helper/settings/domain/usecase/settings_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_bloc_event.dart';
part 'settings_bloc_state.dart';

class SettingsBloc extends EntityBloc<SettingsBlocEvent, SettingsBlocState, SettingsEntity, SettingsSearchEntity> {
  final SettingsUseCase settingsUseCase;
  final SettingsDescriptionUseCase settingsDescriptionUseCase;
  final SettingsDefaultData settingsDefaultData = SettingsDefaultData();
  AbstractDefaultData defaults;
  //LOCAL values

  Map<int, BlocSettingsAndStream> fullMap = {};
  StreamSubscription<SettingsEntity?>? themeModeStream;
  late BlocHelper<SettingsEntity, SettingsSearchEntity> settingsBlocHelper = BlocHelper(useCase: settingsUseCase);
  late BlocHelper<SettingsDescriptionEntity, SettingsDescriptionSearchEntity> settingsDescriptionBlocHelper =
      BlocHelper(useCase: settingsDescriptionUseCase);
  static const emptySearchEntity = SettingsSearchEntity();

  final ScrollController controller = ScrollController();
  late IdsFinded<SettingsSearchEntity> settingsIdsFinded = IdsFinded<SettingsSearchEntity>(
    [],
    emptySearchEntity,
    controller,
  );

  SettingsBloc({required this.settingsUseCase, required this.settingsDescriptionUseCase, required this.defaults})
    : super(const InitialSettingsBlocState()) {
    ///
    ///STREAM
    ///
    settingsUseCase.watchLazy().listen((event) async {
      add(const SettingsBlocEvent.loadFullLists());
    });

    on<SettingsBlocEvent>((event, emit) async {
      void emitSavingError(String s) => emit(SettingsBlocState.savingError(s));
      void emitLoadingError(String s) => emit(SettingsBlocState.loadingError(s, settingsIdsFinded.se));

      void emitLoading() => emit(const SettingsBlocState.loading());
      void emitLoaded() => emit(SettingsBlocState.loaded(settingsIdsFinded));
      void emitSaving() => emit.call(const SettingsBlocState.saving());

      Future<List<SettingsEntity>> loadList(SettingsSearchEntity searchEntityToLoad) async {
        return await settingsBlocHelper.getList(
          settingsUseCase.call(SettingsUseCaseParams(searchEntityToLoad)),
          emitLoadingError,
        );
      }

      void updateFullMap(List<SettingsEntity> list) {
        fullMap.clear();
        fullMap.addAll({for (var e in list) e.id!: BlocSettingsAndStream.fromDB(setting: e, settingsBloc: this)});
        add(SettingsBlocEvent.load(settingsIdsFinded.se));
      }

      Future<int> addSetting(SettingsEntity item) async {
        return await settingsBlocHelper.add(item, emitSavingError);
      }

      Future<int> updateSetting(SettingsEntity item, {bool revertDelete = false}) async {
        return await settingsBlocHelper.update(
          itemToUpdate: item,
          revertDelete: revertDelete,
          ifRightUpdate: (_) {},
          savingError: emitSavingError,
        );
      }

      Future<int> updateSettingDescription(SettingsDescriptionEntity item, {bool revertDelete = false}) async {
        return await settingsDescriptionBlocHelper.update(
          itemToUpdate: item,
          revertDelete: revertDelete,
          ifRightUpdate: (_) {},
          savingError: emitSavingError,
        );
      }

      void updateFromDefault() async {
        final version = getByEnum(SettingsSettingsEnum.version);
        final lastUpdateVersion = await PackageInfo.fromPlatform().then((value) => value.version);
        if (version?.getUserOrDefaultValueAsString != lastUpdateVersion) {
          for (var item in fullMap.values) {
            if (item.setting != null) {
              final newSetting = tryGetNewSettingFromDefaults(item.setting!.name);
              final newDescription = tryGetNewSettingDescriptionFromDefaults(fastHash(item.setting!.name));

              if (newSetting != null &&
                  newSetting.name != CoreSettingsEnum.globalQuery.name &&
                  newSetting.name != CoreSettingsEnum.globalTr.name &&
                  (item.setting?.confirmType != newSetting.confirmType ||
                      item.setting?.defaultValue != newSetting.defaultValue ||
                      item.setting?.isDeleted != newSetting.isDeleted ||
                      item.setting?.type != newSetting.type ||
                      item.setting?.values != newSetting.values)) {
                if (kDebugMode) log("update setting from default: ${newSetting.name}");
                updateSetting(newSetting.copyWith(userValue: item.setting!.userValue));
              }
              if (newDescription != null) {
                updateSettingDescription(newDescription);
              }
            }
          }
          if (version != null) updateSetting(version.copyWith(userValue: lastUpdateVersion));
        }
      }

      Future<void> onLoadFullLists() async {
        final list = await loadList(emptySearchEntity);
        updateFullMap(list);
        if (themeModeStream == null) themeModeChecker();
        updateFromDefault();
      }

      Future<void> onSaveForm(value) async {
        emitSaving();
        try {
          FunctionsHelper.saveItemFromForm<SettingsEntity>(
            blocAdd: (item) async => await addSetting(item),
            blocUpdate: (item) async => await updateSetting(item),
            item: value.item,
            origItem: value.origItem,
            textSave: GetIt.instance<CoreI18n>().settingIsSave,
            textValidFailed: GetIt.instance<CoreI18n>().settingIsNotSaved,
            pop: value.pop,
            showItemNavifator: (id) =>
                RouteHelper.toNamed(SettingsRouteNames.settingsDetailPage, arguments: SettingsSearchEntity(id: id)),
            formKey: value.formKey,
          );
          emitLoaded();
        } catch (e) {
          emitSavingError("$e");
        }
      }

      Future<void> onUpdate(value) async {
        emitSaving();
        try {
          await updateSetting(value.item);
          emitLoaded();
        } catch (e) {
          emitSavingError("$e");
        }
      }

      Future<void> onLoad(value) async {
        emitLoading();
        settingsIdsFinded = settingsIdsFinded.copyWith(se: value.searchEntity ?? emptySearchEntity);

        if (settingsIdsFinded.se.isEmpty() == true) {
          //take full
          settingsIdsFinded = settingsIdsFinded.copyWith(
            list: fullMap.values.map((e) => e.setting?.id).nonNulls.toList(),
          );
        } else {
          final List<int> list = await settingsBlocHelper.getIdsList(
            settingsUseCase.getAllIds(SettingsUseCaseParams(value.searchEntity ?? emptySearchEntity)),
            emitLoadingError,
          );
          settingsIdsFinded = settingsIdsFinded.copyWith(list: list);
        }

        emitLoaded();
      }

      onErrorShowed() {
        add(const SettingsBlocEvent.loadFullLists());
      }

      await switch (event) {
        ErrorShowedSettingsBlocEvent() => onErrorShowed(),
        LoadFullListsSettingsBlocEvent() => onLoadFullLists(),
        LoadSettingsBlocEvent() => onLoad(event),
        SaveFormSettingsBlocEvent() => onSaveForm(event),
        UpdateSettingsBlocEvent() => onUpdate(event),
        ResetToDefaultSettingsBlocEvent() => updateSetting(event.item.copyWith(userValue: null)),
      };
    }, transformer: sequential());
  }

  @override
  Stream<SettingsEntity?> getStreamById(int id) {
    return settingsUseCase.getStream(id);
  }

  @override
  Stream<void> watchObjectLazy(int? id) {
    if (id == null) {
      return const Stream.empty();
    }
    return settingsUseCase.watchObjectLazy(id);
  }

  Stream<SettingsEntity?> getStreamByEnum(EnumsOfSettings e) => getStreamByNamed(e.name);
  Stream<SettingsEntity?> getStreamByNamed(String name) {
    return settingsUseCase.getStream(getByNamed(name)?.id! ?? 0);
  }

  SettingsEntity? getByEnum(EnumsOfSettings e) => getByNamed(e.name);
  SettingsEntity? getByNamed(String name) {
    final id = fastHash(name);
    final setting = fullMap.values.where((element) => element.setting?.id == id).firstOrNull?.setting;
    if (setting == null) {
      final newSetting = tryGetNewSettingFromDefaults(name);
      if (newSetting != null) {
        add(SettingsBlocEvent.update(item: newSetting));
        add(const SettingsBlocEvent.load(SettingsSearchEntity()));
      }
      return newSetting?.toType();
    }
    return setting;
  }

  //GET BY ID
  Future<SettingsDescriptionEntity?> getDescriptionById(int? itemId) async {
    return itemId != null
        ? await settingsDescriptionBlocHelper.getById(itemId, (e) {
            if (kDebugMode) log("settingsDescriptionBloc.getById error:$e");
          })
        : null;
  }

  Future<SettingsDescriptionEntity?> getDescriptionByNamed(String name) async {
    final id = fastHash(name);
    final result = await getDescriptionById(id);
    if (result == null) {
      return tryGetNewSettingDescriptionFromDefaults(id);
    }
    return result;
  }

  SettingsDescriptionEntity? tryGetNewSettingDescriptionFromDefaults(int id) {
    SettingsDescriptionEntity? newSettingDescription = defaults.getDefaultSettingDescriptionList
        .where((element) => element.id == id)
        .firstOrNull;
    newSettingDescription =
        newSettingDescription ??
        settingsDefaultData.getDefaultSettingDescriptionList.where((element) => element.id == id).firstOrNull;

    return newSettingDescription;
  }

  SettingsEntity? tryGetNewSettingFromDefaults(String name) {
    SettingsEntity? newSetting = defaults.getDefaultSettingList.where((element) => element.name == name).firstOrNull;
    newSetting =
        newSetting ?? settingsDefaultData.getDefaultSettingList.where((element) => element.name == name).firstOrNull;

    return newSetting;
  }

  int? getIdByNamed(String name) {
    return getByNamed(name)?.id;
  }

  int? getIdByEnum(EnumsOfSettings e) => getIdByNamed(e.name);

  @override
  Future<SettingsEntity?> getById(int? itemId) async => itemId != null ? getByIdSync(itemId) : null;

  SettingsEntity getByIdSync(int? itemId) {
    return fullMap[itemId]?.setting ??
        SettingsEntity(
          id: null,
          name: GetIt.instance<CoreI18n>().newSetting,
          defaultValue: "",
          userValue: null,
          confirmType: null,
          type: SettingsTypeEnum.string.index,
          values: null,
          isDeleted: false,
        );
  }

  List<SettingsEntity> getListStartedWithNamed(String startedWith) {
    return fullMap.values
        .where((element) => element.name.startsWith(startedWith))
        .map((e) => e.setting)
        .whereType<SettingsEntity>()
        .toList();
  }

  String? getUserOrDefaultValueByNamed(String name) {
    final item = getByNamed(name);
    final value = item?.getUserOrDefaultValueAsString;
    final asInt = int.tryParse(value ?? "");
    return item?.type == SettingsTypeEnum.value.index
        ? asInt != null
              ? item?.values![asInt]
              : value
        : value;
  }

  String? getUserOrDefaultValueByEnum(EnumsOfSettings e) => getUserOrDefaultValueByNamed(e.name);

  List<String> getStringsListUserOrDefaultValueByNamed(String name) {
    return getUserOrDefaultValueByNamed(name)?.split(",") ?? [];
  }

  String? getValueNameFromUserOrDefaultValueByNamed(String name) {
    return SettingsValue.fromEntity(getByNamed(name))?.getUserOrDefaultValueStringOrNull;
  }

  String? getValueNameFromUserOrDefaultValueByEnum(EnumsOfSettings e) =>
      getValueNameFromUserOrDefaultValueByNamed(e.name);

  ///Set darkMode from settings, add stream listener
  void themeModeChecker() {
    _themeModeChecker(getByEnum(CoreSettingsEnum.themeMode));
    themeModeStream = getStreamByEnum(CoreSettingsEnum.themeMode).listen((event) {
      _themeModeChecker(event);
    });
  }

  void _themeModeChecker(SettingsEntity? themeMode) {
    if (themeMode == null) return;
    final index = SettingsValue.fromEntity(themeMode)?.getUserOrDefaultValueIndexOrNull;
    if (index != null && themeMode.values != null) {
      if (themeMode.values![index] != "systemLight") {
        if (themeMode.values![index] == "dark") {
          Get.isDarkMode == true ? null : Get.changeThemeMode(ThemeMode.dark);
        } else if (themeMode.values![index] == "light") {
          Get.isDarkMode == false ? null : Get.changeThemeMode(ThemeMode.light);
        }
      } else {
        Get.changeThemeMode(ThemeMode.system);
      }
    }
  }

  Function(String?) updateUserValueCallback(SettingsEntity item) {
    return (newValue) => add(SettingsBlocEvent.update(item: item.copyWith(userValue: newValue)));
  }

  Future<List<SettingsEntity>> getList(SettingsSearchEntity searchEntity) async {
    return await settingsBlocHelper.getList(settingsUseCase.call(SettingsUseCaseParams(searchEntity)), (e) {
      if (kDebugMode) log("SettingsBlocEvent.getListById error:$e");
    });
  }

  @override
  Stream<SettingsEntity> get(SettingsSearchEntity searchEntity) {
    var controller = StreamController<SettingsEntity>();
    controller.add(getByIdSync(searchEntity.id));
    watchObjectLazy(searchEntity.id).listen((event) async {
      controller.add(getByIdSync(searchEntity.id));
    });
    return controller.stream;
  }
}
