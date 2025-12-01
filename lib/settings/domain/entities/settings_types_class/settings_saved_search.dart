part of '../settings_entity.dart';

class SettingsSavedSearch extends SettingsEntity {
  SettingsSavedSearch({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  static SettingsSavedSearch? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.savedSearch.index
        ? SettingsSavedSearch(
            id: item.id,
            name: item.name,
            defaultValue: item.defaultValue,
            userValue: item.userValue,
            confirmType: item.confirmType,
            type: item.type,
            values: item.values,
            isDeleted: item.isDeleted,
          )
        : null;
  }
}
