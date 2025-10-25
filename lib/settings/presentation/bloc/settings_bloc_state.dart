part of 'settings_bloc_bloc.dart';

class InitialSettingsBlocState implements SettingsBlocState {
  const InitialSettingsBlocState();
}

class LoadedSettingsBlocState implements SettingsBlocState {
  const LoadedSettingsBlocState(this.settingsIdsFinded);

  final IdsFinded<SettingsSearchEntity> settingsIdsFinded;
}

class LoadingErrorSettingsBlocState implements SettingsBlocState {
  const LoadingErrorSettingsBlocState(this.errorMessage, this.searchEntity);

  final String errorMessage;
  final SettingsSearchEntity searchEntity;
}

class LoadingSettingsBlocState implements SettingsBlocState {
  const LoadingSettingsBlocState();
}

class SavingErrorSettingsBlocState implements SettingsBlocState {
  const SavingErrorSettingsBlocState(this.errorMessage);

  final String errorMessage;
}

class SavingSettingsBlocState implements SettingsBlocState {
  const SavingSettingsBlocState();
}

sealed class SettingsBlocState {
  const factory SettingsBlocState.initial() = InitialSettingsBlocState;
  const factory SettingsBlocState.loaded(IdsFinded<SettingsSearchEntity> settingsIdsFinded) = LoadedSettingsBlocState;
  const factory SettingsBlocState.loading() = LoadingSettingsBlocState;
  const factory SettingsBlocState.loadingError(String errorMessage, SettingsSearchEntity searchEntity) =
      LoadingErrorSettingsBlocState;
  const factory SettingsBlocState.saving() = SavingSettingsBlocState;
  const factory SettingsBlocState.savingError(String errorMessage) = SavingErrorSettingsBlocState;
}
