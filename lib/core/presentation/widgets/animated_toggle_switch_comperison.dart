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
    super.key,
    required this.comparison,
    required this.setComparison,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<Comparison>.rolling(
      current: comparison,
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
      onChanged: (i) => setComparison(i),
      iconBuilder: ((value, foreground) {
        return Icon(IconsHelper.getIconDataByString(Comparison.fromComparison(value)));
      }),
    );
  }
}
