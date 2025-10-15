import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// delete/restore FloatingActionButton
class FloatingRevertDeleteIconButton extends StatelessWidget {
  const FloatingRevertDeleteIconButton({required this.isDeleted, required this.onPressed, super.key});

  final Function() onPressed;

  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: const ValueKey('delete'),
      onPressed: onPressed,
      tooltip: isDeleted ? GetIt.instance<CoreI18n>().restore : GetIt.instance<CoreI18n>().delete,
      child: Icon(
        !isDeleted
            ? IconsHelper.getIconDataByEnum(IconSettingsEnum.delete)
            : IconsHelper.getIconDataByEnum(IconSettingsEnum.restore),
        color: Colors.red,
      ),
    );
  }
}
