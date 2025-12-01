part of '../settings_entity.dart';

class SettingsListOfValuesExtend extends SettingsEntity {
  SettingsListOfValuesExtend({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  List<int> get getUserOrDefaultAsListOfIndexes => super.getUserOrDefaultValueAsString != ''
      ? super.getUserOrDefaultValueAsString.split(',').map(int.tryParse).whereType<int>().toList()
      : [];

  List<String> getUserOrDefaultAsListOfString(SettingsEntity? Function(String name) blocGetByNamedFunc) {
    if (values == null) return [];
    if (values!.isEmpty) return [];
    final settings = blocGetByNamedFunc(values!.first);
    if (settings == null) return [];
    return getUserOrDefaultAsListOfIndexes.map((e) => settings.values?[e]).nonNulls.toList();
  }

  List<String> getValuesFromBase(SettingsEntity? Function(String name) blocGetByNamedFunc) {
    if (values == null) return [];
    if (values!.isEmpty) return [];
    final settings = blocGetByNamedFunc(values!.first);
    if (settings == null) return [];
    if (settings.values == null) return [];
    return settings.values!;
  }

  static SettingsListOfValuesExtend? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.listOfValuesExtend.index
        ? SettingsListOfValuesExtend(
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
