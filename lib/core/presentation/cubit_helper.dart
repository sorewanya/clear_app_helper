import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/error/map_failure_to_message.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

///simple Cubit helper
class CubitHelper {
  CubitHelper({
    required this.useCase,
    required this.stateStatus,
    required this.startCheck,
    required this.load,
    this.stateError,
    this.stateLoading,
    this.stateLoaded,
    this.stateFiltered,
  });
  CubitStateStatus Function() stateStatus;

  UseCase useCase;

  /// callback function to check state is loaded
  ///
  /// set if dont needed:
  /// `startCheck: (f) => f(),`
  final Function(Function() f) startCheck;

  /// function to update data from useCase
  final Function() load;

  /// set error state
  final Function(String error)? stateError;

  /// set loading state
  final Function()? stateLoading;

  /// set loaded state
  final Function()? stateLoaded;

  /// set filtered state
  final Function(SearchEntity se)? stateFiltered;

  void emitError(Failure error) => stateError?.call(mapFailureToMessage(error));

  void emitFlitr(SearchEntity searchEntity) => stateFiltered?.call(searchEntity);

  void emitLoaded() => stateLoaded?.call();

  void emitLoading() => stateLoading?.call();

  Future<T?> getById<T extends AppEntity>(int itemId) async {
    return useCase.getById(itemId).then((value) => value.fold((error) => null, (item) => item as T));
  }

  /// emitLoading && load
  void goToLoading() {
    emitLoading();
    load();
  }

  /// call update from useCase
  /// * [revertDelete] mast be true if item updated with change isDeleted
  /// * [ifRightUpdate] Function start if item correct updated
  Future<void> update<T extends AppEntity>({
    required T itemToUpdate,
    required bool revertDelete,
    required Function(int id) ifRightUpdate,
  }) async {
    startCheck(() async {
      late final Either<Failure, int>? failureOr;
      revertDelete && useCase is UseCaseWithRevertDelete
          ? failureOr = await (useCase as UseCaseWithRevertDelete).revertDelete(itemToUpdate)
          : failureOr = await useCase.update(itemToUpdate);
      failureOr?.fold(emitError, (id) {
        ifRightUpdate(id);
        emitLoaded();
      });
    });
  }
}

enum CubitStateStatus { inited, loading, loaded, emptyList, filtered, error, someElse }
