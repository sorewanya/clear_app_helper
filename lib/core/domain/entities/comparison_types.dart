import 'package:clear_app_helper/core/domain/entities/comparison.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comparison_types.g.dart';

@JsonSerializable()
@CopyWith()
class ComparisonDateTime implements ComparisonTypes {
  const ComparisonDateTime({required this.value, required this.comparison});
  factory ComparisonDateTime.fromJson(Map<String, dynamic> json) => _$ComparisonDateTimeFromJson(json);
  final DateTime value;

  @override
  final Comparison comparison;
  Map<String, dynamic> toJson() => _$ComparisonDateTimeToJson(this);
}

@JsonSerializable()
@CopyWith()
class ComparisonDouble implements ComparisonTypes {
  const ComparisonDouble({required this.value, required this.comparison});
  factory ComparisonDouble.fromJson(Map<String, dynamic> json) => _$ComparisonDoubleFromJson(json);
  final double value;

  @override
  final Comparison comparison;
  Map<String, dynamic> toJson() => _$ComparisonDoubleToJson(this);
}

@JsonSerializable()
@CopyWith()
class ComparisonInteger implements ComparisonTypes {
  const ComparisonInteger({required this.value, required this.comparison});
  factory ComparisonInteger.fromJson(Map<String, dynamic> json) => _$ComparisonIntegerFromJson(json);
  final int value;

  @override
  final Comparison comparison;
  Map<String, dynamic> toJson() => _$ComparisonIntegerToJson(this);
}

abstract class ComparisonTypes {
  ComparisonTypes({required this.comparison});
  final Comparison comparison;
}
