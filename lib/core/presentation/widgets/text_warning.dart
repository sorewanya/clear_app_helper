import 'package:flutter/material.dart';

class TextWarning extends StatelessWidget {
  final String text;
  const TextWarning(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Theme.of(context).colorScheme.error.withValues(alpha: 0.8)));
  }
}
