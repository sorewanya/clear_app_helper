import 'package:clear_app_helper/core/domain/entities/app_entity.dart';

abstract class DBHelper<T extends AppEntity> {
  ///Global setting: Case sensitive in search queries
  bool getCaseSensitiveSettings();

  ///Global setting: whether to show the parent when searching for heirs
  bool getSearchAddParentToChildListSettings();

  ///Global setting: show deleted
  bool getShowDeletedSettings();

  Future<T?> getById({required int id});

  T? getSyncById({required int id});

  Future<List<int>> addMany({required List<T> itemList});

  List<int> addManySync({required List<T> itemList});

  List<int>? addManyDefaultSync({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxnSync,
  });

  Future<int> update({required T item});

  ///It deletes, not sets the value [isDeleted]!
  Future<bool> delete(int id);

  ///It deletes, not sets the value [isDeleted]!
  Future<int> deleteMany(List<int> ids);

  ///It deletes, not sets the value [isDeleted]!
  Future<void> deleteAll();

  int updateSync({required T item});

  Future<int> add({required T item});

  int addSync({required T item});

  Stream<T?> watchObject(id);

  Stream<void> watchObjectLazy(int? id);

  Stream<void> watchLazy();
}

mixin DBLogsHelper<T extends AppEntity> on DBHelper<T> {
  bool isLoggingEnabled();

  (int? type, int? count) loggingSizeLimited();

  Future checkAndRemoveByCount(int count, bool byItem, int id);

  Future<int> addLog({required T item, required id});

  @override
  int addSync({required T item});
}
