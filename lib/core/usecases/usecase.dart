import 'package:clear_app_helper/core/datasources/repository.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:dartz/dartz.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<T extends AppEntity, SEType extends SearchEntity> {
  UseCase(this.repository);

  final Repository<T, SEType> repository;

  Future<Either<Failure, int>> add(T item) async {
    return repository.add(item);
  }

  Future<Either<Failure, List<int>>> addMany(List<T> itemList) async {
    return repository.addMany(itemList);
  }

  Future<Either<Failure, List<T>>> call(UseCaseParams<SEType> useCaseParams) async {
    return repository.getAll(useCaseParams.searchEntity);
  }

  Future<Either<Failure, int>> countOfFinded(UseCaseParams<SEType> params) async {
    return repository.countOfFinded(params.searchEntity);
  }

  Future<Either<Failure, List<int>>> getAllIds(UseCaseParams<SEType> params) async {
    return repository.getAllIds(params.searchEntity);
  }

  Future<Either<Failure, T>> getById(int id) async {
    return repository.getById(id);
  }

  Stream<T?> getStream(int id) {
    return repository.getStream(id);
  }

  Future<Either<Failure, int>?> update(T item) async {
    return repository.update(item);
  }

  Stream<List<T>?> watch(UseCaseParams<SEType> params) {
    return repository.watch(params.searchEntity);
  }

  Stream<void> watchLazy() {
    return repository.watchLazy();
  }

  Stream<void> watchObjectLazy(int? id) {
    return repository.watchObjectLazy(id);
  }
}

abstract class UseCaseParams<SEType extends SearchEntity> {
  UseCaseParams(this.searchEntity);
  final SEType searchEntity;
}

mixin UseCaseWithDelete<T extends AppEntity, SEType extends SearchEntity> on UseCase<T, SEType> {
  Future<Either<Failure, bool>> delete(int itemId) async {
    return repository.delete(itemId);
  }

  Future<Either<Failure, void>> deleteAll() async {
    return repository.deleteAll();
  }

  Future<Either<Failure, int>> deleteMany(List<int> ids) async {
    return repository.deleteMany(ids);
  }
}
mixin UseCaseWithRevertDelete<T extends AppEntity, SEType extends SearchEntity> on UseCase<T, SEType> {
  Future<Either<Failure, int>?> revertDelete(T item) async {
    return repository.revertDelete(item);
  }
}
