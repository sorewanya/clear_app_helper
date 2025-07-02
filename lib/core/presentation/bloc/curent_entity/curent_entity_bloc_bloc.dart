import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'curent_entity_bloc_event.dart';
part 'curent_entity_bloc_state.dart';

class CurentEntityBloc<CurentEntity extends AppEntity, CurentSearchEntity extends SearchEntity>
    extends Bloc<CurentEntityBlocEvent, CurentEntityBlocState> {
  CurentEntityBloc() : super(const EmptyCurentEntityBlocState()) {
    on<CurentEntityBlocEvent>((event, emit) async {
      void emitLoaded(EntityBloc curentBloc) => emit.call(CurentEntityBlocState.loaded(curentBloc: curentBloc));
      switch (event) {
        case SetNewCurentsCurentEntityBlocEvent():
          emitLoaded(event.curentBloc);
      }
    }, transformer: sequential());
  }
}
