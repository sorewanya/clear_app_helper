part of '../settings_entity.dart';

class SettingsInt extends SettingsEntity {
  SettingsInt({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  int? get getUserOrDefaultValueAsIntOrNull => int.tryParse(super.getUserOrDefaultValueAsString);

  int get getUserOrDefaultValueAsIntOrZero => getUserOrDefaultValueAsIntOrNull ?? 0;
  static SettingsInt? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.integer.index
        ? SettingsInt(
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
