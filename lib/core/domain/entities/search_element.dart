import 'package:clear_app_helper/core/domain/entities/comparison_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_element.g.dart';

@JsonSerializable()
class SearchElement {
  SearchElement();
  factory SearchElement.fromJson(Map<String, dynamic> json) => _$SearchElementFromJson(json);
}

@JsonSerializable()
class SearchCreatedOn extends SearchElement with SearchElementDateTimeComparisons {
  SearchCreatedOn();
  factory SearchCreatedOn.fromJson(Map<String, dynamic> json) => _$SearchCreatedOnFromJson(json);
}

@JsonSerializable()
class SearchUpdatedOn extends SearchElement with SearchElementDateTimeComparisons {
  SearchUpdatedOn();
  factory SearchUpdatedOn.fromJson(Map<String, dynamic> json) => _$SearchUpdatedOnFromJson(json);
}

mixin SearchElementDateTimeComparisons on SearchElement {
  List<ComparisonDateTime> comparisonList = [];
}

mixin SearchElementIntegerComparisons on SearchElement {
  List<ComparisonInteger> comparisonList = [];
}
mixin SearchElementDoubleComparisons on SearchElement {
  List<ComparisonDouble> comparisonList = [];
}

mixin SearchElementIntSet on SearchElement {
  Set<int> intSet = {};
}
mixin SearchElementStringSet on SearchElement {
  Set<String> stringSet = {};
}
