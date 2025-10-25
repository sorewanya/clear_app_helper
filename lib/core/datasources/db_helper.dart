import 'package:clear_app_helper/core/domain/entities/app_entity.dart';

abstract class DBHelper<T extends AppEntity> {
  bool defaultChecked = false;

  Future<int> add({required T item});

  Future<List<int>> addMany({required List<T> itemList});

  Future<List<int>>? addManyDefault({
    required List<T> Function() itemList,
    int? idToEmptyCheck,
    Function()? doIfAddDefaultsInsideTxn,
  });

  ///It deletes, not sets the value [`isDeleted`]!
  Future<bool> delete(int id);

  ///It deletes, not sets the value [`isDeleted`]!
  Future<void> deleteAll();

  ///It deletes, not sets the value [`isDeleted`]!
  Future<int> deleteMany(List<int> ids);

  Future<T?> getById({required int id});

  ///Global setting: Case sensitive in search queries
  bool getCaseSensitiveSettings();

  ///Global setting: whether to show the parent when searching for heirs
  bool getSearchAddParentToChildListSettings();

  ///Global setting: show deleted
  bool getShowDeletedSettings();

  Future<int> update({required T item});

  Stream<void> watchLazy();

  Stream<T?> watchObject(int id);

  Stream<void> watchObjectLazy(int? id);
}

mixin DBLogsHelper<T extends AppEntity> on DBHelper<T> {
  Future<int> addLog({required T item, required int id});

  Future<void> checkAndRemoveByCount(int count, bool byItem, int id);

  bool isLoggingEnabled();

  (int? type, int? count) loggingSizeLimited();
}
