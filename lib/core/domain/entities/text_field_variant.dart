import 'package:clear_app_helper/core/domain/entities/keyboard_mode.dart';

class DoubleTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const DoubleTextFieldVariant();
}

class IntegerTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const IntegerTextFieldVariant();
}

class MultilineTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const MultilineTextFieldVariant();
}

sealed class TextFieldVariant with KeyboardMode {
  const factory TextFieldVariant.double() = DoubleTextFieldVariant;
  const factory TextFieldVariant.integer() = IntegerTextFieldVariant;
  const factory TextFieldVariant.multilineText() = MultilineTextFieldVariant;
  const factory TextFieldVariant.text() = TextTextFieldVariant;
}

class TextTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const TextTextFieldVariant();
}
