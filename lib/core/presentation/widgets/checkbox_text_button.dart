import 'package:clear_app_helper/core/presentation/widgets/icon_true_false.dart';
import 'package:flutter/material.dart';

class CheckboxTextButton extends StatelessWidget {
  const CheckboxTextButton({super.key, this.onPressed, required this.check, required this.checkName});

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
