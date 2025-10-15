import 'package:equatable/equatable.dart';

abstract class AppEntity with EquatableMixin {
  AppEntity({this.id});
  final int? id;
  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson();
  // ignore: avoid_unused_constructor_parameters
  AppEntity.fromJson(Map<String, dynamic> json) : id = 0;
  dynamic get copyWith => throw UnsupportedError('copyWith not implemented $runtimeType');
}

// ignore: avoid_implementing_value_types
abstract mixin class AppEntityWithIsDeleted implements AppEntity {
  bool get isDeleted;
}

// ignore: avoid_implementing_value_types
abstract mixin class AppEntityWithName implements AppEntity {
  String get name;
}
