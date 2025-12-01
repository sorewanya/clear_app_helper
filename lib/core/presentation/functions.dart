import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/flash_messenger.dart';
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
  static T? getArgs<T extends SearchEntity>() {
    if (Get.arguments != null) {
      if (Get.arguments is T) {
        return Get.arguments as T;
      }
    }
    return null;
  }

  ///used in [showBottomFlashAndRevertDelete]
  static Future<void> revertDelete<T extends AppEntityWithIsDeleted>({
    required Future<int> Function(T, {bool revertDelete}) update,
    required Function() pop,
    required Function(int id) showItemNavigator,
    required T item,
    required String text,
  }) async {
    await update(item, revertDelete: true);
    await showAfterSaveItemInfobar(id: item.id!, showItemNavigator: showItemNavigator, text: text);

    await setBoolSettingInFlash(
      settingName: CoreSettingsEnum.allAfterRemoveItemReloadList.name,
      text: GetIt.instance<CoreI18n>().allAfterRemoveItemReloadList,
      duration: const Duration(seconds: 6),
    );

    pop();
  }

  static Future<void> saveItemFromForm<T extends AppEntity>({
    required Future<int> Function(T item) blocAdd,
    required Future<int> Function(T item) blocUpdate,
    required T item,
    required T? origItem,
    required String textSave,
    required String textValidFailed,
    required Function() pop,
    required Function(int id) showItemNavigator,
    required GlobalKey<FormState> formKey,
    Function(int id)? doAfterSave,
  }) async {
    final isUpdated = item != origItem;
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
      await showAfterSaveItemInfobar(id: id, showItemNavigator: showItemNavigator, text: textSave);
      pop();
    } else {
      await FlashMessengerHelper.showErrorBarText(text: textValidFailed);
    }
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
      await FlashMessengerHelper.showFlashf(
        duration: duration,
        titleText: GetIt.instance<CoreI18n>().settingChange,
        content: Text(text),
        yesText: GetIt.instance<CoreI18n>().settingsSetAsDefault,
        noText: GetIt.instance<CoreI18n>().setup,
        then: (b) {
          if (b == true) {
            if (setting != null) {
              GetIt.instance<SettingsBloc>().add(
                SettingsBlocEvent.update(item: setting.copyWith(userValue: setting.defaultValue)),
              );
            }
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

  static void setNextSettingsVariantByEnum(EnumsOfSettings e) => setNextSettingsVariantByName(name: e.name);

  static void setNextSettingsVariantById({required int id}) {
    setNextSettingsVariantByItem(item: GetIt.instance<SettingsBloc>().getByIdSync(id));
  }

  static void setNextSettingsVariantByItem({required SettingsEntity? item}) {
    SettingsEntity? result;
    if (item == null) return;
    if (item.type != SettingsTypeEnum.boolean.index && item.type != SettingsTypeEnum.value.index) {
      if (kDebugMode) {
        debugPrint("WARNING!: try use setNextSettingsVariantByName with type '${SettingsTypeEnum.values[item.type]}'");
      }
      return;
    } else if (item.type == SettingsTypeEnum.boolean.index) {
      result = SettingsBool.fromEntity(item)?.getSettingsWithNextVariant();
    } else if (item.type == SettingsTypeEnum.value.index) {
      if (item.values == null) {
        if (kDebugMode) {
          debugPrint("WARNING!: try use setNextSettingsVariantByName with type 'value', but values is empty!");
        }
        return;
      }
      result = SettingsValue.fromEntity(item)?.getSettingsWithNextVariant();
    }

    if (result == null) return;
    GetIt.instance<SettingsBloc>().add(SettingsBlocEvent.update(item: result));
  }

  static void setNextSettingsVariantByName({required String name}) {
    setNextSettingsVariantByItem(item: GetIt.instance<SettingsBloc>().getByNamed(name));
  }

  /// use setting CoreSettingsEnum.allAfterSaveItemShowInfobar
  static Future<void> showAfterSaveItemInfobar({
    required String text,
    required Function(int id) showItemNavigator,
    required int id,
  }) async {
    bool settings = false;
    settings =
        SettingsBool.fromEntity(
          GetIt.instance<SettingsBloc>().getByEnum(CoreSettingsEnum.allAfterSaveItemShowInfobar),
        )?.getUserOrDefaultValueAsBool ??
        true;
    if (settings) {
      await FlashMessengerHelper.showInfoBarText(
        text: text,
        showItemNavigator: () => showItemNavigator(id),
        doNotShowSettingsName: CoreSettingsEnum.allAfterSaveItemShowInfobar.name,
      );
    }
  }

  static Future<void> showAutoSaveInfoBar() async {
    String? settings;

    settings = GetIt.instance<SettingsBloc>().getByEnum(CoreSettingsEnum.autoSaveOnPop)?.userValue;
    if (settings == null) {
      await FlashMessengerHelper.showInfoBarText(
        doNotShowSettingsName: CoreSettingsEnum.autoSaveOnPop.name,
        duration: const Duration(seconds: 6),
        text: GetIt.instance<CoreI18n>().autoSaveOnPop,
        buttonText: GetIt.instance<CoreI18n>().settingChange,
        showItemNavigator: null,
      );
    }
  }

  /// use [`showDeleteOrRestoreBottomFlash`], [revertDelete]
  static Future<void> showBottomFlashAndRevertDelete<T extends AppEntityWithIsDeleted>({
    required T item,
    required Future<int> Function(T item, {bool revertDelete}) update,
    required SearchEntity searchEntity,
    required String showBottomFlashText,
    required String revertDeleteText,
    required String routeName,
    Function()? pop,
  }) async {
    await FlashMessengerHelper.showDeleteOrRestoreBottomFlash(
      isDeleted: item.isDeleted,
      entityInfo: showBottomFlashText,
      ifYes: () async {
        await revertDelete<T>(
          update: update,
          pop: pop ?? () {},
          item: item,
          text: revertDeleteText,
          showItemNavigator: (_) =>
              RouteHelper.toNamed(routeName, arguments: (searchEntity as dynamic).copyWith(id: item.id)),
        );
      },
      pop: () {},
    );
  }

  static Future<void> showResetUpdateInfoBarOrFilter({required Function() filterSearchResults}) async {
    final sName = CoreSettingsEnum.searchUpdateListAfterReset.name;
    await setBoolSettingInFlash(
      settingName: sName,
      text: GetIt.instance<CoreI18n>().searchUpdateListAfterReset,
      doIfTrue: filterSearchResults,
      duration: const Duration(seconds: 6),
    );
  }

  static bool uidValidate({required String uid, required bool Function() checkFunc}) {
    if (uid == '') {
      FlashMessengerHelper.showErrorBarText(text: GetIt.instance<CoreI18n>().uidNotSetup);
      return false;
    } else {
      if (!checkFunc()) {
        FlashMessengerHelper.showErrorBarText(text: GetIt.instance<CoreI18n>().uidNotExist);
        return false;
      }
    }
    return true;
  }
}
