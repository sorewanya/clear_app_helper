import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

class ItemDeleteIcon extends StatelessWidget {
  const ItemDeleteIcon({super.key, required this.isDeleted, required this.onPressed});

  final bool isDeleted;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Icon(
        isDeleted
            ? IconsHelper.getIconDataByEnum(IconSettingsEnum.restore)
            : IconsHelper.getIconDataByEnum(IconSettingsEnum.delete),
      ),
    );
  }
}
