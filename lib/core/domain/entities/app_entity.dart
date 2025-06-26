import 'package:equatable/equatable.dart';

abstract class AppEntity with EquatableMixin {
  AppEntity({this.id});
  final int? id;
  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson();
  AppEntity.fromJson(Map<String, dynamic> json) : id = 0;
}

mixin AppEntityWithIsDeleted on AppEntity {
  final bool isDeleted = false;
}

mixin AppEntityWithName on AppEntity {
  final String name = "";
}
