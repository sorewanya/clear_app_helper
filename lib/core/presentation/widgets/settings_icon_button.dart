import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({required this.routeName, super.key});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => RouteHelper.offNamedUntil(routeName, (route) => false),
      child: IconsHelper.getIconByEnum(IconSettingsEnum.settingsItem),
    );
  }
}
