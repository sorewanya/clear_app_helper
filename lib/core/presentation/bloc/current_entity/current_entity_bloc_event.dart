part of 'current_entity_bloc_bloc.dart';

sealed class CurrentEntityBlocEvent {
  const factory CurrentEntityBlocEvent.setNewCurrents({
    // ignore: strict_raw_type
    required EntityBloc currentBloc,
  }) = SetNewCurrentsCurrentEntityBlocEvent;
}

class SetNewCurrentsCurrentEntityBlocEvent implements CurrentEntityBlocEvent {
  const SetNewCurrentsCurrentEntityBlocEvent({required this.currentBloc});
  // ignore: strict_raw_type
  final EntityBloc currentBloc;
}
