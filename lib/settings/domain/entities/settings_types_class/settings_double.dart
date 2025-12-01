part of '../settings_entity.dart';

class SettingsDouble extends SettingsEntity {
  SettingsDouble({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  double? get getUserOrDefaultValueAsDoubleOrNull => double.tryParse(super.getUserOrDefaultValueAsString);

  double get getUserOrDefaultValueAsDoubleOrZero => getUserOrDefaultValueAsDoubleOrNull ?? 0;
  static SettingsDouble? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.doublee.index
        ? SettingsDouble(
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
