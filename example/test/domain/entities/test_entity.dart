import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasouces/examples_impl.dart';

// ignore: avoid_implementing_value_types
class TestEntity with AppEntityWithIsDeleted, EquatableMixin implements AppEntity {
  TestEntity({required this.id, required this.uid, required this.title, required this.isDeleted});

  ///JSON
  // ignore: avoid_unused_constructor_parameters
  factory TestEntity.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  // ignore: overridden_fields
  final int? id;
  final String uid;

  final String title;

  @override
  final bool isDeleted;

  @override
  dynamic get copyWith => throw UnimplementedError();
  @override
  List<Object?> get props => [uid, title, isDeleted];
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class TestLog with EquatableMixin implements ExampleLog {
  TestLog({required this.itemId, required this.jsonString, this.id}) : timestamp = DateTime.now();

  ///JSON
  // ignore: avoid_unused_constructor_parameters
  factory TestLog.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  final int? id;
  @override
  final DateTime timestamp;

  @override
  final int itemId;
  final String jsonString;
  //END Equatable
  @override
  dynamic get copyWith => throw UnimplementedError();
  //Equatable
  @override
  List<Object?> get props => [id, timestamp, itemId, jsonString];
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}
