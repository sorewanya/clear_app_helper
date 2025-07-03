import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchFindTextAndIconButton extends StatelessWidget {
  final Function()? onTap;
  const SearchFindTextAndIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(GetIt.instance<CoreI18n>().find),
          const SizedBox(width: 10),
          IconsHelper.getIconByEnum((IconSettingsEnum.searchSearch)),
        ],
      ),
    );
  }
}
