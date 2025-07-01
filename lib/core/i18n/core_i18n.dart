// dart format width=999

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';

part 'core_ru.dart';

///
/// Internationalization (i18n) strings for the Tomato app.
///
/// (you can use packages [easy_localization], [localization] or [slang] and make implementation of this class for your lang)
///
class CoreI18n {
  String get restore => "Restore";
  String get validatorDoubleNotLessZero => "must be a double >= 0";
  String get validatorIntegerNotLessZero => "must be an integer >= 0";
  String get validatorNotEmpty => "value not specified!";
  String get makeCopy => "Make copy";
  String get lock => "Lock";
  String get share => "Share";
  String get delete => "Delete";
  String get newItem => "New";
  String get nodeInGraphName => "Node";
  String get errorGettingItemId => "Error getting itemId";
  String get searchEmptyListMessage => "Nothing to show, start adding or change the search query";
  String get searchResetButtonText => "Reset";
  String get searchShowSettings => "Show settings";
  String get search => "Search";
  String get defaultAppBarTitle => "Clear App Helper";
  String get serverFailureMessage => "Server failure! Try again in 5 seconds.";
  String get emptyLocalStorageFailureMessage => "Nothing found!";
  String get cachedFailureMessage => "Cache failure! Try again in 5 seconds.";
  String descriptionCoreSettingsEnum(CoreSettingsEnum setting) => switch (setting) {
    CoreSettingsEnum.viewDefault => "Default page to open",
    CoreSettingsEnum.showDeleted => "Show deleted items? global setting",
    CoreSettingsEnum.themeMode => "Light/dark theme",
    CoreSettingsEnum.autoSaveOnPop => "Save item on exit without prompt?",
    CoreSettingsEnum.allAfterSaveItemShowInfobar => "Show message after saving?",
    CoreSettingsEnum.allAfterRemoveItemReloadList => "Automatically refresh search results after deleting an item?",
    CoreSettingsEnum.searchUpdateListAfterReset => "Update search immediately when any field is cleared, not by 'Search' button",
    CoreSettingsEnum.plusIntValues => "Numbers for increment buttons",
    CoreSettingsEnum.searchCaseSensitive => "Case-sensitive search? False - search is NOT case-sensitive",
    CoreSettingsEnum.datetimeDefaultPersonalFormat => "Date display, custom option, overrides ${CoreSettingsEnum.datetimeDefaultFormat}",
    CoreSettingsEnum.datetimeDefaultFormat => "Date display, suggested options",
    CoreSettingsEnum.datetimeLanguage => "Date display based on ru/en style",
    CoreSettingsEnum.searchAddParentToChildList => "Add parent when searching for item's children?",
    CoreSettingsEnum.globalLoggingEnable => "Enable logging, globally?",
    CoreSettingsEnum.globalLoggingSizeLimitType => "Log size limit type,\nbyItem - N log entries are saved for each item.\nbyClass - N entries are saved for each data type\nwhere N is the value from ${CoreSettingsEnum.globalLoggingSizeLimitCount}",
    CoreSettingsEnum.globalLoggingSizeLimitCount => "Log size, see ${CoreSettingsEnum.globalLoggingSizeLimitType}",
    CoreSettingsEnum.globalSwipeBaseList => "Swipe reaction options in the app window",
    CoreSettingsEnum.globalSwipeLeftToRight => "Reaction options for right direction",
    CoreSettingsEnum.globalSwipeRightToLeft => "Reaction options for left direction",
    CoreSettingsEnum.globalSwipeTopToDown => "Reaction options for down direction",
    CoreSettingsEnum.globalSwipeDownToTop => "Reaction options for up direction",
    CoreSettingsEnum.itemSwipeBaseList => "Item swipe reaction options",
    CoreSettingsEnum.globalQuery => "Global stamp",
    CoreSettingsEnum.globalTr => "Transaction",
  };
  String descriptionSettingsSettingsEnum(SettingsSettingsEnum setting) => switch (setting) {
    SettingsSettingsEnum.viewDefault => "Settings list view as list or tree",
    SettingsSettingsEnum.loggingEnable => "Settings changes logging",
    SettingsSettingsEnum.savedSearch => "Saved search queries",
    SettingsSettingsEnum.typesNames => "Settings types as list",
    SettingsSettingsEnum.version => "Stores the last version for ",
    SettingsSettingsEnum.itemSwipeLeftToRight => "Reaction options for right direction",
    SettingsSettingsEnum.itemSwipeRightToLeft => "Reaction options for left direction",
  };
  String descriptionIconSettingsEnum(IconSettingsEnum setting) => switch (setting) {
    //TODO
    IconSettingsEnum.settingsItem => "Icon for ",
    IconSettingsEnum.settingsList => "Icon for ",
    IconSettingsEnum.settingsResetToDefault => "Icon for ",
    IconSettingsEnum.userValue => "Icon for ",
    IconSettingsEnum.defaultValue => "Icon for ",
    IconSettingsEnum.info => "Icon for ",
    IconSettingsEnum.close => "Icon for ",
    IconSettingsEnum.searchSearch => "Icon for ",
    IconSettingsEnum.searchReset => "Icon for ",
    IconSettingsEnum.add => "Icon for ",
    IconSettingsEnum.save => "Icon for ",
    IconSettingsEnum.delete => "Icon for ",
    IconSettingsEnum.restore => "Icon for ",
    IconSettingsEnum.less => "Icon for ",
    IconSettingsEnum.lessOrEqual => "Icon for ",
    IconSettingsEnum.greater => "Icon for ",
    IconSettingsEnum.greaterOrEqual => "Icon for ",
    IconSettingsEnum.equal => "Icon for ",
    IconSettingsEnum.notEqual => "Icon for ",
    IconSettingsEnum.trueIcon => "Icon for ",
    IconSettingsEnum.falseIcon => "Icon for ",
    IconSettingsEnum.setTimeData => "Icon for ",
    IconSettingsEnum.dropDown => "Icon for ",
    IconSettingsEnum.dropUp => "Icon for ",
    IconSettingsEnum.goBack => "Icon for ",
    IconSettingsEnum.textShort => "Icon for ",
    IconSettingsEnum.textMidl => "Icon for ",
    IconSettingsEnum.textFull => "Icon for ",
    IconSettingsEnum.textField => "Icon for ",
    IconSettingsEnum.slider => "Icon for ",
    IconSettingsEnum.themeLight => "Icon for ",
    IconSettingsEnum.themeDark => "Icon for ",
    IconSettingsEnum.themeSystem => "Icon for ",
    IconSettingsEnum.import => "Icon for import",
  };
}
