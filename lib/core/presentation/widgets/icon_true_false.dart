import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

///Icon to show true or false
class IconTrueFalse extends StatelessWidget {
  final bool check;

  const IconTrueFalse({super.key, required this.check});

  @override
  Widget build(BuildContext context) {
    return Icon(
      check
          ? IconsHelper.getIconDataByEnum(IconSettingsEnum.trueIcon)
          : IconsHelper.getIconDataByEnum(IconSettingsEnum.falseIcon),
    );
  }
}
