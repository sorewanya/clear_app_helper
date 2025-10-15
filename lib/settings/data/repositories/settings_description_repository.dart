import 'package:clear_app_helper/core/datasources/repository.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_description_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_description_entity.dart';

class SettingsDescriptionRepository extends Repository<SettingsDescriptionEntity, SettingsDescriptionSearchEntity> {
  SettingsDescriptionRepository({required super.networkInfo, required super.localDataSource});
}
