part of 'curent_entity_bloc_bloc.dart';

sealed class CurentEntityBlocEvent {
  const factory CurentEntityBlocEvent.setNewCurents({
    required EntityBloc curentBloc,
  }) = SetNewCurentsCurentEntityBlocEvent;
}

class SetNewCurentsCurentEntityBlocEvent implements CurentEntityBlocEvent {
  const SetNewCurentsCurentEntityBlocEvent({
    required this.curentBloc,
  });
  final EntityBloc curentBloc;
}
