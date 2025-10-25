part of '../settings_entity.dart';

class SettingsBool extends SettingsEntity {
  SettingsBool({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  bool get getUserOrDefaultValueAsBool => (super.getUserOrDefaultValueAsString) == 'true';

  bool? get getUserValueAsBool => userValue == 'true'
      ? true
      : userValue == 'false'
      ? false
      : null;
  @override
  SettingsEntity getSettingsWithNextVariant() {
    return copyWith(
      userValue: userValue == null
          ? (defaultValue == 'true' ? 'false' : 'true')
          : userValue == 'true'
          ? 'false'
          : 'true',
    );
  }

  static SettingsBool? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.boolean.index
        ? SettingsBool(
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
