import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/flash_messanger.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class FunctionsHelper {
  ///used in [showBottomFlashAndRevertDelete]
  static Future<void> revertDelete<T extends AppEntityWithIsDeleted>({
    required Future<int> Function(T, {bool revertDelete}) update,
    required Function() pop,
    required Function(int id) showItemNavifator,
    required T item,
    required String text,
  }) async {
    await update(item, revertDelete: true);
    await showAfterSaveItemInfobar(id: item.id!, showItemNavifator: showItemNavifator, text: text);

    await setBoolSettingInFlash(
      settingName: CoreSettingsEnum.allAfterRemoveItemReloadList.name,
      text: GetIt.instance<CoreI18n>().allAfterRemoveItemReloadList,
      duration: const Duration(seconds: 6),
    );

    pop();
  }

  /// use setting CoreSettingsEnum.allAfterSaveItemShowInfobar
  static Future<void> showAfterSaveItemInfobar({
    required String text,
    required Function(int id) showItemNavifator,
    required int id,
  }) async {
    bool settings = false;
    settings =
        SettingsBool.fromEntity(
          GetIt.instance<SettingsBloc>().getByEnum(CoreSettingsEnum.allAfterSaveItemShowInfobar),
        )?.getUserOrDefaultValueAsBool ??
        true;
    if (settings == true) {
      await FlashMessangerHelper.showInfoBarText(
        text: text,
        showItemNavifator: () => showItemNavifator(id),
        doNotShowSettingsName: CoreSettingsEnum.allAfterSaveItemShowInfobar.name,
      );
    }
  }

  static Future<void> saveItemFromForm<T extends AppEntity>({
    required Function(T item) blocAdd,
    required Function(T item) blocUpdate,
    required T item,
    required T? origItem,
    required String textSave,
    required String textValidFailed,
    required Function() pop,
    Function(int id)? doAfterSave,
    required Function(int id) showItemNavifator,
    required GlobalKey<FormState> formKey,
  }) async {
    final isUpdated = origItem != null ? item != origItem : false;
    var id = 0;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (item.id == null || item.id == 0) {
        id = await blocAdd(item);
      } else {
        if (isUpdated) {
          await blocUpdate(item);
          id = item.id!;
        } else {
          id = item.id!;
        }
      }
      if (Get.context != null && doAfterSave != null) {
        await doAfterSave(id);
      }
      await showAfterSaveItemInfobar(id: id, showItemNavifator: showItemNavifator, text: textSave);
      pop();
    } else {
      FlashMessangerHelper.showErrorBarText(text: textValidFailed);
    }
  }

  static void setNextSettingsVariantByName({required String name}) {
    setNextSettingsVariantByItem(item: GetIt.instance<SettingsBloc>().getByNamed(name));
  }

  static void setNextSettingsVariantByEnum(EnumsOfSettings e) => setNextSettingsVariantByName(name: e.name);

  static void setNextSettingsVariantById({required int id}) {
    setNextSettingsVariantByItem(item: GetIt.instance<SettingsBloc>().getByIdSync(id));
  }

  static void setNextSettingsVariantByItem({required SettingsEntity? item}) {
    if (item == null) return;
    if (item.type != SettingsTypeEnum.boolean.index && item.type != SettingsTypeEnum.value.index) {
      if (kDebugMode) {
        debugPrint("WARNING!: try use setNextSettingsVariantByName with type '${SettingsTypeEnum.values[item.type]}'");
      }
      return;
    } else if (item.type == SettingsTypeEnum.boolean.index) {
      item = SettingsBool.fromEntity(item)?.getSettingsWithNextVariant();
    } else if (item.type == SettingsTypeEnum.value.index) {
      if (item.values == null) {
        if (kDebugMode) {
          debugPrint("WARNING!: try use setNextSettingsVariantByName with type 'value', but values is empty!");
        }
        return;
      }
      item = SettingsValue.fromEntity(item)?.getSettingsWithNextVariant();
    }

    if (item == null) return;
    GetIt.instance<SettingsBloc>().add(SettingsBlocEvent.update(item: item));
  }

  static void showResetUpdateInfoBarOrFilter({required Function() filterSearchResults}) async {
    final sName = CoreSettingsEnum.searchUpdateListAfterReset.name;
    await setBoolSettingInFlash(
      settingName: sName,
      text: GetIt.instance<CoreI18n>().searchUpdateListAfterReset,
      doIfTrue: filterSearchResults,
      duration: const Duration(seconds: 6),
    );
  }

  static Future<void> setBoolSettingInFlash({
    required String settingName,
    required String text,
    Function()? doIfTrue,
    Function()? doIfFalse,
    Duration? duration,
  }) async {
    SettingsBool? setting;
    setting = SettingsBool.fromEntity(GetIt.instance<SettingsBloc>().getByNamed(settingName));

    if (setting?.getUserValueAsBool == null) {
      await FlashMessangerHelper.showFlashf(
        duration: duration,
        titleText: GetIt.instance<CoreI18n>().settingChange,
        content: Text(text),
        yesText: GetIt.instance<CoreI18n>().settingsSetAsDefault,
        noText: GetIt.instance<CoreI18n>().setup,
        then: (b) {
          if (b == true) {
            GetIt.instance<SettingsBloc>().add(
              SettingsBlocEvent.update(item: (setting as SettingsEntity).copyWith(userValue: setting?.defaultValue)),
            );
          }
          if (b == false) {
            RouteHelper.offNamedUntil(
              SettingsRouteNames.settingsViewPage,
              (route) => false,
              arguments: SettingsSearchEntity(name: settingName),
            );
          }
        },
      );
    }
    if (doIfTrue != null && setting?.getUserOrDefaultValueAsBool == true) await doIfTrue();
    if (doIfFalse != null && setting?.getUserOrDefaultValueAsBool == false) await doIfFalse();
  }

  static void showAutoSaveInfoBar() async {
    String? settings;

    settings = GetIt.instance<SettingsBloc>().getByEnum(CoreSettingsEnum.autoSaveOnPop)?.userValue;
    if (settings == null) {
      await FlashMessangerHelper.showInfoBarText(
        doNotShowSettingsName: CoreSettingsEnum.autoSaveOnPop.name,
        duration: const Duration(seconds: 6),
        text: GetIt.instance<CoreI18n>().autoSaveOnPop,
        buttonText: GetIt.instance<CoreI18n>().settingChange,
        showItemNavifator: null,
      );
    }
  }

  static T? getArgs<T extends SearchEntity>() {
    if (Get.arguments != null) {
      if (Get.arguments is T) {
        return Get.arguments as T;
      }
    }
    return null;
  }

  static T? firstLoadGetArgsItemBySearch<T extends SearchEntity, ItemT>({
    required Function(ItemT item) setItem,
    required blocGetById,
  }) {
    final argSearch = getArgs<T>();
    if (argSearch != null && argSearch.id != null) {
      blocGetById(argSearch.id!).then((value) => setItem(value));
    }
    return argSearch;
  }

  /// use [showDeleteOrRestoreBottomFlash], [revertDelete]
  static Future<void> showBottomFlashAndRevertDelete<T extends AppEntityWithIsDeleted>({
    Function()? pop,
    required dynamic item,
    required Future<int> Function(T item, {bool revertDelete}) update,
    required dynamic searchEntity,
    required String showBottomFlashText,
    required String revertDeleteText,
    required String routeName,
  }) async {
    await FlashMessangerHelper.showDeleteOrRestoreBottomFlash(
      isDeleted: item.isDeleted,
      entityInfo: showBottomFlashText,
      ifYes: () async {
        await revertDelete<T>(
          update: update,
          pop: pop ?? () {},
          item: item,
          text: revertDeleteText,
          showItemNavifator: ((_) {
            searchEntity.id = item.id;
            RouteHelper.toNamed(routeName, arguments: searchEntity);
          }),
        );
      },
      pop: () {},
    );
  }

  static bool uidValidate({required String uid, required bool Function() checkFunc}) {
    if (uid == '') {
      FlashMessangerHelper.showErrorBarText(text: GetIt.instance<CoreI18n>().uidNotSetup);
      return false;
    } else {
      if (checkFunc() == false) {
        FlashMessangerHelper.showErrorBarText(text: GetIt.instance<CoreI18n>().uidNotExist);
        return false;
      }
    }
    return true;
  }
}
