import 'package:flutter/material.dart';
import 'package:get/get.dart';

InputDecoration getDefaultInputDecorator({required String labelAndHintText, TextStyle? labelStyle}) {
  return InputDecoration(
    labelText: labelAndHintText,
    hintText: labelAndHintText,
    labelStyle: labelStyle ?? Get.theme.textTheme.headlineMedium,
    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
  );
}
