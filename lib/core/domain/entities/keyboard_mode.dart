import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:flutter/services.dart';

mixin KeyboardMode {
  List<FilteringTextInputFormatter>? get inputFormatters => switch (this) {
    IntegerTextFieldVariant() => [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
    DoubleTextFieldVariant() => [FilteringTextInputFormatter.allow(RegExp(r'^[0-9\.,]+$'))],
    _ => null,
  };
  TextInputType get keyboardType => switch (this) {
    IntegerTextFieldVariant() => TextInputType.number,
    DoubleTextFieldVariant() => TextInputType.number,
    MultilineTextFieldVariant() => TextInputType.multiline,
    _ => TextInputType.text,
  };
}
