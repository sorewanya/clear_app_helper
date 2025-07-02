// ignore_for_file: annotate_overrides
// dart format width=999

part of 'core_i18n.dart';

class CoreI18nRu implements CoreI18n {
  String get cachedFailureMessage => "Ошибка локальной БД. Повтор попытки каждые 5 сек.";
  String get cancel => "Отмена";
  String get caseSensitiveSearchWarning => "Поиск регистро зависим! настройка:";
  String get defaultAppBarTitle => "Clear App Helper";
  String get delete => "Удалить";
  String get emptyLocalStorageFailureMessage => "Ничего не найдено!";
  String get errorGettingItemId => "Ошибка получения itemId";
  String get loadSettingInfoToCard => "Загрузка информации о настройке в карточку";
  String get lock => "Заблокировать";
  String get makeCopy => "Создать копию";
  String get newItem => "Новый";
  String get newSetting => "Новая настройка";
  String get nodeInGraphName => "Узел";
  String get restore => "Восстановить";
  String get savedSearchFind => "Искать";
  String get savedSearchHelpText => "Используйте поле внизу для переименования";
  String get savedSearchRemove => "Удалить";
  String get savedSearchRename => "Переименовать";
  String get savedSearchSave => "Сохранить";
  String get savedSearchSaveHelpText => """Введите отображаемое название для последующего использования\n\nУчтите, что сохраняется активный, а не отредактированный запрос!\nНажмите 'Найти', проверьте, что это то, что вам нужно и только потом сохраняйте""";
  String get savedSearchSaveSearch => "Сохранить поисковый запрос";
  String get savedSearchUpdate => "Обновить";
  String get savedSearchUpdateByCurrent => "Обновить текущим";
  String get search => "Поиск";
  String get searchEmptyListMessage => "Показывать нечего, начните добавлять или измените поисковый запрос";
  String get searchName => "Название";
  String get searchResetButtonText => "Обнулить";
  String get searchShowChanged => "показать изменённые";
  String get searchShowDeleted => "показать удалённые";
  String get searchShowSettings => "Показать настройки поиска";
  String get serverFailureMessage => "Ошибка сервера! Повтор попытки каждые 5 сек.";
  String get setDefaultInSettings => "По умолчанию";
  String get settingIsNotSaved => "настройка не может быть сохранена, проверьте правильность введённых данных";
  String get settingIsSave => "Настройка сохранена";
  String get settings => "Настройки";
  String get settingUserValue => "Пользовательское значение";
  String get settingVariants => "Варианты";
  String get share => "Поделиться";
  String get validatorDoubleNotLessZero => "должно быть вещественным числом >= 0";
  String get validatorIntegerNotLessZero => "должно быть целым числом >= 0";
  String get validatorNotEmpty => "значение не указано!";
  String descriptionCoreSettingsEnum(CoreSettingsEnum setting) => switch (setting) {
    CoreSettingsEnum.viewDefault => "Открываемая по умолчанию страница",
    CoreSettingsEnum.showDeleted => "Отображать удалённые элементы? глобальная настройка",
    CoreSettingsEnum.themeMode => "Светлая/темная тема",
    CoreSettingsEnum.autoSaveOnPop => "Сохранять элемент при выходе без запроса?",
    CoreSettingsEnum.allAfterSaveItemShowInfobar => "Показывать сообщении после сохранения?",
    CoreSettingsEnum.allAfterRemoveItemReloadList => "Автоматически обновлять результаты поиска после удаления элемента?",
    CoreSettingsEnum.searchUpdateListAfterReset => "Обновлять поиск сразу при обнулении любого поля, а не по кнопке 'Найти'",
    CoreSettingsEnum.plusIntValues => "Числа для кнопок прибавления",
    CoreSettingsEnum.searchCaseSensitive => "Регистрозависимый поиск? False - поиск НЕ регистро-зависим",
    CoreSettingsEnum.datetimeDefaultPersonalFormat => "Отображение даты, пользовательский вариант, перекрывает ${CoreSettingsEnum.datetimeDefaultFormat}",
    CoreSettingsEnum.datetimeDefaultFormat => "Отображение даты, предложенные варианты",
    CoreSettingsEnum.datetimeLanguage => "Отображение даты исходя из ru/en стилистики",
    CoreSettingsEnum.searchAddParentToChildList => "Добавить родителя при поиске наследников элемента?",
    CoreSettingsEnum.globalLoggingEnable => "Включить логирование, глобально?",
    CoreSettingsEnum.globalLoggingSizeLimitType => "Тип ограничения логов,\nbyItem - сохраняется N записей логов для каждого элемента.\nbyClass - сохраняется N записей для каждого типа данных\nгде N - значение из ${CoreSettingsEnum.globalLoggingSizeLimitCount}",
    CoreSettingsEnum.globalLoggingSizeLimitCount => "Размер логов, см. ${CoreSettingsEnum.globalLoggingSizeLimitType}",
    CoreSettingsEnum.globalSwipeBaseList => "Варианты реакций на свайп в окне приложения",
    CoreSettingsEnum.globalSwipeLeftToRight => "Варианты реакций для направления вправо",
    CoreSettingsEnum.globalSwipeRightToLeft => "Варианты реакций для направления влево",
    CoreSettingsEnum.globalSwipeTopToDown => "Варианты реакций для направления вниз",
    CoreSettingsEnum.globalSwipeDownToTop => "Варианты реакций для направления вверх",
    CoreSettingsEnum.itemSwipeBaseList => "Варианты реакций на свайп элемента",
    CoreSettingsEnum.globalQuery => "Глобальный штамп",
    CoreSettingsEnum.globalTr => "Транзакция",
  };
  String descriptionSettingsSettingsEnum(SettingsSettingsEnum setting) => switch (setting) {
    SettingsSettingsEnum.viewDefault => "Отображение списка настроек в виде списка или дерева",
    SettingsSettingsEnum.loggingEnable => "Логирование изменений настроек",
    SettingsSettingsEnum.savedSearch => "Сохранённые поисковые запросы",
    SettingsSettingsEnum.typesNames => "Типы настроек в виде списка",
    SettingsSettingsEnum.version => "Хранит последнюю версию для ",
    SettingsSettingsEnum.itemSwipeLeftToRight => "Варианты реакций для направления вправо",
    SettingsSettingsEnum.itemSwipeRightToLeft => "Варианты реакций для направления влево",
  };

