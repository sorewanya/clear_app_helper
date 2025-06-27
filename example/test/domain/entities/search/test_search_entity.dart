import 'package:clear_app_helper/core/domain/entities/search_element.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

class TestSearchEntity implements SearchEntity {
  const TestSearchEntity({this.viewStyle, this.id, this.title, this.isDeleted, this.createdOn});
  @override
  final String? viewStyle;
  @override
  final int? id;
  final String? title;
  final bool? isDeleted;
  final TestSearchCreatedOn? createdOn;

  factory TestSearchEntity.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();

  @override
  bool isEmpty() => this == const TestSearchEntity() ? true : false;

  @override
  get copyWith => throw UnimplementedError();
}

class TestSearchCreatedOn extends SearchElement with SearchElementDateTimeComparisons {
  TestSearchCreatedOn();
  factory TestSearchCreatedOn.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  Map<String, dynamic> toJson() => throw UnimplementedError();
}
