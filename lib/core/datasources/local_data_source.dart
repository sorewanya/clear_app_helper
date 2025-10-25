import 'package:clear_app_helper/core/datasources/db_helper.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

mixin LDSWithDelete<Type extends AppEntity, SEType extends SearchEntity> on LocalDataSource<Type, SEType> {
  Future<bool> delete(int id);
  Future<void> deleteAll();
  Future<int> deleteMany(List<int> ids);
}

mixin LDSWithRevertDelete<Type extends AppEntity, SEType extends SearchEntity> on LocalDataSource<Type, SEType> {
  Future<int> revertDelete(Type item);
}

// ignore: avoid_types_as_parameter_names
abstract class LocalDataSource<Type extends AppEntity, SEType extends SearchEntity> {
  LocalDataSource();
  late DBHelper<Type> dbHelper;
  DBLogsHelper? dbLogsHelper;
  Future<int> add(Type item);

  Future<List<int>> addMany(List<Type> itemList);
  Future<int> countOfFinded(SEType searchEntity);

  Future<List<Type>> getAll(SEType searchEntity);
  Future<List<int>> getAllIds(SEType searchEntity);

  Future<Type?> getById(int id) async {
    return dbHelper.getById(id: id);
  }

  Stream<Type?> getStream(int id) {
    return dbHelper.watchObject(id);
  }

  void setHelpers(DBHelper<Type> dbHelper, [DBLogsHelper? dbLogsHelper]) {
    this.dbHelper = dbHelper;
    this.dbLogsHelper = dbLogsHelper;
  }

  Future<int> update(Type item);

  Stream<List<Type>?> watch(SEType searchEntity);
  Stream<void> watchLazy() {
    return dbHelper.watchLazy();
  }

  Stream<void> watchObjectLazy(int? id) {
    return dbHelper.watchObjectLazy(id);
  }
}
