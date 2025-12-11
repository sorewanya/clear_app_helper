import 'package:clear_app_helper/core/presentation/widgets/animated_toggle_switch_or_dropdown.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AnimatedToggleSwitchBySetting extends StatelessWidget {
  const AnimatedToggleSwitchBySetting({required this.settingEnum, super.key});
  final EnumsOfSettings settingEnum;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: GetIt.I<SettingsBloc>().getByEnum(settingEnum),
      stream: GetIt.I<SettingsBloc>().getStreamByEnum(settingEnum),
      builder: (context, snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return Text('Error get ${settingEnum.name} settings');
        }
        final data = snapshot.data!;
        return AnimatedToggleSwitchOrDropdown(
          value: data.getUserOrDefaultValueAsString,
          values: data.values,
          setValue: GetIt.I<SettingsBloc>().updateUserValueCallback(data),
          setState: (f) => f(),
          hasIndexValue: data.type == SettingsTypeEnum.value.index,
          isBool: data.type == SettingsTypeEnum.boolean.index,
        );
      },
    );
  }
}
