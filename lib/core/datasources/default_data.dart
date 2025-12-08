// ignore_for_file: unnecessary_late

import 'dart:convert';

import 'package:clear_app_helper/core/domain/entities/item_actions.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/hash_func.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_description_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_required_types.dart';
import 'package:crypto/crypto.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final currentTime = DateTime.now().toString();

SettingsEntity coreSettingsEnumSettings(CoreSettingsEnum e) => switch (e) {
  CoreSettingsEnum.viewDefault => SettingsEntity.fromEnum(e: e, defaultValue: '0', values: ['settings']),
  CoreSettingsEnum.showDeleted => SettingsEntity.fromEnum(e: e, defaultValue: 'false'),
  CoreSettingsEnum.themeMode => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '2',
    values: ['dark', 'light', 'systemLight'],
  ),
  CoreSettingsEnum.autoSaveOnPop => SettingsEntity.fromEnum(e: e, defaultValue: 'false'),
  CoreSettingsEnum.allAfterSaveItemShowInfobar => SettingsEntity.fromEnum(e: e, defaultValue: 'true'),
  CoreSettingsEnum.allAfterRemoveItemReloadList => SettingsEntity.fromEnum(
    e: e,
    defaultValue: 'false',
    confirmType: SettingsRequiredTypesEnum.requiredStop.index,
  ),
  CoreSettingsEnum.searchUpdateListAfterReset => SettingsEntity.fromEnum(e: e, defaultValue: 'true'),
  CoreSettingsEnum.plusIntValues => SettingsEntity.fromEnum(e: e, defaultValue: '1,5,10,30'),
  CoreSettingsEnum.searchCaseSensitive => SettingsEntity.fromEnum(e: e, defaultValue: 'false'),
  CoreSettingsEnum.datetimeDefaultPersonalFormat => SettingsEntity.fromEnum(e: e, defaultValue: ''),
  //TODO use I18n to defaultValue
  CoreSettingsEnum.datetimeDefaultFormat => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '0',
    values: [
      'E-d/M yy, HH:mm',
      'E d/M yy, HH:mm',
      'dd MM yy, HH:mm',
      'MM dd yy, HH:mm',
      'yyyy-MM-dd hh:mm',
      'dd-MM-yyyy, HH:mm',
      'MM-dd-yyyy, HH:mm',
      'MM dd yyyy, HH:mm',
    ],
  ),
  //TODO use I18n
  CoreSettingsEnum.datetimeLanguage => SettingsEntity.fromEnum(e: e, defaultValue: '0', values: ['ru', 'en']),
  CoreSettingsEnum.searchAddParentToChildList => SettingsEntity.fromEnum(e: e, defaultValue: 'false'),
  CoreSettingsEnum.globalLoggingEnable => SettingsEntity.fromEnum(e: e, defaultValue: 'true'),
  CoreSettingsEnum.globalLoggingSizeLimitType => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '2',
    values: ['disabled', 'byItem', 'byClass'],
  ),

  /// 0 - no limit
  CoreSettingsEnum.globalLoggingSizeLimitCount => SettingsEntity.fromEnum(e: e, defaultValue: '1000'),
  //TODO
  CoreSettingsEnum.globalSwipeBaseList => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '',
    values: [
      'update.list',
      'show.actions', //1
      'edit', //2
      'delete', //3
    ],
  ),
  CoreSettingsEnum.globalSwipeLeftToRight => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '3',
    values: [CoreSettingsEnum.globalSwipeBaseList.name],
  ),
  CoreSettingsEnum.globalSwipeRightToLeft => SettingsEntity.fromEnum(e: e, defaultValue: ''),
  CoreSettingsEnum.globalSwipeTopToDown => SettingsEntity.fromEnum(e: e, defaultValue: ''),
  CoreSettingsEnum.globalSwipeDownToTop => SettingsEntity.fromEnum(e: e, defaultValue: ''),
  CoreSettingsEnum.itemSwipeBaseList => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '',
    values: ItemActionEnum.values.map((e) => e.name).toList(),
  ),
  CoreSettingsEnum.globalQuery => SettingsEntity.fromEnum(e: e, defaultValue: currentTime),
  CoreSettingsEnum.globalTr => SettingsEntity.fromEnum(
    e: e,
    defaultValue: sha512.convert(utf8.encode(currentTime)).toString(),
  ),
  CoreSettingsEnum.showChangelog => SettingsEntity.fromEnum(e: e, defaultValue: 'false'),
};

