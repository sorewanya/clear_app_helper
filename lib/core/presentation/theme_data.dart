import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// use https://rxlabz.github.io/panache_web/#/ for create your ThemeData
///
///if getIt.registerLazySingleton\<MyThemeData>(() => MyThemeData(enableSizer: true));
///
///```
///Sizer( builder:(context, orientation, screenType) => MaterialApp(
/// theme: GetIt.instance<MyThemeData>().light,
/// darkTheme: GetIt.instance<MyThemeData>().dark,
/// themeMode: GetIt.instance<MyThemeData>().mode,
/// ...
/// );)
/// ```
///
/// if enableSizer:false , its default
///```
///MaterialApp(
/// theme: GetIt.instance<MyThemeData>().light,
/// darkTheme: GetIt.instance<MyThemeData>().dark,
/// themeMode: GetIt.instance<MyThemeData>().mode,
/// ...
/// )
/// ```
class MyThemeData {
  late ThemeData light;
  late ThemeData dark;
  late ThemeMode mode;

  bool enableSizer;

  static MyThemeData? _instance;
  MyThemeData._internal(ThemeData? light, ThemeData? dark, ThemeMode? mode, this.enableSizer) {
    final double sp = enableSizer == false ? 20 : 1.sp;
    final double fontSizeFactor = 3.5 * sp;
    final double fontSizeDelta = 1.0 * sp;
    final double iconThemeSize = 20 * sp;
    this.mode = mode ?? ThemeMode.system;
    this.light =
        light ??
        ThemeData(
          textTheme: enableSizer == false
              ? null
              : ThemeData.light().textTheme.apply(fontSizeFactor: fontSizeFactor, fontSizeDelta: fontSizeDelta),
          iconTheme: enableSizer == false ? null : ThemeData.light().iconTheme.copyWith(size: iconThemeSize),
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        );
    this.dark =
        dark ??
        ThemeData.dark().copyWith(
          textTheme: enableSizer == false
              ? null
              : ThemeData.dark().textTheme.apply(fontSizeFactor: fontSizeFactor, fontSizeDelta: fontSizeDelta),
          iconTheme: enableSizer == false ? null : ThemeData.dark().iconTheme.copyWith(size: iconThemeSize),
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
  factory MyThemeData({ThemeData? light, ThemeData? dark, bool? enableSizer, ThemeMode? mode}) =>
      _instance ?? MyThemeData._internal(light, dark, mode, enableSizer = false);
}

Color getColorByBoolIsDeleted(bool isDeleted, context) {
  return isDeleted
      ? Theme.of(context).colorScheme.error.withValues(alpha: 0.3)
      : Theme.of(context).primaryColor.withValues(alpha: 0.6);
}
