import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_entity_bloc_event.dart';
part 'current_entity_bloc_state.dart';

class CurrentEntityBloc<CurrentEntity extends AppEntity, CurrentSearchEntity extends SearchEntity>
    extends Bloc<CurrentEntityBlocEvent, CurrentEntityBlocState> {
  CurrentEntityBloc() : super(const EmptyCurrentEntityBlocState()) {
    on<CurrentEntityBlocEvent>((event, emit) async {
      // ignore: strict_raw_type
      void emitLoaded(EntityBloc currentBloc) => emit.call(CurrentEntityBlocState.loaded(currentBloc: currentBloc));
      switch (event) {
        case SetNewCurrentsCurrentEntityBlocEvent():
          emitLoaded(event.currentBloc);
      }
    }, transformer: sequential());
  }
}
