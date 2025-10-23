abstract class SearchEntity {
  SearchEntity();
  String? get viewStyle => null;
  int? get id => null;
  bool isEmpty() => true;
  // ignore: avoid_unused_constructor_parameters
  SearchEntity.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  dynamic get copyWith => throw UnsupportedError('copyWith not implemented $runtimeType');
}
