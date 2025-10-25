import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';

class BlocSettingsAndStream {
  BlocSettingsAndStream({required this.name, required this.settingsBloc}) {
    setting = settingsBloc.getByNamed(name)?.toType();
    value = setting?.getUserOrDefaultValueAsString;
    stream = settingsBloc.getStreamById(setting?.id! ?? 0);
    stream.listen((event) {
      value = event?.getUserOrDefaultValueAsString;
      setting = event?.toType();
    });
  }
  BlocSettingsAndStream.fromDB({required this.setting, required this.settingsBloc}) {
    name = setting?.name ?? '';
    value = setting?.getUserOrDefaultValueAsString;
    stream = settingsBloc.getStreamById(setting?.id! ?? 0);
    stream.listen((event) {
      value = event?.getUserOrDefaultValueAsString;
      setting = event?.toType();
    });
  }
  late final String name;
  late Stream<SettingsEntity?> stream;
  String? value;
  SettingsEntity? setting;
  final SettingsBloc settingsBloc;
}

class BlocSettingsAndStreamInt extends BlocSettingsAndStream {
  BlocSettingsAndStreamInt({required super.name, required super.settingsBloc});
  int? get getDefaultValueAsIntOrNull => int.tryParse(super.setting?.defaultValue ?? '');
  int? get getUserOrDefaultValueAsIntOrNull => int.tryParse(super.value ?? '');
  int get getUserOrDefaultValueAsIntOrZero => getUserOrDefaultValueAsIntOrNull ?? 0;
}
