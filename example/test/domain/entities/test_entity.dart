import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasouces/examples_impl.dart';

class TestEntity extends AppEntity with AppEntityWithIsDeleted {
  @override
  // ignore: overridden_fields
  final int? id;
  final String uid;
  final String title;

  TestEntity({required this.id, required this.uid, required this.title});

  @override
  List<Object?> get props => [uid, title, isDeleted];

  ///JSON
  factory TestEntity.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class TestLog with EquatableMixin implements ExampleLog {
  @override
  final int? id;
  @override
  final DateTime timestamp;
  @override
  final int itemId;
  final String jsonString;

  TestLog({required this.itemId, required this.jsonString, this.id}) : timestamp = DateTime.now();
  //Equatable
  @override
  List<Object?> get props => [id, timestamp, itemId, jsonString];
  //END Equatable
  ///JSON
  factory TestLog.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}
