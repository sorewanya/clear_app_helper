import 'package:clear_app_helper/core/presentation/widgets/icon_true_false.dart';
import 'package:flutter/material.dart';

class CheckboxTextButton extends StatelessWidget {
  const CheckboxTextButton({required this.check, required this.checkName, super.key, this.onPressed});

  final Function()? onPressed;
  final bool check;
  final String checkName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          IconTrueFalse(check: check),
          const SizedBox(width: 5),
          Text(checkName),
        ],
      ),
    );
  }
}
