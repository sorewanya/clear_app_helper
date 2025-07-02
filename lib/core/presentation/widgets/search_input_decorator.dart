import 'package:clear_app_helper/core/presentation/widgets/search_button.dart';
import 'package:flutter/material.dart';

InputDecoration getDefaultSearchInputDecorator({required String labelAndHintText, required Function onPressed}) {
  return InputDecoration(
    labelText: labelAndHintText,
    hintText: labelAndHintText,
    prefixIcon: SearchButtonWidget(onPressed: onPressed),
    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
  );
}
