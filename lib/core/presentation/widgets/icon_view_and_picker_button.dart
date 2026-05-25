import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconViewAndPickerButton extends StatelessWidget {
  /// Creates an icon picker button.
  const IconViewAndPickerButton({required this.value, required this.onSelected, super.key});

  /// Preview size for the selected icon in pixels.
  static const _previewIconSize = 60.0;

  /// Fallback icon used when the deserialized icon has an invalid code point.
  static const _fallbackIcon = Icons.help;

  /// Currently selected icon as `"pack:name"` string, or null.
  final String? value;

  /// Callback with the selected `"pack:name"` string, or null if cleared.
  final ValueChanged<String?> onSelected;

  /// Deserializes [value] to [IconPickerIcon] for preview rendering.
  ///
  /// Returns `null` if [value] is `null` or deserialization fails.
  IconPickerIcon? get _iconPickerIcon {
    if (value == null) return null;
    final tryInt = int.tryParse(value ?? '');
    if (tryInt != null) {
      return IconPickerIcon(
        name: '',
        data: IconData(tryInt, fontFamily: 'Material Design Icons', fontPackage: 'flutter_material_design_icons'),
        pack: 'flutter_material_design_icons',
      );
    }
    return IconsHelper.deserialize(value!);
  }

  @override
  Widget build(BuildContext context) {
    final icon = _iconPickerIcon;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        _buildIconPreview((icon == null || icon.data.codePoint == 0) ? _fallbackIcon : icon.data),
        const SizedBox(width: 8),
        if (icon != null) ...[_buildIconLabel(icon, colorScheme), _buildClearButton()],
        FilledButton.icon(
          onPressed: () => _pickIcon(context),
          icon: const Icon(Icons.apps),
          label: Text(value != null ? 'Change' : 'Select icon'),
        ),
      ],
    );
  }

  /// Builds the clear button that resets the selection to `null`.
  Widget _buildClearButton() {
    return IconButton(
      icon: const Icon(Icons.clear, size: 18),
      onPressed: () => onSelected(null),
      tooltip: 'Clear',
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
    );
  }

  /// Builds the [RichText] label showing pack name and icon name.
  Widget _buildIconLabel(IconPickerIcon icon, ColorScheme colorScheme) {
    return Expanded(
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: icon.pack,
              style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurfaceVariant),
            ),
            TextSpan(
              text: icon.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the preview [Icon] widget for the selected icon.
  Widget _buildIconPreview(IconData iconData) {
    return Icon(key: Key('IconPreview'), iconData, size: _previewIconSize);
  }

  /// Opens the icon picker and handles the selected result.
  Future<void> _pickIcon(BuildContext context) async {
    // Note: In tests, this call is not mocked; integration tests should
    // verify the callback behavior at a higher level or refactor for testability.
    final icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [
          IconPack.allMaterial,
          // TODO  restore after update flutter_iconpicker >4.0.3 or use customIconPack:
          IconPack.fontAwesomeIcons,
        ],
      ),
    );
    if (icon != null) {
      onSelected(IconsHelper.serialize(icon));
    }
  }
}
