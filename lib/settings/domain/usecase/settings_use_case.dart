import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:equatable/equatable.dart';

class SettingsUseCase extends UseCase<SettingsEntity, SettingsSearchEntity> with UseCaseWithRevertDelete {
  SettingsUseCase(super.repository);
}

class SettingsUseCaseParams extends UseCaseParams<SettingsSearchEntity> with EquatableMixin {
  SettingsUseCaseParams(super.searchEntity);

  @override
  List<Object?> get props => [searchEntity];
}
