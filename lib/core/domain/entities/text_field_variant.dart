import 'package:clear_app_helper/core/domain/entities/keyboard_mode.dart';

sealed class TextFieldVariant with KeyboardMode {
  const factory TextFieldVariant.integer() = IntegerTextFieldVariant;
  const factory TextFieldVariant.double() = DoubleTextFieldVariant;
  const factory TextFieldVariant.text() = TextTextFieldVariant;
  const factory TextFieldVariant.multilineText() = MultilineTextFieldVariant;
}

class MultilineTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const MultilineTextFieldVariant();
}

class IntegerTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const IntegerTextFieldVariant();
}

class DoubleTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const DoubleTextFieldVariant();
}

class TextTextFieldVariant with KeyboardMode implements TextFieldVariant {
  const TextTextFieldVariant();
}
