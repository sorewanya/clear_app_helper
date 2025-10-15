import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/settings_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DetailPage<Entity, EBloc extends EntityBloc<dynamic, dynamic, Entity, SE>, SE extends SearchEntity>
    extends StatelessWidget {
  const DetailPage({required this.loadString, required this.child, required this.getIt, super.key});

  final String loadString;
  final Widget Function(Entity entity) child;
  final GetIt getIt;

  @override
  Widget build(BuildContext context) {
    return SettingsBuilderWidget(
      childFunc: (sf) {
        final itemBloc = getIt<EBloc>();
        final se = FunctionsHelper.getArgs<SE>() ?? getIt<SE>();
        return StreamBuilder<Entity>(
          stream: itemBloc.get(se),
          builder: (context, snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return loadingIndicator(loadString);
            }
            return child(snapshot.data as Entity);
          },
        );
      },
    );
  }
}
