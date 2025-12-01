import 'package:flutter/material.dart';

//TODO remove, use color directly in Theme
Color getColorByBoolIsDeleted(bool isDeleted, BuildContext context) {
  if (isDeleted) {
    return Theme.of(context).colorScheme.error.withValues(alpha: 0.3);
  } else {
    return Theme.of(context).primaryColor.withValues(alpha: 0.6);
  }
}

///```
///MaterialApp(
/// theme: GetIt.instance<MyThemeData>().light,
/// darkTheme: GetIt.instance<MyThemeData>().dark,
/// themeMode: GetIt.instance<MyThemeData>().mode,
/// ...
/// )
/// ```
//TODO create user settings
class MyThemeData {
  factory MyThemeData({ThemeData? light, ThemeData? dark, ThemeMode? mode}) =>
      _instance ?? MyThemeData._internal(light, dark, mode);
  MyThemeData._internal(ThemeData? light, ThemeData? dark, ThemeMode? mode) {
    this.mode = mode ?? ThemeMode.system;
    this.light = light ?? ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo);
    this.dark =
        dark ??
        ThemeData.dark().copyWith(
          floatingActionButtonTheme: ThemeData.dark().floatingActionButtonTheme.copyWith(
            highlightElevation: 15,
            elevation: 10,
            backgroundColor: Colors.indigo[500],
            splashColor: Colors.indigo[200],
            focusColor: Colors.indigo[200],
            foregroundColor: Colors.blue.shade100,
            hoverColor: Colors.indigo[200],
          ),
          primaryColor: Colors.indigo,
          colorScheme: const ColorScheme.dark().copyWith(primary: Colors.blue[300], secondary: Colors.blue.shade500),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.indigo,
            colorScheme: const ColorScheme.dark().copyWith(onPrimary: Colors.indigo, secondary: Colors.indigo.shade500),
          ),
        );
    _instance = this;
  }
  static MyThemeData? _instance;

  late ThemeData light;
  late ThemeData dark;
  late ThemeMode mode;
}
