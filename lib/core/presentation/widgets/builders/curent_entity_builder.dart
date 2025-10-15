import 'package:clear_app_helper/core/presentation/bloc/curent_entity/curent_entity_bloc_bloc.dart';
import 'package:clear_app_helper/core/presentation/bloc/entity_bloc.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/settings_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurentEntityBuilder extends StatelessWidget {
  const CurentEntityBuilder({required this.childFunc, super.key});

  // ignore: strict_raw_type
  final Widget Function(EntityBloc curentBloc) childFunc;

  @override
  Widget build(BuildContext context) {
    return SettingsBuilderWidget(
      childFunc: (_) {
        return BlocBuilder<CurentEntityBloc, CurentEntityBlocState>(
          builder: (context, state) => switch (state) {
            EmptyCurentEntityBlocState() => loadingIndicator('CurentEntityBloc empty'),
            LoadedCurentEntityBlocState() => childFunc(state.curentBloc),
          },
        );
      },
    );
  }
}