  String descriptionIconSettingsEnum(IconSettingsEnum setting) => switch (setting) {
    //TODO
    IconSettingsEnum.settingsItem => "Иконка для ",
    IconSettingsEnum.settingsList => "Иконка для ",
    IconSettingsEnum.settingsResetToDefault => "Иконка для ",
    IconSettingsEnum.userValue => "Иконка для ",
    IconSettingsEnum.defaultValue => "Иконка для ",
    IconSettingsEnum.info => "Иконка для ",
    IconSettingsEnum.close => "Иконка для ",
    IconSettingsEnum.searchSearch => "Иконка для ",
    IconSettingsEnum.searchReset => "Иконка для ",
    IconSettingsEnum.add => "Иконка для ",
    IconSettingsEnum.save => "Иконка для ",
    IconSettingsEnum.delete => "Иконка для ",
    IconSettingsEnum.restore => "Иконка для ",
    IconSettingsEnum.less => "Иконка для ",
    IconSettingsEnum.lessOrEqual => "Иконка для ",
    IconSettingsEnum.greater => "Иконка для ",
    IconSettingsEnum.greaterOrEqual => "Иконка для ",
    IconSettingsEnum.equal => "Иконка для ",
    IconSettingsEnum.notEqual => "Иконка для ",
    IconSettingsEnum.trueIcon => "Иконка для ",
    IconSettingsEnum.falseIcon => "Иконка для ",
    IconSettingsEnum.setTimeData => "Иконка для ",
    IconSettingsEnum.dropDown => "Иконка для ",
    IconSettingsEnum.dropUp => "Иконка для ",
    IconSettingsEnum.goBack => "Иконка для ",
    IconSettingsEnum.textShort => "Иконка для ",
    IconSettingsEnum.textMidl => "Иконка для ",
    IconSettingsEnum.textFull => "Иконка для ",
    IconSettingsEnum.textField => "Иконка для ",
    IconSettingsEnum.slider => "Иконка для ",
    IconSettingsEnum.themeLight => "Иконка для ",
    IconSettingsEnum.themeDark => "Иконка для ",
    IconSettingsEnum.themeSystem => "Иконка для ",
    IconSettingsEnum.import => "Иконка для импорта",
  };
}
