import 'package:flutter/material.dart';

class MyThemeWithSizerBuilder extends StatelessWidget {
  const MyThemeWithSizerBuilder({
    super.key,
    required this.fontSizeFactor,
    required this.fontSizeDelta,
    required this.iconThemeSize,
    required this.child,
  });
  final double fontSizeFactor;
  final double fontSizeDelta;
  final double iconThemeSize;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: fontSizeFactor, fontSizeDelta: fontSizeDelta),
        iconTheme: Theme.of(context).iconTheme.copyWith(size: iconThemeSize),
      ),
      child: child,
    );
  }
}