SettingsEntity iconSettingsEnumSettings(IconSettingsEnum e) => switch (e) {
  IconSettingsEnum.settingsItem => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.cogOutline.codePoint.toString(),
  ),
  IconSettingsEnum.settingsList => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.wrenchCogOutline.codePoint.toString(),
  ),
  IconSettingsEnum.settingsResetToDefault => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.backupRestore.codePoint.toString(),
  ),
  IconSettingsEnum.userValue => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.accountCogOutline.codePoint.toString(),
  ),
  IconSettingsEnum.defaultValue => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.cogs.codePoint.toString()),
  IconSettingsEnum.info => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.informationOutline.codePoint.toString(),
  ),
  IconSettingsEnum.close => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.close.codePoint.toString()),
  IconSettingsEnum.searchSearch => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.magnify.codePoint.toString()),
  IconSettingsEnum.searchReset => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.magnifyRemoveOutline.codePoint.toString(),
  ),
  IconSettingsEnum.add => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.plus.codePoint.toString()),
  IconSettingsEnum.save => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.contentSaveOutline.codePoint.toString(),
  ),
  IconSettingsEnum.delete => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.deleteForeverOutline.codePoint.toString(),
  ),
  IconSettingsEnum.restore => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.deleteRestore.codePoint.toString()),
  IconSettingsEnum.less => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.lessThan.codePoint.toString()),
  IconSettingsEnum.lessOrEqual => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.lessThanOrEqual.codePoint.toString(),
  ),
  IconSettingsEnum.greater => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.greaterThan.codePoint.toString()),
  IconSettingsEnum.greaterOrEqual => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.greaterThanOrEqual.codePoint.toString(),
  ),
  IconSettingsEnum.equal => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.equal.codePoint.toString()),
  IconSettingsEnum.notEqual => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.notEqual.codePoint.toString()),
  IconSettingsEnum.trueIcon => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.checkCircleOutline.codePoint.toString(),
  ),
  IconSettingsEnum.falseIcon => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.checkboxBlankCircleOutline.codePoint.toString(),
  ),
  IconSettingsEnum.setTimeData => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.bellAlertOutline.codePoint.toString(),
  ),
  IconSettingsEnum.dropDown => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.arrowDownDropCircle.codePoint.toString(),
  ),
  IconSettingsEnum.dropUp => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.arrowUpDropCircle.codePoint.toString(),
  ),
  IconSettingsEnum.goBack => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.arrowLeftTopBold.codePoint.toString(),
  ),
  IconSettingsEnum.textShort => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.textShort.codePoint.toString()),
  IconSettingsEnum.textMidl => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.text.codePoint.toString()),
  IconSettingsEnum.textFull => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.textLong.codePoint.toString()),
  IconSettingsEnum.textField => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.formTextbox.codePoint.toString()),
  IconSettingsEnum.slider => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.arrowExpandHorizontal.codePoint.toString(),
  ),
  IconSettingsEnum.themeLight => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.lightbulbOnOutline.codePoint.toString(),
  ),
  IconSettingsEnum.themeDark => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.lightbulbNight.codePoint.toString(),
  ),
  IconSettingsEnum.themeSystem => SettingsEntity.fromEnum(
    e: e,
    defaultValue: MdiIcons.themeLightDark.codePoint.toString(),
  ),
  IconSettingsEnum.import => SettingsEntity.fromEnum(e: e, defaultValue: MdiIcons.import.codePoint.toString()),
};

SettingsEntity settingsSettingsEnumSettings(SettingsSettingsEnum e) => switch (e) {
  SettingsSettingsEnum.viewDefault => SettingsEntity.fromEnum(e: e, defaultValue: '0', values: ['list', 'tree']),
  SettingsSettingsEnum.loggingEnable => SettingsEntity.fromEnum(e: e, defaultValue: 'true'),
  SettingsSettingsEnum.savedSearch => SettingsEntity.fromEnum(e: e, defaultValue: '', values: []),

  ///TODO blank to add new types of settings inside the app
  SettingsSettingsEnum.typesNames => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '',
    values: [
      'integer',
      'boolean',
      'icon',
      'string',
      'dirPath',
      'filePath',
      'value',
      'listOfInt',
      'listOfValues',
      'listOfString',
      'listOfValuesBase',
      'listOfValuesExtend',
      'savedSearch',
      'rfwWidget',
    ],
  ),
  SettingsSettingsEnum.version => SettingsEntity.fromEnum(e: e, defaultValue: ''),
  SettingsSettingsEnum.itemSwipeLeftToRight => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '',
    values: [CoreSettingsEnum.itemSwipeBaseList.name],
  ),
  SettingsSettingsEnum.itemSwipeRightToLeft => SettingsEntity.fromEnum(
    e: e,
    defaultValue: '',
    values: [CoreSettingsEnum.itemSwipeBaseList.name],
  ),
};

abstract class AbstractDefaultData {
  late final List<SettingsEntity> getDefaultSettingList = [];
  late final List<SettingsDescriptionEntity> getDefaultSettingDescriptionList = [];
}

class SettingsDefaultData implements AbstractDefaultData {
  @override
  late final List<SettingsEntity> getDefaultSettingList = [
    for (var e in CoreSettingsEnum.values) coreSettingsEnumSettings(e),
    for (var e in SettingsSettingsEnum.values) settingsSettingsEnumSettings(e),
    for (var e in IconSettingsEnum.values) iconSettingsEnumSettings(e),
  ];
  @override
  late final List<SettingsDescriptionEntity> getDefaultSettingDescriptionList = [
    for (var i in <String, String>{
      for (var e in CoreSettingsEnum.values) e.name: e.description,
      for (var e in SettingsSettingsEnum.values) e.name: e.description,
    }.entries)
      SettingsDescriptionEntity(id: fastHash(i.key), description: i.value),
  ];
}
