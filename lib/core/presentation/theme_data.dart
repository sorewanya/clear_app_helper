import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

//TODO create helper and add user settings

ThemeData getThemeDataLight() {
  return ThemeData(useMaterial3: true, primarySwatch: Colors.blue);
}

ThemeData getThemeDataDark() {
  var margin = const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 34.0);
  return ThemeData.dark().copyWith(
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
    extensions: [
      const FlashToastTheme().copyWith(margin: margin),
      const FlashBarTheme().copyWith(margin: margin),
    ],
  );
}

Color getColorByBoolIsDeleted(bool isDeleted, context) {
  return isDeleted
      ? Theme.of(context).colorScheme.error.withValues(alpha: 0.3)
      : Theme.of(context).primaryColor.withValues(alpha: 0.6);
}
