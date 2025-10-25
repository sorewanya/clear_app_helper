part of '../settings_entity.dart';

class SettingsValue extends SettingsEntity {
  SettingsValue({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });

  int? get getUserOrDefaultValueIndexOrNull => int.tryParse(super.getUserOrDefaultValueAsString);

  int get getUserOrDefaultValueIndexOrZero => getUserOrDefaultValueIndexOrNull ?? 0;

  String get getUserOrDefaultValueStringOrEmpty => getUserOrDefaultValueStringOrNull ?? '';

  String? get getUserOrDefaultValueStringOrNull {
    final asInt = int.tryParse(userValue ?? defaultValue);
    return asInt != null
        ? values != null
              ? values![asInt]
              : ''
        : '';
  }

  @override
  SettingsEntity getSettingsWithNextVariant() {
    final index = getUserOrDefaultValueIndexOrNull;
    return values != null && index != null
        // ignore: avoid_dynamic_calls
        ? copyWith(userValue: values!.length - 1 > index ? (index + 1).toString() : '0') as SettingsValue
        : this;
  }

  bool getUserOrDefaultCompareToNamedOfValues(String name) {
    if (values == null) return false;
    return getUserOrDefaultValueIndexOrNull == values!.indexOf(name);
  }

  static SettingsValue? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.value.index
        ? SettingsValue(
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
