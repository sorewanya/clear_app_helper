import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/presentation/widgets/animated_toggle_switch_or_dropdown.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChangeThemeAnimatedToggleSwitch extends StatelessWidget {
  const ChangeThemeAnimatedToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: GetIt.I<SettingsBloc>().getByEnum(CoreSettingsEnum.themeMode),
      stream: GetIt.I<SettingsBloc>().getStreamByEnum(CoreSettingsEnum.themeMode),
      builder: (context, snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return const Text('Error get themeMode settings');
        }
        final themeMode = snapshot.data!;
        return AnimatedToggleSwitchOrDropdown(
          value: themeMode.getUserOrDefaultValueAsString,
          values: themeMode.values,
          setValue: GetIt.I<SettingsBloc>().updateUserValueCallback(themeMode),
          setState: (f) => f(),
          hasIndexValue: true,
        );
      },
    );
  }
}
