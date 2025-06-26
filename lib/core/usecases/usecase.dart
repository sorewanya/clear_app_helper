import 'package:clear_app_helper/core/datasources/repository.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCaseParams<SEType extends SearchEntity> {
  final SEType searchEntity;
  UseCaseParams(this.searchEntity);
}

abstract class UseCase<Type extends AppEntity, SEType extends SearchEntity> {
  final Repository<Type, SEType> repository;

  UseCase(this.repository);

  Future<Either<Failure, List<Type>>> call(UseCaseParams<SEType> useCaseParams) async {
    return await repository.getAll(useCaseParams.searchEntity);
  }

  Future<Either<Failure, Type>> getById(int id) async {
    return await repository.getById(id);
  }

  Future<Either<Failure, int>> add(Type item) async {
    return await repository.add(item);
  }

  Future<Either<Failure, List<int>>> addMany(List<Type> itemList) async {
    return await repository.addMany(itemList);
  }

  Future<Either<Failure, int>?> update(Type item) async {
    return await repository.update(item);
  }

  Stream<Type?> getStream(int id) {
    return repository.getStream(id);
  }

  Future<Either<Failure, List<int>>> getAllIds(UseCaseParams<SEType> params) async {
    return await repository.getAllIds(params.searchEntity);
  }

  Future<Either<Failure, int>> countOfFinded(UseCaseParams<SEType> params) async {
    return await repository.countOfFinded(params.searchEntity);
  }

  Stream<void> watchObjectLazy(int? id) {
    return repository.watchObjectLazy(id);
  }

  Stream<void> watchLazy() {
    return repository.watchLazy();
  }
}

mixin UseCaseWithRevertDelete<Type extends AppEntity, SEType extends SearchEntity> on UseCase<Type, SEType> {
  Future<Either<Failure, int>?> revertDelete(Type item) async {
    return await repository.revertDelete(item);
  }
}
mixin UseCaseWithDelete<Type extends AppEntity, SEType extends SearchEntity> on UseCase<Type, SEType> {
  Future<Either<Failure, bool>> delete(int itemId) async {
    return await repository.delete(itemId);
  }

  Future<Either<Failure, void>> deleteAll() async {
    return await repository.deleteAll();
  }

  Future<Either<Failure, int>> deleteMany(List<int> ids) async {
    return await repository.deleteMany(ids);
  }
}
