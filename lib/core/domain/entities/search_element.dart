import 'package:clear_app_helper/core/domain/entities/comparison_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_element.g.dart';

@JsonSerializable()
class SearchCreatedOn extends SearchElement with SearchElementDateTimeComparisons {
  SearchCreatedOn();
  factory SearchCreatedOn.fromJson(Map<String, dynamic> json) => _$SearchCreatedOnFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SearchCreatedOnToJson(this);
}

@JsonSerializable()
class SearchElement {
  SearchElement();
  factory SearchElement.fromJson(Map<String, dynamic> json) => _$SearchElementFromJson(json);
  Map<String, dynamic> toJson() => _$SearchElementToJson(this);
}

mixin SearchElementDateTimeComparisons on SearchElement {
  List<ComparisonDateTime> comparisonList = [];
}

mixin SearchElementDoubleComparisons on SearchElement {
  List<ComparisonDouble> comparisonList = [];
}

mixin SearchElementIntegerComparisons on SearchElement {
  List<ComparisonInteger> comparisonList = [];
}
mixin SearchElementIntSet on SearchElement {
  Set<int> intSet = {};
}

mixin SearchElementStringSet on SearchElement {
  Set<String> stringSet = {};
}

@JsonSerializable()
class SearchUpdatedOn extends SearchElement with SearchElementDateTimeComparisons {
  SearchUpdatedOn();
  factory SearchUpdatedOn.fromJson(Map<String, dynamic> json) => _$SearchUpdatedOnFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SearchUpdatedOnToJson(this);
}
