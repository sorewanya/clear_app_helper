import 'package:clear_app_helper/core/datasources/repository.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';

class SettingsRepository extends Repository<SettingsEntity, SettingsSearchEntity> {
  SettingsRepository({required super.networkInfo, required super.localDataSource});
}
