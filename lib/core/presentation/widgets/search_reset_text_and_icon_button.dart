import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchResetTextAndIconButton extends StatelessWidget {
  const SearchResetTextAndIconButton({super.key, required this.onTap, this.openEndDrawer});

  final Function()? onTap;

  /// if true add buttoon to open drawer
  final bool? openEndDrawer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onTap,
          child: Row(
            children: [
              Text(GetIt.instance<CoreI18n>().searchResetButtonText),
              const SizedBox(width: 10),
              IconsHelper.getIconByEnum((IconSettingsEnum.searchReset)),
            ],
          ),
        ),
        if (openEndDrawer != null)
          TextButton(
            onPressed: (() => Scaffold.of(context).openEndDrawer()),
            child: Text(GetIt.instance<CoreI18n>().searchShowSettings),
          ),
      ],
    );
  }
}
