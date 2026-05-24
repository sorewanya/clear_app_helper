import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class IconViewAndPickerButton extends StatelessWidget {
  const IconViewAndPickerButton({required this.initIconCode, super.key, this.setString, this.setInt});

  /// new codePoint callbacks
  final Function(String? codeString)? setString;
  final Function(int code)? setInt;

  final int? initIconCode;

  @override
  Widget build(BuildContext context) {
    final Map<String, IconPickerIcon> myIconMap = {};
    iconMap.forEach(
      (key, value) => myIconMap[key] = IconPickerIcon(
        data: IconsHelper.mdi(value.codePoint),
        name: '${value.codePoint}',
        pack: IconPack.custom.name,
      ),
    );
    return initIconCode != null
        ? TextButton(
            onPressed: () async {
              final IconData? icon = (await showIconPicker(
                context,
                configuration: SinglePickerConfiguration(iconPackModes: [IconPack.custom], customIconPack: myIconMap),
              ))?.data;
              if (icon != null) {
                setString?.call(icon.codePoint.toString());
                setInt?.call(icon.codePoint);
              }
            },
            child: Row(children: [Icon(IconsHelper.mdi(initIconCode!), size: 40), const Text(' Изменить иконку')]),
          )
        : const SizedBox();
  }
}
