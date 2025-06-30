import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// widget Floating button "+"
class FloatingPlusIconButton extends StatelessWidget {
  const FloatingPlusIconButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: const ValueKey('plus'),
          tooltip: GetIt.instance<CoreI18n>().newItem,
          onPressed: onPressed,
          child: IconsHelper.getIconByEnum((IconSettingsEnum.add)),
        ),
      ],
    );
  }
}
