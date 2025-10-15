part of 'curent_entity_bloc_bloc.dart';

sealed class CurentEntityBlocState {
  const factory CurentEntityBlocState.empty() = EmptyCurentEntityBlocState;
  const factory CurentEntityBlocState.loaded({
    // ignore: strict_raw_type
    required EntityBloc curentBloc,
  }) = LoadedCurentEntityBlocState;
}

class EmptyCurentEntityBlocState implements CurentEntityBlocState {
  const EmptyCurentEntityBlocState();
}

class LoadedCurentEntityBlocState implements CurentEntityBlocState {
  // ignore: strict_raw_type
  final EntityBloc curentBloc;
  const LoadedCurentEntityBlocState({required this.curentBloc});
}
