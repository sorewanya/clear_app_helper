import 'package:flutter/material.dart';

class MyPaddedDecoratedBoxWithOpacity extends StatelessWidget {
  const MyPaddedDecoratedBoxWithOpacity({
    super.key,
    this.padding = const EdgeInsets.all(4.0),
    this.decoration,
    this.child,
    this.borderOpacity = 0.3,
    this.colorOpacity = 0.6,
    this.borderRadius,
    this.color,
  });
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final Widget? child;
  final double borderOpacity;
  final double colorOpacity;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: decoration ??
            BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight.withValues(alpha: borderOpacity)),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              color: color ?? Theme.of(context).primaryColor.withValues(alpha: colorOpacity),
            ),
        child: child,
      ),
    );
  }
}
