import 'package:clear_app_helper/core/datasources/db_helper.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

abstract class LocalDataSource<Type extends AppEntity, SEType extends SearchEntity> {
  late DBHelper<Type> dbHelper;
  DBLogsHelper? dbLogsHelper;
  LocalDataSource();
  setHelpers(DBHelper<Type> dbHelper, [DBLogsHelper? dbLogsHelper]) {
    this.dbHelper = dbHelper;
    this.dbLogsHelper = dbLogsHelper;
  }

  Future<List<int>> getAllIds(SEType searchEntity);
  Future<dynamic> getById(int id) async {
    return await dbHelper.getById(id: id);
  }

  Future<int> countOfFinded(SEType searchEntity);
  Future<List<Type>> getAll(SEType searchEntity);

  Stream<Type?> getStream(int id) {
    return dbHelper.watchObject(id);
  }

  Stream<void> watchObjectLazy(int? id) {
    return dbHelper.watchObjectLazy(id);
  }

  Stream<void> watchLazy() {
    return dbHelper.watchLazy();
  }

  Future<int> update(Type item);
  Future<int> add(Type item);
  Future<List<int>> addMany(List<Type> itemList);
}

mixin LDSWithDelete<Type extends AppEntity, SEType extends SearchEntity> on LocalDataSource<Type, SEType> {
  Future<bool> delete(int id);
  Future<void> deleteAll();
  Future<int> deleteMany(List<int> ids);
}
mixin LDSWithRevertDelete<Type extends AppEntity, SEType extends SearchEntity> on LocalDataSource<Type, SEType> {
  Future<int> revertDelete(Type item);
}
