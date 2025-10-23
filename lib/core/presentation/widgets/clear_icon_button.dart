import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

class ClearIconButton extends StatelessWidget {
  const ClearIconButton({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: IconsHelper.getIconByEnum(IconSettingsEnum.close));
  }
}
