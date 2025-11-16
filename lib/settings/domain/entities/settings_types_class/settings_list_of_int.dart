part of '../settings_entity.dart';

class SettingsListOfInt extends SettingsEntity {
  SettingsListOfInt({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  List<int> get getUserOrDefaultAsListOfInt => super.getUserOrDefaultValueAsString != ''
      ? super.getUserOrDefaultValueAsString.split(',').map(int.tryParse).whereType<int>().toList()
      : [];

  Set<int> get getUserOrDefaultAsSetOfInt => getUserOrDefaultAsListOfInt.toSet();
  static SettingsListOfInt? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.listOfInt.index
        ? SettingsListOfInt(
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
