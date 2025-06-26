abstract class SearchEntity {
  SearchEntity();
  String? get viewStyle => null;
  int? get id => null;
  bool isEmpty() => true;
  SearchEntity.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  get copyWith => throw UnsupportedError('copyWith not implemented');
}
