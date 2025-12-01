import 'package:flutter/material.dart';

class TextWarning extends StatelessWidget {
  const TextWarning(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Theme.of(context).colorScheme.error.withValues(alpha: 0.8)));
  }
}
