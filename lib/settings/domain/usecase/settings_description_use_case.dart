import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_description_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_description_entity.dart';
import 'package:equatable/equatable.dart';

class SettingsDescriptionUseCase extends UseCase<SettingsDescriptionEntity, SettingsDescriptionSearchEntity> {
  SettingsDescriptionUseCase(super.repository);
}

class SettingsDescriptionUseCaseParams extends UseCaseParams<SettingsDescriptionSearchEntity> with EquatableMixin {
  SettingsDescriptionUseCaseParams(super.searchEntity);

  @override
  List<Object?> get props => [searchEntity];
}
