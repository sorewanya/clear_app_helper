part of 'settings_bloc_bloc.dart';

sealed class SettingsBlocState {
  const factory SettingsBlocState.initial() = InitialSettingsBlocState;
  const factory SettingsBlocState.loading() = LoadingSettingsBlocState;
  const factory SettingsBlocState.loadingError(String errorMessage, SettingsSearchEntity searchEntity) =
      LoadingErrorSettingsBlocState;
  const factory SettingsBlocState.loaded(IdsFinded<SettingsSearchEntity> settingsIdsFinded) = LoadedSettingsBlocState;
  const factory SettingsBlocState.saving() = SavingSettingsBlocState;
  const factory SettingsBlocState.savingError(String errorMessage) = SavingErrorSettingsBlocState;
}

class InitialSettingsBlocState implements SettingsBlocState {
  const InitialSettingsBlocState();
}

class LoadingSettingsBlocState implements SettingsBlocState {
  const LoadingSettingsBlocState();
}

class SavingSettingsBlocState implements SettingsBlocState {
  const SavingSettingsBlocState();
}

class SavingErrorSettingsBlocState implements SettingsBlocState {
  const SavingErrorSettingsBlocState(this.errorMessage);

  final String errorMessage;
}

class LoadingErrorSettingsBlocState implements SettingsBlocState {
  const LoadingErrorSettingsBlocState(this.errorMessage, this.searchEntity);

  final String errorMessage;
  final SettingsSearchEntity searchEntity;
}

class LoadedSettingsBlocState implements SettingsBlocState {
  const LoadedSettingsBlocState(this.settingsIdsFinded);

  final IdsFinded<SettingsSearchEntity> settingsIdsFinded;
}
