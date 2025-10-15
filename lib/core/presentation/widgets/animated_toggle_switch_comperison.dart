import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:clear_app_helper/core/domain/entities/comparison.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

///AnimatedToggleSwitch with ```> >= < <= = !=``` in  [values]
class AnimatedToggleSwitchComparison extends StatelessWidget {
  /// initial comparison
  final Comparison comparison;

  /// new comparison callback
  final Function(Comparison) setComparison;

  final List<Comparison>? values;

  const AnimatedToggleSwitchComparison({
    required this.comparison,
    required this.setComparison,
    required this.values,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = Theme.of(context).iconTheme.size ?? 20;
    return AnimatedToggleSwitch<Comparison>.rolling(
      current: comparison,
      height: size * 2,
      borderWidth: size * 0.1,
      values:
          values ??
          const [
            Comparison.greaterThan,
            Comparison.greaterThanOrEqual,
            Comparison.lessThan,
            Comparison.lessThanOrEqual,
            Comparison.equal,
            Comparison.notEqual,
          ],
      onChanged: setComparison,
      iconBuilder: (value, foreground) {
        return Icon(IconsHelper.getIconDataByString(Comparison.fromComparison(value)));
      },
    );
  }
}
