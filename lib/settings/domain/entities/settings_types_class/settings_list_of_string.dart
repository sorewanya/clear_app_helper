part of '../settings_entity.dart';

class SettingsListOfString extends SettingsEntity {
  static SettingsListOfString? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.listOfString.index
        ? SettingsListOfString(
            id: item.id,
            name: item.name,
            defaultValue: item.defaultValue,
            userValue: item.userValue,
            confirmType: item.confirmType,
            type: item.type,
            values: item.values,
            isDeleted: item.isDeleted)
        : null;
  }

  SettingsListOfString(
      {required super.id,
      required super.name,
      required super.defaultValue,
      required super.userValue,
      required super.confirmType,
      required super.type,
      required super.values,
      required super.isDeleted});

  List<String> get getUserOrDefaultAsListOfString => super.getUserOrDefaultValueAsString.split(',');
}
