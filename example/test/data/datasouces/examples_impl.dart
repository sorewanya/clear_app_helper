import 'package:clear_app_helper/core/datasources/db_helper.dart';
import 'package:clear_app_helper/core/datasources/db_log.dart';
import 'package:clear_app_helper/core/datasources/local_data_source.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

class ExampleDBHelper<T extends AppEntity> implements DBHelper<T> {
  ExampleDBHelper();
  @override
  bool defaultChecked = false;
  @override
  Future<int> add({required T item}) => throw UnimplementedError();
  @override
  Future<List<int>> addMany({required List<T> itemList}) => throw UnimplementedError();
  @override
  Future<List<int>>? addManyDefault({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxn,
  }) => throw UnimplementedError();

  @override
  Future<bool> delete(int id) => throw UnimplementedError();
  @override
  Future<void> deleteAll() => throw UnimplementedError();
  @override
  Future<int> deleteMany(List<int> ids) => throw UnimplementedError();
  @override
  Future<T?> getById({required int id}) => throw UnimplementedError();
  @override
  bool getCaseSensitiveSettings() => throw UnimplementedError();
  @override
  bool getSearchAddParentToChildListSettings() => throw UnimplementedError();
  @override
  bool getShowDeletedSettings() => throw UnimplementedError();
  @override
  Future<int> update({required T item}) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<T?> watchObject(int id) => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}

class ExampleDBLogsHelper<T extends AppEntity> implements DBLogsHelper<T> {
  ExampleDBLogsHelper();
  @override
  bool defaultChecked = false;
  @override
  Future<int> add({required T item}) => throw UnimplementedError();
  @override
  Future<int> addLog({required T item, required int id}) => throw UnimplementedError();
  @override
  Future<List<int>> addMany({required List<T> itemList}) => throw UnimplementedError();
  @override
  Future<List<int>>? addManyDefault({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxn,
  }) => throw UnimplementedError();
  int addSync({required T item}) => throw UnimplementedError();
  @override
  Future<void> checkAndRemoveByCount(int count, bool byItem, int id) => throw UnimplementedError();
  @override
  Future<bool> delete(int id) => throw UnimplementedError();
  @override
  Future<void> deleteAll() => throw UnimplementedError();
  @override
  Future<int> deleteMany(List<int> ids) => throw UnimplementedError();
  @override
  Future<T?> getById({required int id}) => throw UnimplementedError();
  @override
  bool getCaseSensitiveSettings() => throw UnimplementedError();
  @override
  bool getSearchAddParentToChildListSettings() => throw UnimplementedError();
  @override
  bool getShowDeletedSettings() => throw UnimplementedError();
  @override
  bool isLoggingEnabled() => throw UnimplementedError();
  @override
  (int?, int?) loggingSizeLimited() => throw UnimplementedError();
  @override
  Future<int> update({required T item}) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<T?> watchObject(int id) => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}

class ExampleLocalDataSource<T extends AppEntity, SEType extends SearchEntity> implements LocalDataSource<T, SEType> {
  ExampleLocalDataSource();
  @override
  DBHelper<T> dbHelper = ExampleDBHelper();
  @override
  DBLogsHelper<AppEntity>? dbLogsHelper;
  @override
  Future<int> add(T item) => throw UnimplementedError();
  @override
  Future<List<int>> addMany(List<T> itemList) => throw UnimplementedError();
  @override
  Future<int> countOfFinded(SEType searchEntity) => throw UnimplementedError();
  @override
  Future<List<T>> getAll(SEType searchEntity) => throw UnimplementedError();
  @override
  Future<List<int>> getAllIds(SEType searchEntity) => throw UnimplementedError();
  @override
  Future<T?> getById(int id) => throw UnimplementedError();
  @override
  Stream<T?> getStream(int id) => throw UnimplementedError();
  @override
  Never setHelpers(DBHelper<T> dbHelper, [DBLogsHelper<AppEntity>? dbLogsHelper]) => throw UnimplementedError();
  @override
  Future<int> update(T item) => throw UnimplementedError();
  @override
  Stream<List<T>?> watch(SEType searchEntity) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}

///only for example, this classes implements in clear_app_helper_isar,... packages
abstract class ExampleLog extends DBLog {}
