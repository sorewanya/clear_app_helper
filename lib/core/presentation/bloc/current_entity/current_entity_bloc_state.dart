part of 'current_entity_bloc_bloc.dart';

sealed class CurrentEntityBlocState {
  const factory CurrentEntityBlocState.empty() = EmptyCurrentEntityBlocState;
  const factory CurrentEntityBlocState.loaded({
    // ignore: strict_raw_type
    required EntityBloc currentBloc,
  }) = LoadedCurrentEntityBlocState;
}

class EmptyCurrentEntityBlocState implements CurrentEntityBlocState {
  const EmptyCurrentEntityBlocState();
}

class LoadedCurrentEntityBlocState implements CurrentEntityBlocState {
  const LoadedCurrentEntityBlocState({required this.currentBloc});
  // ignore: strict_raw_type
  final EntityBloc currentBloc;
}
