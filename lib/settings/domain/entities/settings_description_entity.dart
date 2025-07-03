import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_description_entity.g.dart';

@CopyWith()
@JsonSerializable()
class SettingsDescriptionEntity with EquatableMixin implements AppEntity {
  @override
  // ignore: overridden_fields
  final int? id;
  final String description;
  SettingsDescriptionEntity({required this.id, required this.description});

  //Equatable
  @override
  List<Object?> get props => [description];
  //END Equatable

  ///JSON
  factory SettingsDescriptionEntity.fromJson(Map<String, dynamic> json) => _$SettingsDescriptionEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SettingsDescriptionEntityToJson(this);
  @override
  get copyWith => _$SettingsDescriptionEntityCWProxyImpl(this);
}
