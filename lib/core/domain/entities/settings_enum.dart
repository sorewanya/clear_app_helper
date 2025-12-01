import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:get_it/get_it.dart';

enum CoreSettingsEnum with EnumsOfSettings implements Enum {
  viewDefault,
  showDeleted,
  themeMode,
  autoSaveOnPop,
  allAfterSaveItemShowInfobar,
  allAfterRemoveItemReloadList,
  searchUpdateListAfterReset,
  plusIntValues,
  searchCaseSensitive,
  datetimeDefaultPersonalFormat,
  datetimeDefaultFormat,
  datetimeLanguage,
  searchAddParentToChildList,
  globalLoggingEnable,
  globalLoggingSizeLimitType,
  globalLoggingSizeLimitCount,
  globalSwipeBaseList,
  globalSwipeLeftToRight,
  globalSwipeRightToLeft,
  globalSwipeTopToDown,
  globalSwipeDownToTop,
  itemSwipeBaseList,
  globalQuery,
  globalTr;

  @override
  String get description => GetIt.instance.get<CoreI18n>().descriptionCoreSettingsEnum(this);

  @override
  String get name => switch (this) {
    CoreSettingsEnum.viewDefault => 'core.view.default',
    CoreSettingsEnum.showDeleted => 'core.show.deleted',
    CoreSettingsEnum.themeMode => 'core.theme.mode',
    CoreSettingsEnum.autoSaveOnPop => 'core.auto.save.on.pop',
    CoreSettingsEnum.allAfterSaveItemShowInfobar => 'core.all.after.save.item.show.infobar',
    CoreSettingsEnum.allAfterRemoveItemReloadList => 'core.all.after.remove.item.reload.list',
    CoreSettingsEnum.searchUpdateListAfterReset => 'core.search.update.list.after.reset',
    CoreSettingsEnum.plusIntValues => 'core.plus.int.values',
    CoreSettingsEnum.searchCaseSensitive => 'core.search.caseSensitive',
    CoreSettingsEnum.datetimeDefaultPersonalFormat => 'core.datetime.default.personal.format',
    CoreSettingsEnum.datetimeDefaultFormat => 'core.datetime.default.format',
    CoreSettingsEnum.datetimeLanguage => 'core.datetime.language',
    CoreSettingsEnum.searchAddParentToChildList => 'core.search.add.parent.toChildList',
    CoreSettingsEnum.globalLoggingEnable => 'core.global.logging.enable',
    CoreSettingsEnum.globalLoggingSizeLimitType => 'core.global.logging.size.limit.type',
    CoreSettingsEnum.globalLoggingSizeLimitCount => 'core.global.logging.size.limit.count',
    CoreSettingsEnum.globalSwipeBaseList => 'core.global.swipe.base.list',
    CoreSettingsEnum.globalSwipeLeftToRight => 'core.global.swipe.left.to.right',
    CoreSettingsEnum.globalSwipeRightToLeft => 'core.global.swipe.right.to.left',
    CoreSettingsEnum.globalSwipeTopToDown => 'core.global.swipe.top.to.down',
    CoreSettingsEnum.globalSwipeDownToTop => 'core.global.swipe.down.to.top',
    CoreSettingsEnum.itemSwipeBaseList => 'core.item.swipe.base.list',
    CoreSettingsEnum.globalQuery => 'core.global.query',
    CoreSettingsEnum.globalTr => 'core.global.tr',
  };

