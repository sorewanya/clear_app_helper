import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_search_entity.g.dart';

@JsonSerializable()
@CopyWith()
class SettingsSearchEntity implements SearchEntity {
  const SettingsSearchEntity({
    this.viewStyle,
    this.id,
    this.startWithName,
    this.name,
    this.defaultValue,
    this.userValue,
    this.type,
    this.confirmType,
    this.isDeleted,
    this.isChanged,
  });

  @override
  final String? viewStyle;
  @override
  final int? id;
  final String? startWithName;
  final String? name;
  final String? defaultValue;
  final String? userValue;
  final int? type;
  final int? confirmType;
  final bool? isDeleted;
  final bool? isChanged;

  factory SettingsSearchEntity.fromJson(Map<String, dynamic> json) => _$SettingsSearchEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SettingsSearchEntityToJson(this);

  @override
  bool isEmpty() => this == const SettingsSearchEntity() ? true : false;

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  get copyWith => _$SettingsSearchEntityCWProxyImpl(this);
}
