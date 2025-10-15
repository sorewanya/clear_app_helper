import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_description_search_entity.g.dart';

@JsonSerializable()
@CopyWith()
class SettingsDescriptionSearchEntity implements SearchEntity {
  const SettingsDescriptionSearchEntity({this.id, this.description});
  @override
  final int? id;
  final String? description;

  factory SettingsDescriptionSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$SettingsDescriptionSearchEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SettingsDescriptionSearchEntityToJson(this);

  @override
  bool isEmpty() => this == const SettingsDescriptionSearchEntity();

  @override
  String? get viewStyle => null;

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  dynamic get copyWith => _$SettingsDescriptionSearchEntityCWProxyImpl;
}