  @override
  SettingsTypeEnum get type => switch (this) {
    CoreSettingsEnum.viewDefault => SettingsTypeEnum.value,
    CoreSettingsEnum.showDeleted => SettingsTypeEnum.boolean,
    CoreSettingsEnum.themeMode => SettingsTypeEnum.value,
    CoreSettingsEnum.autoSaveOnPop => SettingsTypeEnum.boolean,
    CoreSettingsEnum.allAfterSaveItemShowInfobar => SettingsTypeEnum.boolean,
    CoreSettingsEnum.allAfterRemoveItemReloadList => SettingsTypeEnum.boolean,
    CoreSettingsEnum.searchUpdateListAfterReset => SettingsTypeEnum.boolean,
    CoreSettingsEnum.plusIntValues => SettingsTypeEnum.listOfInt,
    CoreSettingsEnum.searchCaseSensitive => SettingsTypeEnum.boolean,
    CoreSettingsEnum.datetimeDefaultPersonalFormat => SettingsTypeEnum.string,
    CoreSettingsEnum.datetimeDefaultFormat => SettingsTypeEnum.value,
    CoreSettingsEnum.datetimeLanguage => SettingsTypeEnum.value,
    CoreSettingsEnum.searchAddParentToChildList => SettingsTypeEnum.boolean,
    CoreSettingsEnum.globalLoggingEnable => SettingsTypeEnum.boolean,
    CoreSettingsEnum.globalLoggingSizeLimitType => SettingsTypeEnum.value,
    CoreSettingsEnum.globalLoggingSizeLimitCount => SettingsTypeEnum.integer,
    CoreSettingsEnum.globalSwipeBaseList => SettingsTypeEnum.listOfValuesBase,
    CoreSettingsEnum.globalSwipeLeftToRight => SettingsTypeEnum.listOfValuesExtend,
    CoreSettingsEnum.globalSwipeRightToLeft => SettingsTypeEnum.listOfValuesExtend,
    CoreSettingsEnum.globalSwipeTopToDown => SettingsTypeEnum.listOfValuesExtend,
    CoreSettingsEnum.globalSwipeDownToTop => SettingsTypeEnum.listOfValuesExtend,
    CoreSettingsEnum.itemSwipeBaseList => SettingsTypeEnum.listOfValuesBase,
    CoreSettingsEnum.globalQuery => SettingsTypeEnum.string,
    CoreSettingsEnum.globalTr => SettingsTypeEnum.integer,
  };
}

enum IconSettingsEnum with EnumsOfSettings implements Enum {
  //settings
  settingsItem,
  settingsList,
  settingsResetToDefault,
  userValue,
  defaultValue,
  //core
  info,
  close,
  searchSearch,
  searchReset,
  add,
  save,
  delete,
  restore,
  less,
  lessOrEqual,
  greater,
  greaterOrEqual,
  equal,
  notEqual,
  trueIcon,
  falseIcon,
  setTimeData,
  dropDown,
  dropUp,
  goBack,
  textShort,
  textMidl,
  textFull,
  textField,
  slider,
  //theme
  themeLight,
  themeDark,
  themeSystem,
  import;

  @override
  String get description => GetIt.instance.get<CoreI18n>().descriptionIconSettingsEnum(this);

  @override
  String get name => switch (this) {
    IconSettingsEnum.settingsItem => 'icon.settings.item',
    IconSettingsEnum.settingsList => 'icon.settings.list',
    IconSettingsEnum.settingsResetToDefault => 'icon.settings.reset.to.default',
    IconSettingsEnum.userValue => 'icon.settings.uservalue',
    IconSettingsEnum.defaultValue => 'icon.settings.defaultvalue',
    IconSettingsEnum.info => 'icon.info',
    IconSettingsEnum.close => 'icon.close',
    IconSettingsEnum.searchSearch => 'icon.search.search',
    IconSettingsEnum.searchReset => 'icon.search.reset',
    IconSettingsEnum.add => 'icon.add',
    IconSettingsEnum.save => 'icon.save',
    IconSettingsEnum.delete => 'icon.delete',
    IconSettingsEnum.restore => 'icon.restore',
    IconSettingsEnum.less => 'icon.less',
    IconSettingsEnum.lessOrEqual => 'icon.lessOrEqual',
    IconSettingsEnum.greater => 'icon.greater',
    IconSettingsEnum.greaterOrEqual => 'icon.greaterOrEqual',
    IconSettingsEnum.equal => 'icon.equal',
    IconSettingsEnum.notEqual => 'icon.notEqual',
    IconSettingsEnum.trueIcon => 'icon.true',
    IconSettingsEnum.falseIcon => 'icon.false',
    IconSettingsEnum.setTimeData => 'icon.set.timedata',
    IconSettingsEnum.dropDown => 'icon.drop.down',
    IconSettingsEnum.dropUp => 'icon.drop.up',
    IconSettingsEnum.goBack => 'icon.go.back',
    IconSettingsEnum.textShort => 'icon.text.short',
    IconSettingsEnum.textMidl => 'icon.text.midl',
    IconSettingsEnum.textFull => 'icon.text.full',
    IconSettingsEnum.textField => 'icon.text.field',
    IconSettingsEnum.slider => 'icon.slider',
    IconSettingsEnum.themeLight => 'icon.theme.light',
    IconSettingsEnum.themeDark => 'icon.theme.dark',
    IconSettingsEnum.themeSystem => 'icon.theme.system',
    IconSettingsEnum.import => 'icon.import',
  };

