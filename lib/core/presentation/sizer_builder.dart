import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Example:
///```
/// SizerBuilder(
///           builder: (fontSizeFactor, fontSizeDelta, iconThemeSize) => GetMaterialApp(
///             debugShowCheckedModeBanner: false,
///             title: '===APP TITLE===',
///     ///copyWith cant be in SizerBuilder because Theme.of(context) created in MaterialApp, I dont want to wrap all pages to Theme, so...
///             theme: getIt\<MyThemeData>().light.copyWith(
///                   textTheme: getIt\<MyThemeData>().dark.textTheme.apply(
///                         fontSizeFactor: fontSizeFactor,
///                         fontSizeDelta: fontSizeDelta,
///                       ),
///                   iconTheme: getIt\<MyThemeData>()
///                       .dark
///                       .iconTheme
///                       .copyWith(size: iconThemeSize, color: Color.fromARGB(0, 19, 131, 26)),
///                 ),
///             darkTheme: getIt\<MyThemeData>().dark.copyWith(
///                   textTheme: getIt\<MyThemeData>().dark.textTheme.apply(
///                         fontSizeFactor: fontSizeFactor,
///                         fontSizeDelta: fontSizeDelta,
///                       ),
///                   iconTheme: getIt\<MyThemeData>()
///                       .dark
///                       .iconTheme
///                       .copyWith(size: iconThemeSize, color: Color.fromARGB(0, 19, 131, 26)),
///                 ),
///             themeMode: getIt\<MyThemeData>().mode,
///```
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
        return builder((fontSizeFactor ?? 3.5).sp, (fontSizeDelta ?? 1.0).sp, (iconThemeSize ?? 100).sp);
      },
    );
  }
}
