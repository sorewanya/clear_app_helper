part of '../settings_entity.dart';

class SettingsIcon extends SettingsEntity {
  SettingsIcon({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  IconData? get getUserOrDefaultValueIconData => MdiIcons.fromString(super.getUserOrDefaultValueAsString);

  static SettingsIcon? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.icon.index
        ? SettingsIcon(
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
