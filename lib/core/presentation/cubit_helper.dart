import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/error/map_failure_to_message.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

enum CubitStateStatus { inited, loading, loaded, emptyList, filtred, error, someElse }

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
    this.stateFiltred,
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

  /// set filtred state
  final Function(SearchEntity se)? stateFiltred;

  /// emitLoading && load
  void goToLoading() {
    emitLoading();
    load();
  }

  Future<T?> getById<T extends AppEntity>(int itemId) async {
    return useCase.getById(itemId).then((value) => value.fold((error) => null, (item) => item as T));
  }

  /// call update from useCase
  /// * [revertDelete] mast be true if item updated with change isDeleted
  /// * [ifRightUpdate] Function start if item correct updated
  // ignore: avoid_types_as_parameter_names
  Future<void> update<Type extends AppEntity>({
    required Type itemToUpdate,
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

  void emitError(Failure error) => stateError?.call(mapFailureToMessage(error));

  void emitLoading() => stateLoading?.call();

  void emitLoaded() => stateLoaded?.call();

  void emitFlitr(SearchEntity searchEntity) => stateFiltred?.call(searchEntity);
}
