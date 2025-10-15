import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// This builder mast be around [MaterialApp],
/// to use returned values setup [MaterialApp] builder param with [`MyThemeWithSizerBuilder`]
/// Example:
///```
/// SizerBuilder(
///           builder: (fontSizeFactor, fontSizeDelta, iconThemeSize) => MaterialApp(
///             title: '===APP TITLE===',
///     ///copyWith cant be in SizerBuilder because Theme.of(context) created in MaterialApp, I dont want to wrap all pages to Theme, so...
///             builder: (context, child) => MyThemeWithSizerBuilder(
///                  fontSizeFactor: fontSizeFactor,
///                  fontSizeDelta: fontSizeDelta,
///                  iconThemeSize: iconThemeSize,
///                  child: child ?? Placeholder()),
///             theme: getIt\<MyThemeData>().light,
///             darkTheme: getIt\<MyThemeData>().dark,
///             themeMode: getIt\<MyThemeData>().mode,
///```
//TODO add max and min, create system to use orientation in widgets
class SizerBuilder extends StatelessWidget {
  const SizerBuilder({super.key, required this.builder, this.fontSizeFactor, this.fontSizeDelta, this.iconThemeSize});
  final double? fontSizeFactor;
  final double? fontSizeDelta;
  final double? iconThemeSize;
  final Widget Function(double fontSizeFactor, double fontSizeDelta, double iconThemeSize) builder;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return builder((fontSizeFactor ?? 3.5).sp, (fontSizeDelta ?? 1.0).sp, (iconThemeSize ?? 20).sp);
      },
    );
  }
}
