import 'package:clear_app_helper/core/presentation/bloc/current_entity/current_entity_bloc_bloc.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/settings_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentEntityBuilder extends StatelessWidget {
  const CurrentEntityBuilder({required this.childFunc, super.key});

  // ignore: strict_raw_type
  final Widget Function(EntityBloc currentBloc) childFunc;

  @override
  Widget build(BuildContext context) {
    return SettingsBuilderWidget(
      childFunc: (_) {
        return BlocBuilder<CurrentEntityBloc, CurrentEntityBlocState>(
          builder: (context, state) => switch (state) {
            EmptyCurrentEntityBlocState() => loadingIndicator('CurrentEntityBloc empty'),
            LoadedCurrentEntityBlocState() => childFunc(state.currentBloc),
          },
        );
      },
    );
  }
}
