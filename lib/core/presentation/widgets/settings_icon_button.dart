import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';

class SettingsIconButton extends StatelessWidget {
  final String routeName;

  const SettingsIconButton({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => RouteHelper.offNamedUntil(routeName, (route) => false),
      child: IconsHelper.getIconByEnum((IconSettingsEnum.settingsItem)),
    );
  }
}
