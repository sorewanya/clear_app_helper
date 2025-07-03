enum SettingsLogAction {
  delete(1), //for bugfix
  restore(2), //for bugfix
  updateValues(3), //for bugfix
  updateUserValue(4),
  updateDefaultValue(5), //for bugfix
  updateName(6); //for bugfix

  const SettingsLogAction(this.myValue);

  final int myValue;
}
