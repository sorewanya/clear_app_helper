import 'package:clear_app_helper/core/domain/entities/search_element.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

class TestSearchCreatedOn extends SearchElement with SearchElementDateTimeComparisons {
  TestSearchCreatedOn();
  // ignore: avoid_unused_constructor_parameters
  factory TestSearchCreatedOn.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class TestSearchEntity implements SearchEntity {
  const TestSearchEntity({this.viewStyle, this.id, this.title, this.isDeleted, this.createdOn});
  // ignore: avoid_unused_constructor_parameters
  factory TestSearchEntity.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  final String? viewStyle;
  @override
  final int? id;
  final String? title;
  final bool? isDeleted;

  final TestSearchCreatedOn? createdOn;
  @override
  dynamic get copyWith => throw UnimplementedError();

  @override
  bool isEmpty() => this == const TestSearchEntity();

  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}
