import 'package:equatable/equatable.dart';

abstract interface class AppEntity with EquatableMixin {
  AppEntity({this.id});
  final int? id;
  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson();
  AppEntity.fromJson(Map<String, dynamic> json) : id = 0;
  get copyWith => throw UnsupportedError('copyWith not implemented $runtimeType');
}

abstract mixin class AppEntityWithIsDeleted implements AppEntity {
  bool get isDeleted;
}

abstract mixin class AppEntityWithName implements AppEntity {
  String get name;
}
