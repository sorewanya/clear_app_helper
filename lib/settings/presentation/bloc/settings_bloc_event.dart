part of 'settings_bloc_bloc.dart';

class ErrorShowedSettingsBlocEvent implements SettingsBlocEvent {
  const ErrorShowedSettingsBlocEvent();
}

class LoadFullListsSettingsBlocEvent implements SettingsBlocEvent {
  const LoadFullListsSettingsBlocEvent();
}

class LoadSettingsBlocEvent implements SettingsBlocEvent {
  const LoadSettingsBlocEvent(this.searchEntity);

  final SettingsSearchEntity? searchEntity;
}

class ResetToDefaultSettingsBlocEvent implements SettingsBlocEvent {
  const ResetToDefaultSettingsBlocEvent(this.item);

  final SettingsEntity item;
}

class SaveFormSettingsBlocEvent implements SettingsBlocEvent {
  const SaveFormSettingsBlocEvent({
    required this.origItem,
    required this.item,
    required this.pop,
    required this.formKey,
  });

  final SettingsEntity? origItem;
  final SettingsEntity item;
  final Function() pop;
  final GlobalKey<FormState> formKey;
}

sealed class SettingsBlocEvent {
  const factory SettingsBlocEvent.errorShowed() = ErrorShowedSettingsBlocEvent;
  const factory SettingsBlocEvent.load(SettingsSearchEntity? searchEntity) = LoadSettingsBlocEvent;
  const factory SettingsBlocEvent.loadFullLists() = LoadFullListsSettingsBlocEvent;
  const factory SettingsBlocEvent.resetToDefault(SettingsEntity item) = ResetToDefaultSettingsBlocEvent;
  const factory SettingsBlocEvent.saveForm({
    required SettingsEntity? origItem,
    required SettingsEntity item,
    required Function() pop,
    required GlobalKey<FormState> formKey,
  }) = SaveFormSettingsBlocEvent;
  const factory SettingsBlocEvent.update({required SettingsEntity item}) = UpdateSettingsBlocEvent;
}

class UpdateSettingsBlocEvent implements SettingsBlocEvent {
  const UpdateSettingsBlocEvent({required this.item});

  final SettingsEntity item;
}
