import 'package:clear_app_helper/core/datasources/remote_data_source.dart';

import '../../domain/entities/test_entity.dart';

class TaskStatusRemoteDataSource implements RemoteDataSource {
  Future<List<TestEntity>> getAll() {
    throw UnimplementedError();
  }
}
