import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';

mixin EnumsOfSettings {
  String get name;
  SettingsTypeEnum get type;
  int get typeIndex => type.index;
  String get description;
}
