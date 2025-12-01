import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/error/map_failure_to_message.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

///simple bloc helper
class BlocHelper<T extends AppEntity, SEType extends SearchEntity> {
  BlocHelper({required this.useCase});

  UseCase<T, SEType> useCase;

  /// call add from useCase
  /// * [ifRightAdd] Function start if item correct added
  Future<int> add(T itemToAdd, Function(String error)? savingError, [Function(int id)? ifRightAdd]) async {
    final failureOrItem = await useCase.add(itemToAdd);

    return await failureOrItem.fold(
      (e) {
        if (savingError != null) savingError(_mapFailureToMessage(e));
        return 0;
      },
      (id) {
        if (ifRightAdd != null) {
          ifRightAdd(id);
        }
        return id;
      },
    );
  }

  Future<T?> getById(int? itemId, Function(String error)? loadingError) async {
    if (itemId == null) return null;
    final itemOrErorr = await useCase.getById(itemId);
    return await itemOrErorr.fold((error) {
      if (loadingError != null) loadingError(_mapFailureToMessage(error));
      return null;
    }, (item) => item);
  }

  Future<int> getCount(Future<Either<Failure, int>> get, Function(String error)? loadingError) async {
    return get.then((value) async {
      return await value.fold(
        (error) {
          if (loadingError != null) loadingError(_mapFailureToMessage(error));
          return 0;
        },
        (count) {
          return count;
        },
      );
    });
  }

  Future<List<int>> getIdsList(Future<Either<Failure, List<int>>> get, Function(String error)? loadingError) async {
    return get.then((value) async {
      return await value.fold(
        (error) {
          if (loadingError != null) loadingError(_mapFailureToMessage(error));
          return [];
        },
        (list) {
          return list;
        },
      );
    });
  }

  Future<List<T>> getList(Future<Either<Failure, List<T>>> get, Function(String error)? loadingError) async {
    final Either<Failure, List<T>> failureOrList = await get;

    return await failureOrList.fold(
      (error) {
        if (loadingError != null) loadingError(_mapFailureToMessage(error));
        return [];
      },
      (list) {
        return list;
      },
    );
  }

  Stream<T?> getStream(int id) {
    return useCase.getStream(id);
  }

  /// call update from useCase
  /// * [revertDelete] mast be true if item updated with change isDeleted
  /// * [ifRightUpdate] Function start if item correct updated
  Future<int> update({
    required T itemToUpdate,
    required bool revertDelete,
    required Function(int id) ifRightUpdate,
    required Function(String error)? savingError,
  }) async {
    late final Either<Failure, int>? failureOr;
    revertDelete && useCase is UseCaseWithRevertDelete
        ? failureOr = await (useCase as UseCaseWithRevertDelete).revertDelete(itemToUpdate)
        : failureOr = await useCase.update(itemToUpdate);
    return failureOr!.fold(
      (e) {
        if (savingError != null) savingError(_mapFailureToMessage(e));
        return 0;
      },
      (id) {
        ifRightUpdate(id);
        return id;
      },
    );
  }

  String _mapFailureToMessage(Failure error) => mapFailureToMessage(error);
}
