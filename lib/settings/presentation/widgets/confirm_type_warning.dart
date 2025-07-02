import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:clear_app_helper/core/presentation/widgets/text_warning.dart';

import 'package:clear_app_helper/settings/domain/entities/settings_required_types.dart';
import 'package:get_it/get_it.dart';

class ConfirmTypeWarning extends StatelessWidget {
  final int? confirmType;
  const ConfirmTypeWarning({super.key, this.confirmType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (confirmType == SettingsRequiredTypesEnum.required.index)
          TextWarning(GetIt.instance<CoreI18n>().settingsIsRequired),
        if (confirmType == SettingsRequiredTypesEnum.requiredStop.index)
          TextWarning(GetIt.instance<CoreI18n>().settingsIsRequiredStop),
      ],
    );
  }
}
