import 'dart:async';

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

//TODO make as fifo
//TODO make interface and impl
class FlashMessengerHelper {
  /// * [ifYes] user say yes
  /// * [pop] user say no(button "Not save" etc)
  /// * [titleText] title
  /// * [contentText] main content
  /// * [yesText] yes button text
  /// * [noText] no button text
  static Future<void> showBottomFlash({
    required Function() ifYes,
    required Function() pop,
    required String titleText,
    required String contentText,
    required String yesText,
    required String noText,
    bool? persistent,
  }) async {
    if (Get.context != null) {
      final sc = ScrollController();
      await showFlashf(
        persistent: persistent,
        titleText: titleText,
        content: SizedBox(
          height: Get.mediaQuery.size.height * 0.8,
          child: Scrollbar(
            thumbVisibility: true,
            controller: sc,
            child: SingleChildScrollView(controller: sc, child: Text(contentText)),
          ),
        ),
        yesText: yesText,
        noText: noText,
        then: (b) async {
          if (b == true) {
            await ifYes();
          } else if (b == false) {
            pop();
          }
        },
      );
    }
  }

  /// Asks the user what to do: lock or unlock, the interface to [showBottomFlash]
  static Future<void> showBottomFlashLockItem({
    required Function({bool isLockIgnore}) saveForm,
    required Function() pop,
    required Function(bool b) setIsLock,
    required bool isLock,
  }) async => showBottomFlash(
    ifYes: () async {
      await setIsLock(!isLock);
      await saveForm(isLockIgnore: true);
    },
    pop: pop,
    titleText: isLock ? GetIt.instance<CoreI18n>().unlockConfirm : GetIt.instance<CoreI18n>().lockConfirm,
    contentText: GetIt.instance<CoreI18n>().lockWarning,
    // dismissText: GetIt.instance<CoreI18n>().stay,
    yesText: isLock ? GetIt.instance<CoreI18n>().unlock : GetIt.instance<CoreI18n>().lock,
    noText: isLock ? GetIt.instance<CoreI18n>().notUnlock : GetIt.instance<CoreI18n>().notLock,
  );

  static Future<void> showBottomFlashSearch({
    required Function() ifYes,
    required String titleText,
    required String contentText,
    required String yesText,
    required String noText,
    bool? persistent,
  }) async {
    if (Get.context != null) {
      final sc = ScrollController();
      await showFlashf(
        content: SizedBox(
          height: Get.mediaQuery.size.height * 0.8,
          child: Scrollbar(
            thumbVisibility: true,
            controller: sc,
            child: SingleChildScrollView(controller: sc, child: Text(contentText)),
          ),
        ),
        noText: noText,
        titleText: titleText,
        yesText: yesText,
        persistent: persistent,
        then: (b) async {
          if (b == true) {
            await ifYes();
          }
        },
      );
    }
  }

  /// * [ifYes] user say yes
  /// * [titleText] title
  /// * [contentText] main content
  /// * [yesText] yes button text
  /// * [noText] no button text
  static Future<void> showBottomFlashWithTextFormField({
    required Function() ifYes,
    required String titleText,
    required String contentText,
    required String yesText,
    required String noText,
    required TextEditingController editingController,
    bool? persistent,
  }) async {
    if (Get.context != null) {
      final sc = ScrollController();
      await showFlashf(
        content: Column(
          children: [
            SizedBox(
              height: Get.mediaQuery.size.height * 0.8,
              child: Scrollbar(
                thumbVisibility: true,
                controller: sc,
                child: SingleChildScrollView(controller: sc, child: Text(contentText)),
              ),
            ),
            TextFormField(controller: editingController, autofocus: true),
          ],
        ),
        noText: noText,
        titleText: titleText,
        yesText: yesText,
        persistent: persistent,
        then: (b) async {
          if (b == true) {
            await ifYes();
          }
        },
      );
    }
  }

  /// Asks the user what to do: delete or restore, the interface to [showBottomFlash]
  static Future<void> showDeleteOrRestoreBottomFlash({
    required Function() ifYes,
    required Function() pop,
    required String entityInfo,
    required bool isDeleted,
    bool? persistent,
    EdgeInsets? margin,
  }) async => showFlashf(
    then: (b) async {
      if (b == true) {
        await ifYes();
      } else if (b == false) {
        pop();
      }
    },
    persistent: persistent,
    titleText: isDeleted ? GetIt.instance<CoreI18n>().deleteConfirm : GetIt.instance<CoreI18n>().restoreConfirm,
    content: Text(
      '${GetIt.instance<CoreI18n>().doUReallyWant} ${isDeleted ? GetIt.instance<CoreI18n>().delete : GetIt.instance<CoreI18n>().restore} $entityInfo?',
    ),
    yesText: isDeleted ? GetIt.instance<CoreI18n>().delete : GetIt.instance<CoreI18n>().restore,
    noText: isDeleted ? GetIt.instance<CoreI18n>().notDelete : GetIt.instance<CoreI18n>().notRestore,
  );

  static Future<void> showErrorBarText({required String text}) async {
    if (Get.context != null) {
      final sc = ScrollController();
      await Get.context!.showErrorBar(
        content: SizedBox(
          height: Get.mediaQuery.size.height * 0.8,
          child: Scrollbar(
            thumbVisibility: true,
            controller: sc,
            child: SingleChildScrollView(controller: sc, child: Text(text)),
          ),
        ),
      );
    }
  }

