import 'package:clear_app_helper/core/datasources/db_helper.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

mixin LDSWithDelete<T extends AppEntity, SEType extends SearchEntity> on LocalDataSource<T, SEType> {
  Future<bool> delete(int id);
  Future<void> deleteAll();
  Future<int> deleteMany(List<int> ids);
}

mixin LDSWithRevertDelete<T extends AppEntity, SEType extends SearchEntity> on LocalDataSource<T, SEType> {
  Future<int> revertDelete(T item);
}

// ignore: avoid_types_as_parameter_names
abstract class LocalDataSource<T extends AppEntity, SEType extends SearchEntity> {
  LocalDataSource();
  late DBHelper<T> dbHelper;
  DBLogsHelper? dbLogsHelper;
  Future<int> add(T item);

  Future<List<int>> addMany(List<T> itemList);
  Future<int> countOfFinded(SEType searchEntity);

  Future<List<T>> getAll(SEType searchEntity);
  Future<List<int>> getAllIds(SEType searchEntity);

  Future<T?> getById(int id) async {
    return dbHelper.getById(id: id);
  }

  Stream<T?> getStream(int id) {
    return dbHelper.watchObject(id);
  }

  void setHelpers(DBHelper<T> dbHelper, [DBLogsHelper? dbLogsHelper]) {
    this.dbHelper = dbHelper;
    this.dbLogsHelper = dbLogsHelper;
  }

  Future<int> update(T item);

  Stream<List<T>?> watch(SEType searchEntity);
  Stream<void> watchLazy() {
    return dbHelper.watchLazy();
  }

  Stream<void> watchObjectLazy(int? id) {
    return dbHelper.watchObjectLazy(id);
  }
}
