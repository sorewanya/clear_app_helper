import 'package:clear_app_helper/core/datasources/db_helper.dart';
import 'package:clear_app_helper/core/datasources/db_log.dart';
import 'package:clear_app_helper/core/datasources/local_data_source.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

///only for example, this classes implements in clear_app_helper_isar,... packages
abstract class ExampleLog extends DBLog {}

class ExampleDBLogsHelper<T extends AppEntity> implements DBLogsHelper<T> {
  ExampleDBLogsHelper();
  @override
  Future<int> add({required T item}) => throw UnimplementedError();
  @override
  Future<int> addLog({required T item, required id}) => throw UnimplementedError();
  @override
  Future<List<int>> addMany({required List<T> itemList}) => throw UnimplementedError();
  @override
  List<int>? addManyDefaultSync({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxnSync,
  }) => throw UnimplementedError();
  @override
  List<int> addManySync({required List<T> itemList}) => throw UnimplementedError();
  @override
  int addSync({required T item}) => throw UnimplementedError();
  @override
  Future checkAndRemoveByCount(int count, bool byItem, int id) => throw UnimplementedError();
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
  T? getSyncById({required int id}) => throw UnimplementedError();
  @override
  bool isLoggingEnabled() => throw UnimplementedError();
  @override
  (int?, int?) loggingSizeLimited() => throw UnimplementedError();
  @override
  Future<int> update({required T item}) => throw UnimplementedError();
  @override
  int updateSync({required T item}) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<T?> watchObject(id) => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}

class ExampleDBHelper<T extends AppEntity> implements DBHelper<T> {
  ExampleDBHelper();
  @override
  Future<int> add({required T item}) => throw UnimplementedError();
  @override
  Future<List<int>> addMany({required List<T> itemList}) => throw UnimplementedError();
  @override
  List<int>? addManyDefaultSync({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxnSync,
  }) => throw UnimplementedError();
  @override
  List<int> addManySync({required List<T> itemList}) => throw UnimplementedError();
  @override
  int addSync({required T item}) => throw UnimplementedError();
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
  T? getSyncById({required int id}) => throw UnimplementedError();
  @override
  Future<int> update({required T item}) => throw UnimplementedError();
  @override
  int updateSync({required T item}) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<T?> watchObject(id) => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}

class ExampleLocalDataSource<Type extends AppEntity, SEType extends SearchEntity>
    implements LocalDataSource<Type, SEType> {
  ExampleLocalDataSource();
  @override
  DBHelper<Type> dbHelper = ExampleDBHelper();
  @override
  DBLogsHelper<AppEntity>? dbLogsHelper;
  @override
  Future<int> add(Type item) => throw UnimplementedError();
  @override
  Future<List<int>> addMany(List<Type> itemList) => throw UnimplementedError();
  @override
  Future<int> countOfFinded(SEType searchEntity) => throw UnimplementedError();
  @override
  Future<List<Type>> getAll(SEType searchEntity) => throw UnimplementedError();
  @override
  Future<List<int>> getAllIds(SEType searchEntity) => throw UnimplementedError();
  @override
  Future getById(int id) => throw UnimplementedError();
  @override
  Stream<Type?> getStream(int id) => throw UnimplementedError();
  @override
  setHelpers(DBHelper<Type> dbHelper, [DBLogsHelper<AppEntity>? dbLogsHelper]) => throw UnimplementedError();
  @override
  Future<int> update(Type item) => throw UnimplementedError();
  @override
  Stream<void> watchLazy() => throw UnimplementedError();
  @override
  Stream<void> watchObjectLazy(int? id) => throw UnimplementedError();
}
