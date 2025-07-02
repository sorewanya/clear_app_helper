// dart format width=999

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';

part 'core_ru.dart';

///
/// Internationalization (i18n) strings for the Tomato app.
///
/// (you can use packages [easy_localization], [localization] or [slang] and make implementation of this class for your lang)
///
class CoreI18n {
  String get cachedFailureMessage => "Cache failure! Try again in 5 seconds.";
  String get cancel => "Cancel";
  String get caseSensitiveSearchWarning => "Search is case-sensitive! setting:";
  String get curentEntityLoading => "Loading CurentEntity";
  String get defaultAppBarTitle => "Clear App Helper";
  String get delete => "Delete";
  String get emptyLocalStorageFailureMessage => "Nothing found!";
  String get errorGettingItemId => "Error getting itemId";
  String get filePath => "File path";
  String get filePathAllowedExtensions => "Allowed file extensions";
  String get filePathChange => "Change file path";
  String get filePathCurent => "Current path";
  String get find => "Find";
  String get loadSettingInfoToCard => "Load setting info to card";
  String get lock => "Lock";
  String get makeCopy => "Make copy";
  String get name => "Name";
  String get newItem => "New";
  String get newSetting => "New setting";
  String get nodeInGraphName => "Node";
  String get restore => "Restore";
  String get save => "Save";
  String get savedSearchFind => "Find";
  String get savedSearchHelpText => "Use the bottom field to rename";
  String get savedSearchRemove => "Remove";
  String get savedSearchRename => "Rename";
  String get savedSearchSave => "Save";
  String get savedSearchSaveHelpText => """Enter a display name for future use\n\nNote that the active query is saved, not the edited one!\nClick 'Find', check that it is what you need and only then save""";
  String get savedSearchSaveSearch => "Save search query";
  String get savedSearchUpdate => "Update";
  String get savedSearchUpdateByCurrent => "Update current";
  String get search => "Search";
  String get searchEmptyListMessage => "Nothing to show, start adding or change the search query";
  String get searchName => "Name";
  String get searchResetButtonText => "Reset";
  String get searchShowChanged => "show changed";
  String get searchShowDeleted => "show deleted";
  String get searchShowSettings => "Show search settings";
  String get serverFailureMessage => "Server failure! Try again in 5 seconds.";
  String get setDefaultInSettings => "Default";
  String get setting => "Setting";
  String get settingAdd => "Setting Add";
  String get settingDefaultValue => "Default Value";
  String get settingEditLoading => "Load settings info to edit";
  String get settingIsNotSaved => "Setting cannot be saved, check the entered data";
  String get settingIsSave => "Setting saved";
  String get settings => "Settings";
  String get settingsBuilderStateInitial => "SettingsBuilder initial state";
  String get settingsBuilderStateLoadingError => "SettingsBuilder loading Error";
  String get settingsBuilderStateSavingError => "SettingsBuilder saving Error";
  String get settingsBuilderWork => "SettingsBuilder: work in BlocSettings";
  String get settingsFindRelatedUp => "find related(recursive up)";
  String get settingsIsRequired => "This setting has the logic of being mandatory-set by the user\nUntil the user sets the value, he will be asked for confirmation/clarification each time";
  String get settingsIsRequiredStop => "This setting has the logic of mandatory-set by the user\nUntil the user sets the value, the task associated with this setting cannot be performed";
  String get settingsList => "Settings list";
  String get settingsMainDiscription => "Settings allow users to change the functionality and appearance of the system according to their preferences.";
  String get settingsNotEditedSetting => "This setting is not editable, it stores a set of options for other settings. Values:";
  String get settingsValueNotIntWarning => "one of value in string is not int! use '1,5,10' style";
  String get settingsValueTypeError => "ERROR! Type is value, but values is empty!";
  String get settingsViewStyleDefault => "Default settings view style";
  String get settingType => "Type";
  String get settingUserValue => "UserValue";
  String get settingVariants => "Variants";
  String get settintsTypeNotFound => "Setting type not found";
  String get share => "Share";
  String get userValue => "User Value";
  String get validatorDoubleNotLessZero => "must be a double >= 0";
  String get validatorIntegerNotLessZero => "must be an integer >= 0";
  String get validatorNotEmpty => "value not specified!";
  String get viewDefaultErrorText => "error displaying viewDefault for";
  String get viewStyleList => "List";
  String get viewStyleTree => "Tree";
  String get widgetEditPartsIn => "Parts in";
  String get widgetEditSeeResult => "See result";
  String descriptionCoreSettingsEnum(CoreSettingsEnum setting) => switch (setting) {
    CoreSettingsEnum.allAfterRemoveItemReloadList => "Automatically refresh search results after deleting an item?",
    CoreSettingsEnum.allAfterSaveItemShowInfobar => "Show message after saving?",
    CoreSettingsEnum.autoSaveOnPop => "Save item on exit without prompt?",
    CoreSettingsEnum.datetimeDefaultFormat => "Date display, suggested options",
    CoreSettingsEnum.datetimeDefaultPersonalFormat => "Date display, custom option, overrides ${CoreSettingsEnum.datetimeDefaultFormat}",
    CoreSettingsEnum.datetimeLanguage => "Date display based on ru/en style",
    CoreSettingsEnum.globalLoggingEnable => "Enable logging, globally?",
    CoreSettingsEnum.globalLoggingSizeLimitCount => "Log size, see ${CoreSettingsEnum.globalLoggingSizeLimitType}",
    CoreSettingsEnum.globalLoggingSizeLimitType => "Log size limit type,\nbyItem - N log entries are saved for each item.\nbyClass - N entries are saved for each data type\nwhere N is the value from ${CoreSettingsEnum.globalLoggingSizeLimitCount}",
    CoreSettingsEnum.globalQuery => "Global stamp",
    CoreSettingsEnum.globalSwipeBaseList => "Swipe reaction options in the app window",
    CoreSettingsEnum.globalSwipeDownToTop => "Reaction options for up direction",
    CoreSettingsEnum.globalSwipeLeftToRight => "Reaction options for right direction",
    CoreSettingsEnum.globalSwipeRightToLeft => "Reaction options for left direction",
    CoreSettingsEnum.globalSwipeTopToDown => "Reaction options for down direction",
    CoreSettingsEnum.globalTr => "Transaction",
    CoreSettingsEnum.itemSwipeBaseList => "Item swipe reaction options",
    CoreSettingsEnum.plusIntValues => "Numbers for increment buttons",
    CoreSettingsEnum.searchAddParentToChildList => "Add parent when searching for item's children?",
    CoreSettingsEnum.searchCaseSensitive => "Case-sensitive search? False - search is NOT case-sensitive",
    CoreSettingsEnum.searchUpdateListAfterReset => "Update search immediately when any field is cleared, not by 'Search' button",
    CoreSettingsEnum.showDeleted => "Show deleted items? global setting",
    CoreSettingsEnum.themeMode => "Light/dark theme",
    CoreSettingsEnum.viewDefault => "Default page to open",
  };
  String descriptionSettingsSettingsEnum(SettingsSettingsEnum setting) => switch (setting) {
    SettingsSettingsEnum.itemSwipeLeftToRight => "Reaction options for right direction",
    SettingsSettingsEnum.itemSwipeRightToLeft => "Reaction options for left direction",
    SettingsSettingsEnum.loggingEnable => "Settings changes logging",
    SettingsSettingsEnum.savedSearch => "Saved search queries",
    SettingsSettingsEnum.typesNames => "Settings types as list",
    SettingsSettingsEnum.version => "Stores the last version for ",
    SettingsSettingsEnum.viewDefault => "Settings list view as list or tree",
  };
  String descriptionIconSettingsEnum(IconSettingsEnum setting) => switch (setting) {
    //TODO
    IconSettingsEnum.add => "Icon for ",
    IconSettingsEnum.close => "Icon for ",
    IconSettingsEnum.defaultValue => "Icon for ",
    IconSettingsEnum.delete => "Icon for ",
    IconSettingsEnum.dropDown => "Icon for ",
    IconSettingsEnum.dropUp => "Icon for ",
    IconSettingsEnum.equal => "Icon for ",
    IconSettingsEnum.falseIcon => "Icon for ",
    IconSettingsEnum.goBack => "Icon for ",
    IconSettingsEnum.greater => "Icon for ",
    IconSettingsEnum.greaterOrEqual => "Icon for ",
    IconSettingsEnum.import => "Icon for import",
    IconSettingsEnum.info => "Icon for ",
    IconSettingsEnum.less => "Icon for ",
    IconSettingsEnum.lessOrEqual => "Icon for ",
    IconSettingsEnum.notEqual => "Icon for ",
    IconSettingsEnum.restore => "Icon for ",
    IconSettingsEnum.save => "Icon for ",
    IconSettingsEnum.searchReset => "Icon for ",
    IconSettingsEnum.searchSearch => "Icon for ",
    IconSettingsEnum.setTimeData => "Icon for ",
    IconSettingsEnum.settingsItem => "Icon for ",
    IconSettingsEnum.settingsList => "Icon for ",
    IconSettingsEnum.settingsResetToDefault => "Icon for ",
    IconSettingsEnum.slider => "Icon for ",
    IconSettingsEnum.textField => "Icon for ",
    IconSettingsEnum.textFull => "Icon for ",
    IconSettingsEnum.textMidl => "Icon for ",
    IconSettingsEnum.textShort => "Icon for ",
    IconSettingsEnum.themeDark => "Icon for ",
    IconSettingsEnum.themeLight => "Icon for ",
    IconSettingsEnum.themeSystem => "Icon for ",
    IconSettingsEnum.trueIcon => "Icon for ",
    IconSettingsEnum.userValue => "Icon for ",
  };
}
