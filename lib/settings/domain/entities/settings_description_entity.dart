import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_description_entity.g.dart';

@CopyWith()
@JsonSerializable()
// ignore: avoid_implementing_value_types
class SettingsDescriptionEntity with EquatableMixin implements AppEntity {
  SettingsDescriptionEntity({required this.id, required this.description});

  ///JSON
  factory SettingsDescriptionEntity.fromJson(Map<String, dynamic> json) => _$SettingsDescriptionEntityFromJson(json);
  @override
  // ignore: overridden_fields
  final int? id;

  final String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() => _$SettingsDescriptionEntityToJson(this);
}
