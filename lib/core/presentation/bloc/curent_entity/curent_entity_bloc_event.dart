part of 'curent_entity_bloc_bloc.dart';

sealed class CurentEntityBlocEvent {
  const factory CurentEntityBlocEvent.setNewCurents({
    // ignore: strict_raw_type
    required EntityBloc curentBloc,
  }) = SetNewCurentsCurentEntityBlocEvent;
}

class SetNewCurentsCurentEntityBlocEvent implements CurentEntityBlocEvent {
  const SetNewCurentsCurentEntityBlocEvent({required this.curentBloc});
  // ignore: strict_raw_type
  final EntityBloc curentBloc;
}
