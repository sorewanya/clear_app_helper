import 'package:clear_app_helper/core/domain/entities/ids_finded.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsBuilderWidget extends StatelessWidget {
  const SettingsBuilderWidget({required this.childFunc, super.key});

  /// callback current IdsFinded
  final Widget Function(IdsFinded<SettingsSearchEntity> settingsIdsFinded) childFunc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsBlocState>(
      builder: (context, state) {
        return switch (state) {
          InitialSettingsBlocState() => Builder(
            builder: (context) {
              context.read<SettingsBloc>().add(const SettingsBlocEvent.loadFullLists());
              return loadingIndicator(GetIt.instance<CoreI18n>().settingsBuilderStateInitial);
            },
          ),
          LoadedSettingsBlocState() => childFunc(state.settingsIdsFinded),
          LoadingErrorSettingsBlocState() => loadingIndicator(
            '${GetIt.instance<CoreI18n>().settingsBuilderStateLoadingError}: ${state.errorMessage}',
          ),
          SavingErrorSettingsBlocState() => loadingIndicator(
            '${GetIt.instance<CoreI18n>().settingsBuilderStateSavingError}: ${state.errorMessage}',
          ),
          _ => loadingIndicator(GetIt.instance<CoreI18n>().settingsBuilderWork),
        };
      },
    );
  }
}
