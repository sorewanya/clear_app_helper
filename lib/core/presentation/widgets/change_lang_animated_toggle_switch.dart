import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/presentation/widgets/animated_toggle_switch_or_dropdown.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChangeLangAnimatedToggleSwitcher extends StatelessWidget {
  const ChangeLangAnimatedToggleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: GetIt.I<SettingsBloc>().getByEnum(CoreSettingsEnum.currentLocaleI18n),
      stream: GetIt.I<SettingsBloc>().getStreamByEnum(CoreSettingsEnum.currentLocaleI18n),
      builder: (context, snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return const Text('Error get currentLocaleI18n settings');
        }
        final currentLocaleI18n = snapshot.data!;
        return AnimatedToggleSwitchOrDropdown(
          value: currentLocaleI18n.getUserOrDefaultValueAsString,
          values: currentLocaleI18n.values,
          setValue: GetIt.I<SettingsBloc>().updateUserValueCallback(currentLocaleI18n),
          setState: (f) => f(),
          hasIndexValue: true,
        );
      },
    );
  }
}
