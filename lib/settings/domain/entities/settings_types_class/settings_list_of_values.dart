part of '../settings_entity.dart';

class SettingsListOfValues extends SettingsEntity {
  SettingsListOfValues({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  List<int> get getUserOrDefaultAsListOfIndexes =>
      super.getUserOrDefaultValueAsString.split(',').map(int.tryParse).whereType<int>().toList();

  List<String> get getUserOrDefaultAsListOfString =>
      values != null ? getUserOrDefaultAsListOfIndexes.map((e) => values![e]).toList() : [];

  bool getContainsInUserOrDefault(String name) {
    if (values == null) return false;
    return getUserOrDefaultAsListOfString.contains(name);
  }

  static SettingsListOfValues? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.listOfValues.index
        ? SettingsListOfValues(
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
