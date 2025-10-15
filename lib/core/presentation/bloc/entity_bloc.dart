import 'package:clear_app_helper/core/domain/entities/item_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[Entity] is [`AppEntity`] or [`ComplexObject`] or any other if u can create bloc with this functions
abstract class EntityBloc<BlocEvent, BlocState, Entity, SearchEntity> extends Bloc<BlocEvent, BlocState> {
  EntityBloc(super.initialState);
  Stream<Entity?> getStreamById(int id);
  Stream<void> watchObjectLazy(int? id);
  Future<Entity?> getById(int? itemId);
  Stream<Entity> get(SearchEntity searchEntity);
  ItemActions? itemActions;
  void setItemActions(ItemActions? actions) => itemActions = actions;
}
