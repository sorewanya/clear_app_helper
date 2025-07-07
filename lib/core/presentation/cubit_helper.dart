import 'package:dartz/dartz.dart';

import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/error/map_failure_to_message.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';

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
    return await useCase.getById(itemId).then((value) => value.fold((error) => null, (item) => item as T));
  }

  /// if not `loaded` retry function
  ///
  /// * [loaded] function if loaded state
  /// * [emptyList] function if emptyList state
  /// * [delayedThen] function what started after delay
  ///
  /// for example:
  /// ```
  /// void filtr({required SearchEntity searchEntityFromForm}) {
  ///   cubitHelper.stateMaybeMap<void>(
  ///     delayedThen: () => filtr(searchEntityFromForm: searchEntityFromForm),
  ///     loaded: (_) {...}
  ///     emptyList: (_) {...}
  ///     );
  /// }
  /// ```
  T? stateMaybeMap<T>({required Function delayedThen, required Function() loaded, Function()? emptyList}) =>
      switch (stateStatus()) {
        CubitStateStatus.loaded => loaded(),
        CubitStateStatus.emptyList => emptyList?.call(),
        _ => () {
          //if not `loaded`
          T? result;
          Future.delayed(const Duration(milliseconds: 500), () => delayedThen()).then((value) => result = value);
          return result;
        }(),
      };

  void stateMaybeLoad(
    Function()? loadingFunc, {
    Function()? emptyListFunc,
    Function()? filtredFunc,
    Function()? errorFunc,
    Function()? orElseFunc,
  }) => switch (stateStatus()) {
    CubitStateStatus.filtred => filtredFunc ?? ((_) => goToLoading()),
    CubitStateStatus.loading => loadingFunc?.call(),
    CubitStateStatus.emptyList => emptyListFunc?.call() ?? goToLoading(),
    CubitStateStatus.someElse => orElseFunc?.call(),
    CubitStateStatus.error =>
      errorFunc?.call() ??
          Future.delayed(
            //if error try load() again 5 sec late
            const Duration(seconds: 5),
            (() => goToLoading()),
          ),
    _ => null,
  };

  /// call add from useCase
  /// * [ifRightAdd] Function start if item correct added
  Future<int> add(AppEntity itemToAdd, [Function(int id)? ifRightAdd]) {
    return startCheck(() async {
      final failureOrItem = await useCase.add(itemToAdd);

      var id = failureOrItem.fold(
        (e) {
          emitError(e);
          return 0;
        },
        (id) {
          if (ifRightAdd != null) {
            ifRightAdd(id);
          } else {
            goToLoading();
          }
          return id;
        },
      );
      return id;
    });
  }

  /// call addMany from useCase
  /// * [ifRightAddMany] Function start if items correct added
  Future<List<int>?> addMany(List<AppEntity> itemListToAdd, [Function(List<int> ids)? ifRightAddMany]) {
    return startCheck(() async {
      final failureOrItem = await useCase.addMany(itemListToAdd);

      failureOrItem.fold(
        (e) {
          emitError(e);
          return null;
        },
        (idList) {
          if (ifRightAddMany != null) {
            ifRightAddMany(idList);
          } else {
            goToLoading();
          }
          return idList;
        },
      );
    });
  }

  /// call update from useCase
  /// * [revertDelete] mast be true if item updated with change isDeleted
  /// * [ifRightUpdate] Function start if item correct updated
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
      failureOr?.fold((error) => emitError(error), (id) {
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