  @override
  SettingsTypeEnum get type => switch (this) {
    IconSettingsEnum.settingsItem => SettingsTypeEnum.icon,
    IconSettingsEnum.settingsList => SettingsTypeEnum.icon,
    IconSettingsEnum.settingsResetToDefault => SettingsTypeEnum.icon,
    IconSettingsEnum.userValue => SettingsTypeEnum.icon,
    IconSettingsEnum.defaultValue => SettingsTypeEnum.icon,
    IconSettingsEnum.info => SettingsTypeEnum.icon,
    IconSettingsEnum.close => SettingsTypeEnum.icon,
    IconSettingsEnum.searchSearch => SettingsTypeEnum.icon,
    IconSettingsEnum.searchReset => SettingsTypeEnum.icon,
    IconSettingsEnum.add => SettingsTypeEnum.icon,
    IconSettingsEnum.save => SettingsTypeEnum.icon,
    IconSettingsEnum.delete => SettingsTypeEnum.icon,
    IconSettingsEnum.restore => SettingsTypeEnum.icon,
    IconSettingsEnum.less => SettingsTypeEnum.icon,
    IconSettingsEnum.lessOrEqual => SettingsTypeEnum.icon,
    IconSettingsEnum.greater => SettingsTypeEnum.icon,
    IconSettingsEnum.greaterOrEqual => SettingsTypeEnum.icon,
    IconSettingsEnum.equal => SettingsTypeEnum.icon,
    IconSettingsEnum.notEqual => SettingsTypeEnum.icon,
    IconSettingsEnum.trueIcon => SettingsTypeEnum.icon,
    IconSettingsEnum.falseIcon => SettingsTypeEnum.icon,
    IconSettingsEnum.setTimeData => SettingsTypeEnum.icon,
    IconSettingsEnum.dropDown => SettingsTypeEnum.icon,
    IconSettingsEnum.dropUp => SettingsTypeEnum.icon,
    IconSettingsEnum.goBack => SettingsTypeEnum.icon,
    IconSettingsEnum.textShort => SettingsTypeEnum.icon,
    IconSettingsEnum.textMidl => SettingsTypeEnum.icon,
    IconSettingsEnum.textFull => SettingsTypeEnum.icon,
    IconSettingsEnum.textField => SettingsTypeEnum.icon,
    IconSettingsEnum.slider => SettingsTypeEnum.icon,
    IconSettingsEnum.themeLight => SettingsTypeEnum.icon,
    IconSettingsEnum.themeDark => SettingsTypeEnum.icon,
    IconSettingsEnum.themeSystem => SettingsTypeEnum.icon,
    IconSettingsEnum.import => SettingsTypeEnum.icon,
  };
}

enum SettingsSettingsEnum with EnumsOfSettings implements Enum {
  viewDefault,
  loggingEnable,
  savedSearch,
  typesNames,
  version,
  itemSwipeLeftToRight,
  itemSwipeRightToLeft;

  @override
  String get description => GetIt.instance.get<CoreI18n>().descriptionSettingsSettingsEnum(this);

  @override
  String get name => switch (this) {
    SettingsSettingsEnum.viewDefault => 'settings.view.default',
    SettingsSettingsEnum.loggingEnable => 'settings.logging.enable',
    SettingsSettingsEnum.savedSearch => 'settings.saved.search',
    SettingsSettingsEnum.typesNames => 'settings.types.names',
    SettingsSettingsEnum.version => 'settings.version',
    SettingsSettingsEnum.itemSwipeLeftToRight => 'settings.item.swipe.left.to.right',
    SettingsSettingsEnum.itemSwipeRightToLeft => 'settings.item.swipe.right.to.left',
  };

  @override
  SettingsTypeEnum get type => switch (this) {
    SettingsSettingsEnum.viewDefault => SettingsTypeEnum.value,
    SettingsSettingsEnum.loggingEnable => SettingsTypeEnum.boolean,
    SettingsSettingsEnum.savedSearch => SettingsTypeEnum.savedSearch,
    SettingsSettingsEnum.typesNames => SettingsTypeEnum.listOfValuesBase,
    SettingsSettingsEnum.version => SettingsTypeEnum.string,
    SettingsSettingsEnum.itemSwipeLeftToRight => SettingsTypeEnum.listOfValuesExtend,
    SettingsSettingsEnum.itemSwipeRightToLeft => SettingsTypeEnum.listOfValuesExtend,
  };
}
