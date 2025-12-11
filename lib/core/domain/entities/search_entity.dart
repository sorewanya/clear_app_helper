abstract class SearchEntity {
  SearchEntity();
  // ignore: avoid_unused_constructor_parameters
  SearchEntity.fromJson(Map<String, dynamic> json);
  int? get id => null;
  String? get viewStyle => null;
  SearchEntity copyWithId(int id);
  bool isEmpty() => true;
  Map<String, dynamic> toJson();
}
