import 'package:clear_app_helper/core/hash_func.dart';
import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:equatable/equatable.dart';

class SettingsUseCase extends UseCase<SettingsEntity, SettingsSearchEntity> with UseCaseWithRevertDelete {
  SettingsUseCase(super.repository);
  Future<void> updateUserValue({required EnumsOfSettings settingEnum, required String newUserValue}) async {
    final setting = await getById(fastHash(settingEnum.name));
    await setting.fold((_) => null, (value) => update(value.copyWith(userValue: newUserValue)));
  }
}

class SettingsUseCaseParams extends UseCaseParams<SettingsSearchEntity> with EquatableMixin {
  SettingsUseCaseParams(super.searchEntity);

  @override
  List<Object?> get props => [searchEntity];
}
