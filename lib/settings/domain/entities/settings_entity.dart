import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part './settings_types_class/settings_bool.dart';
part './settings_types_class/settings_double.dart';
part './settings_types_class/settings_file_path.dart';
part './settings_types_class/settings_icon.dart';
part './settings_types_class/settings_int.dart';
part './settings_types_class/settings_list_of_int.dart';
part './settings_types_class/settings_list_of_string.dart';
part './settings_types_class/settings_list_of_values.dart';
part './settings_types_class/settings_list_of_values_extend.dart';
part './settings_types_class/settings_saved_search.dart';
part './settings_types_class/settings_value.dart';
part 'settings_entity.g.dart';

@CopyWith()
@JsonSerializable()
// ignore: avoid_implementing_value_types
class SettingsEntity with AppEntityWithIsDeleted, AppEntityWithName, EquatableMixin implements AppEntity {
  SettingsEntity({
    required this.id,
    required this.name,
    required this.defaultValue,
    required this.userValue,
    required this.confirmType,
    required this.type,
    required this.values,
    required this.isDeleted,
  });
  SettingsEntity.fromEnum({required EnumsOfSettings e, required this.defaultValue, this.values, this.confirmType})
    : id = null,
      name = e.name,
      userValue = null,
      type = e.typeIndex,
      isDeleted = false;
  factory SettingsEntity.fromJson(Map<String, dynamic> json) => _$SettingsEntityFromJson(json);
  @override
  final int? id;
  @override
  final String name;
  final String defaultValue;
  final String? userValue;
  final int? confirmType;
  final int type;

  final List<String>? values;

  @override
  final bool isDeleted;

  String get getUserOrDefaultValueAsString => userValue ?? defaultValue;

  @override
  List<Object?> get props => [name, defaultValue, userValue, confirmType, type, values, isDeleted];

  ///dont have "next" in default type, use toType() to get true implement
  // ignore: avoid_returning_this
  SettingsEntity getSettingsWithNextVariant() => this;
  @override
  Map<String, dynamic> toJson() => _$SettingsEntityToJson(this);
  SettingsEntity toType() {
    return switch (SettingsTypeEnum.values[type]) {
      SettingsTypeEnum.integer => SettingsInt.fromEntity(this) ?? this,
      SettingsTypeEnum.boolean => SettingsBool.fromEntity(this) ?? this,
      SettingsTypeEnum.icon => SettingsIcon.fromEntity(this) ?? this,
      SettingsTypeEnum.string => this,
      SettingsTypeEnum.dirPath => this,
      SettingsTypeEnum.filePath => SettingsFilePath.fromEntity(this) ?? this,
      SettingsTypeEnum.value => SettingsValue.fromEntity(this) ?? this,
      SettingsTypeEnum.listOfInt => SettingsListOfInt.fromEntity(this) ?? this,
      SettingsTypeEnum.listOfValues => SettingsListOfValues.fromEntity(this) ?? this,
      SettingsTypeEnum.listOfString => SettingsListOfString.fromEntity(this) ?? this,
      SettingsTypeEnum.listOfValuesBase => this,
      SettingsTypeEnum.listOfValuesExtend => SettingsListOfValuesExtend.fromEntity(this) ?? this,
      SettingsTypeEnum.savedSearch => SettingsSavedSearch.fromEntity(this) ?? this,
      SettingsTypeEnum.rfwWidget => this,
      SettingsTypeEnum.doublee => SettingsDouble.fromEntity(this) ?? this,
    };
  }
}
