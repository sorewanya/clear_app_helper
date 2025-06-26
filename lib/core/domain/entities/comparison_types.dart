import 'package:clear_app_helper/core/domain/entities/comparison.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comparison_types.g.dart';

abstract class ComparisonTypes {
  final Comparison comparison;
  ComparisonTypes({required this.comparison});
}

@JsonSerializable()
@CopyWith()
class ComparisonDateTime implements ComparisonTypes {
  const ComparisonDateTime({required this.value, required this.comparison});
  final DateTime value;
  @override
  final Comparison comparison;

  factory ComparisonDateTime.fromJson(Map<String, dynamic> json) => _$ComparisonDateTimeFromJson(json);
}

@JsonSerializable()
@CopyWith()
class ComparisonInteger implements ComparisonTypes {
  const ComparisonInteger({required this.value, required this.comparison});
  final int value;
  @override
  final Comparison comparison;

  factory ComparisonInteger.fromJson(Map<String, dynamic> json) => _$ComparisonIntegerFromJson(json);
}

@JsonSerializable()
@CopyWith()
class ComparisonDouble implements ComparisonTypes {
  const ComparisonDouble({required this.value, required this.comparison});
  final double value;
  @override
  final Comparison comparison;

  factory ComparisonDouble.fromJson(Map<String, dynamic> json) => _$ComparisonDoubleFromJson(json);
}
