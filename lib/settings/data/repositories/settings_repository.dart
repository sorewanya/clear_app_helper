import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';

import '../../../core/datasources/repository.dart';

class SettingsRepository extends Repository<SettingsEntity, SettingsSearchEntity> {
  SettingsRepository({required super.networkInfo, required super.localDataSource});
}