  static Future<void> showFlashf({
    required String titleText,
    required Widget content,
    required String yesText,
    required String noText,
    required Function(Object? showFlashThen) then,
    Duration? duration,
    bool? persistent,
  }) async {
    await showFlash(
      context: Get.context!,
      persistent: persistent ?? true,
      barrierBlur: 3,
      barrierColor: Colors.black38,
      barrierDismissible: true,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          // useSafeArea: true,
          controller: controller,
          // behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          // boxShadows: const [BoxShadow(blurRadius: 4)],
          // borderRadius: BorderRadius.circular(8.0),
          // borderColor: Colors.blue.shade800,
          // boxShadows: kElevationToShadow[8],
          // backgroundGradient: const RadialGradient(
          //   colors: [Colors.blue, Colors.black87],
          //   center: Alignment.topLeft,
          //   radius: 2,
          // ),
          // onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: FlashBar(
              title: SingleChildScrollView(child: Text(titleText)),
              showProgressIndicator: true,
              content: content,
              indicatorColor: Colors.deepPurple,
              icon: Icon(IconsHelper.getIconDataByEnum(IconSettingsEnum.info), size: 40),
              // primaryAction: TextButton(
              //   onPressed: () => controller.dismiss(),
              //   child: Text(dismissText),
              // ),
              actions: <Widget>[
                TextButton(onPressed: () => controller.dismiss(true), child: Text(yesText)),
                TextButton(onPressed: () => controller.dismiss(false), child: Text(noText)),
              ],
              controller: controller,
            ),
          ),
        );
      },
    ).then(then);
  }

  static Future<void> showInfoBar({required String text, Duration? duration}) async {
    final sc = ScrollController();
    if (Get.context != null) {
      await Get.context!.showInfoBar(
        content: SizedBox(
          height: Get.mediaQuery.size.height * 0.8,
          child: Scrollbar(
            thumbVisibility: true,
            controller: sc,
            child: SingleChildScrollView(controller: sc, child: Text(text)),
          ),
        ),
        duration: duration ?? const Duration(seconds: 10),
        primaryActionBuilder: (context, controller) {
          return TextButton(
            onPressed: () => controller.dismiss(true),
            child: const Text('Ok', style: TextStyle(color: Colors.amber)),
          );
        },
      );
    }
  }

  /// * [text]
  /// * [buttonText]
  /// * [showItemNavigator] callback tap to button with [buttonText], usually RouteHelper.toNamed to right now created item
  /// * [duration] ?? const Duration(seconds: 3)
  /// * [doNotShowSettingsName] SettingsEntity name, what setted by 'Do Not Show Again!',
  /// used in [`setNextSettingsVariantByName`], this value not checked in this place!
  static Future<void> showInfoBarText({
    required String text,
    required void Function()? showItemNavigator,
    required String doNotShowSettingsName,
    String? buttonText,
    Duration? duration,
  }) async {
    if (Get.context != null) {
      final sc = ScrollController();
      await Get.context!.showInfoBar(
        content: SizedBox(
          height: Get.mediaQuery.size.height * 0.8,
          child: Scrollbar(
            thumbVisibility: true,
            controller: sc,
            child: SingleChildScrollView(controller: sc, child: Text(text)),
          ),
        ),
        duration: duration ?? const Duration(seconds: 3),
        primaryActionBuilder: (context, controller) {
          return Column(
            children: [
              TextButton(
                onPressed: () => FunctionsHelper.setNextSettingsVariantByName(name: doNotShowSettingsName),
                child: Text(GetIt.instance<CoreI18n>().settingsDoNotShowAgain, style: TextStyle(color: Colors.amber)),
              ),
              if (showItemNavigator != null)
                TextButton(
                  onPressed: showItemNavigator,
                  child: Text(
                    buttonText ?? GetIt.instance<CoreI18n>().sHOW,
                    style: const TextStyle(color: Colors.amber),
                  ),
                ),
            ],
          );
        },
      );
    }
  }

  /// Asks the user what to do with the changes, the interface to [showBottomFlash]
  static Future<void> showSaveBottomFlash({
    required Function() ifYes,
    required Function() pop,
    required String entityInfo,
    bool? persistent,
    EdgeInsets? margin,
  }) async {
    bool? autoSave;
    autoSave = SettingsBool.fromEntity(
      GetIt.instance<SettingsBloc>().getByEnum(CoreSettingsEnum.autoSaveOnPop),
    )?.getUserValueAsBool;
    if (autoSave == true) {
      await ifYes();
      return;
    }
    unawaited(
      showBottomFlash(
        ifYes: () async {
          if (autoSave == null) {
            await showInfoBarText(
              doNotShowSettingsName: CoreSettingsEnum.autoSaveOnPop.name,
              duration: const Duration(seconds: 6),
              text: GetIt.instance<CoreI18n>().exitSaveConfirm,
              buttonText: GetIt.instance<CoreI18n>().settingChange,
              showItemNavigator: null,
            );
          }
          await ifYes();
        },
        pop: pop,
        persistent: persistent,
        titleText: GetIt.instance<CoreI18n>().saveConfirm,
        contentText:
            '${GetIt.instance<CoreI18n>().changeDataIn} $entityInfo, ${GetIt.instance<CoreI18n>().exitSaveConfirm}',
        // dismissText: GetIt.instance<CoreI18n>().stay,
        yesText: GetIt.instance<CoreI18n>().save,
        noText: GetIt.instance<CoreI18n>().notSave,
      ),
    );
  }
}
