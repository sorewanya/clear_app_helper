import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/error/map_failure_to_message.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';

///simple Cubit helper
///FIXME need to tests, refactoring
class CubitHelper {
  CubitHelper({
    required this.useCase,
    required this.state,
    required this.startCheck,
    required this.load,
    this.stateError,
    this.stateLoading,
    this.stateLoaded,
    this.stateFiltred,
  });

  UseCase useCase;

  /// ```
  /// state: () => state,
  /// ```
  final Function() state;

  /// callback function to check state is loaded
  ///
  /// set if dont needed:
  /// `startCheck: (f) => f(),`
  final Function(Function()) startCheck;

  /// function to update data from useCase
  final Function() load;

  /// set error state
  final Function(String error)? stateError;

  /// set loading state
  final Function()? stateLoading;

  /// set loaded state
  final Function()? stateLoaded;

  /// set filtred state
  final Function(SearchEntity)? stateFiltred;

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
  T? stateMaybeMap<T>({required Function delayedThen, required dynamic loaded, dynamic emptyList}) {
    return state().maybeMap(
      orElse: () {
        //if not `loaded`
        T? result;
        Future.delayed(const Duration(milliseconds: 500), () => delayedThen()).then((value) => result = value);
        return result;
      },
      loaded: loaded,
      emptyList: emptyList,
    );
  }

  void stateMaybeLoad(
    Function? loadingFunc, {
    Function? emptyListFunc,
    Function? filtredFunc,
    Function? errorFunc,
    Function? orElseFunc,
  }) {
    log("state().maybeMap");
    state().maybeMap(
      orElse: orElseFunc ?? () => {},
      emptyList: emptyListFunc ?? (_) async => goToLoading(),
      loading: loadingFunc,
      filtred: filtredFunc ?? ((_) => goToLoading()),
      error:
          errorFunc ??
          (_) => Future.delayed(
            //if error try load() again 5 sec late
            const Duration(seconds: 5),
            (() => goToLoading()),
          ),
    );
  }

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
