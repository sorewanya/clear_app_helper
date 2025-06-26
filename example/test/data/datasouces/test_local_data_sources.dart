import 'package:clear_app_helper/core/datasources/local_data_source.dart';

import '../../domain/entities/search/test_search_entity.dart';
import '../../domain/entities/test_entity.dart';
import 'examples_impl.dart';

class TestLocalDataSource extends ExampleLocalDataSource<TestEntity, TestSearchEntity> with LDSWithRevertDelete {
  TestLocalDataSource() {
    setHelpers(ExampleDBHelper(), ExampleDBLogsHelper<TestLog>());
    addDefaults();
  }

  void addDefaults() {
    dbHelper.addManyDefaultSync(itemList: () => throw UnimplementedError());
  }

  @override
  Future<int> countOfFinded(TestSearchEntity searchEntity) async => throw UnimplementedError();
  @override
  Future<List<TestEntity>> getAll(TestSearchEntity searchEntity) async => throw UnimplementedError();
  @override
  Future<List<int>> getAllIds(TestSearchEntity searchEntity) async => throw UnimplementedError();
  @override
  Future<List<int>> addMany(List<TestEntity> itemList) async => throw UnimplementedError();
  @override
  Future<int> add(TestEntity item) async => throw UnimplementedError();
  @override
  Future<int> update(TestEntity item) async => throw UnimplementedError();
  @override
  Future<int> revertDelete(TestEntity item) async => throw UnimplementedError();
}
