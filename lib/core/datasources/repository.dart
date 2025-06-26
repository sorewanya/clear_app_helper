import 'package:clear_app_helper/core/datasources/local_data_source.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/exception.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/platform/network_info.dart';
import 'package:dartz/dartz.dart';

abstract class Repository<Type extends AppEntity, SEType extends SearchEntity> {
  NetworkInfo networkInfo;
  LocalDataSource<Type, SEType> localDataSource;

  Repository({required this.networkInfo, required this.localDataSource});

  Future<Either<Failure, Type>> getById(int id) async {
    if (await networkInfo.isConnected) {
      return await tryGetLocalById(id);
    } else {
      return await tryGetLocalById(id);
    }
  }

  Future<Either<Failure, List<Type>>> getAll(SEType searchEntity) async {
    if (await networkInfo.isConnected) {
      return await tryGetLocalList(searchEntity);
    } else {
      return await tryGetLocalList(searchEntity);
    }
  }

  Future<Either<Failure, List<int>>> getAllIds(SEType searchEntity) async {
    if (await networkInfo.isConnected) {
      return await tryGetLocalIdsList(searchEntity);
    } else {
      return await tryGetLocalIdsList(searchEntity);
    }
  }

  Future<Either<Failure, int>> countOfFinded(SEType searchEntity) async {
    if (await networkInfo.isConnected) {
      return await tryGetLocalCountOfFinded(searchEntity);
    } else {
      return await tryGetLocalCountOfFinded(searchEntity);
    }
  }

  Future<Either<Failure, int>> add(Type item) async {
    try {
      int addedItem = await localDataSource.add(item);
      return Right(addedItem);
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, List<int>>> addMany(List<Type> itemList) async {
    try {
      List<int> addedItem = await localDataSource.addMany(itemList);
      return Right(addedItem);
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, int>> update(Type item) async {
    try {
      return Right(await localDataSource.update(item));
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, int>> revertDelete(Type item) async {
    try {
      if (localDataSource is LDSWithRevertDelete) {
        return Right(await (localDataSource as LDSWithRevertDelete).revertDelete(item));
      } else {
        return const Left(Failure.castDeleteOnUndeleted());
      }
    } on CacheException catch (text, stackTrace) {
      //FIXME call emit error, check
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, bool>> delete(int itemId) async {
    try {
      if (localDataSource is LDSWithDelete) {
        return Right(await (localDataSource as LDSWithDelete).delete(itemId));
      } else {
        return const Left(Failure.castDeleteOnUndeleted());
      }
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, void>> deleteAll() async {
    try {
      if (localDataSource is LDSWithDelete) {
        return Right(await (localDataSource as LDSWithDelete).deleteAll());
      } else {
        return const Left(Failure.castDeleteOnUndeleted());
      }
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, int>> deleteMany(List<int> ids) async {
    try {
      if (localDataSource is LDSWithDelete) {
        return Right(await (localDataSource as LDSWithDelete).deleteMany(ids));
      } else {
        return const Left(Failure.castDeleteOnUndeleted());
      }
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Stream<Type?> getStream(int id) {
    return localDataSource.getStream(id);
  }

  Stream<void> watchObjectLazy(int? id) {
    return localDataSource.watchObjectLazy(id);
  }

  Stream<void> watchLazy() {
    return localDataSource.watchLazy();
  }

  Future<Either<Failure, List<int>>> tryGetLocalIdsList(SEType searchEntity) async {
    try {
      final localItemList = await localDataSource.getAllIds(searchEntity);
      if (localItemList.isEmpty) {
        return const Left(Failure.emptyLocalStorageFailure());
      }
      return Right(localItemList);
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, Type>> tryGetLocalById(int id) async {
    try {
      final localItem = await localDataSource.getById(id);
      if (localItem != null) {
        return Right(localItem);
      }
      return const Left(Failure.emptyLocalStorageFailure());
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, int>> tryGetLocalCountOfFinded(SEType searchEntity) async {
    try {
      final count = await localDataSource.countOfFinded(searchEntity);
      return Right(count);
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }

  Future<Either<Failure, List<Type>>> tryGetLocalList(searchEntity) async {
    try {
      final localItemList = await localDataSource.getAll(searchEntity);
      // if (localItemList.isEmpty) {
      //    return Left(Failure.emptyLocalStorageFailure());
      // }
      return Right(localItemList);
    } on CacheException catch (text, stackTrace) {
      return Left(Failure.cacheFailure(text, stackTrace));
    }
  }
}
