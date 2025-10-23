import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

//TODO make replacement
Future<bool> colorPickerDialog(
  BuildContext context, {
  required int colorValue,
  required Function(Color color) onColorChanged,
}) async {
  return ColorPicker(
    // Use the dialogPickerColor as start color.
    color: Color(colorValue),
    // Update the dialogPickerColor using the callback.
    onColorChanged: onColorChanged,
    borderRadius: 4,
    spacing: 5,
    runSpacing: 5,
    wheelDiameter: 155,
    heading: Text('Select color', style: Theme.of(context).textTheme.titleSmall),
    subheading: Text('Select color shade', style: Theme.of(context).textTheme.titleSmall),
    wheelSubheading: Text('Selected color and its shades', style: Theme.of(context).textTheme.titleSmall),
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    copyPasteBehavior: const ColorPickerCopyPasteBehavior(longPressMenu: true),
    materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
    colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
    colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    },
    // customColorSwatchesAndNames: colorsNameMap,
  ).showPickerDialog(context, constraints: const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320));
}
