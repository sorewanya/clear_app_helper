import 'package:clear_app_helper/core/hash_func.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';

mixin EnumsOfSettings {
  String get description;
  int get getFastHash => fastHash(name);
  String get name;
  SettingsTypeEnum get type;
  int get typeIndex => type.index;
}
