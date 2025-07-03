import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class IconViewAndPickerButton extends StatelessWidget {
  const IconViewAndPickerButton({super.key, this.setString, this.setInt, required this.initIconCode});

  /// new codePoint callbacks
  final Function(String? codeString)? setString;
  final Function(int code)? setInt;

  final int? initIconCode;

  @override
  Widget build(BuildContext context) {
    Map<String, IconPickerIcon> myIconMap = {};
    iconMap.forEach(
      (key, value) => myIconMap[key] = IconPickerIcon(
        data: MdiIconData(value.codePoint),
        name: "${value.codePoint}",
        pack: IconPack.custom,
      ),
    );
    return initIconCode != null
        ? TextButton(
            onPressed: () async {
              IconData? icon = (await showIconPicker(
                context,
                configuration: SinglePickerConfiguration(iconPackModes: [IconPack.custom], customIconPack: myIconMap),
              ))?.data;
              if (icon != null) {
                if (setString != null) setString!(icon.codePoint.toString());
                if (setInt != null) setInt!(icon.codePoint);
              }
            },
            child: Row(children: [Icon(MdiIconData(initIconCode!), size: 40), const Text(" Изменить иконку")]),
          )
        : const SizedBox();
  }
}
