import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FloatingSaveButton extends StatelessWidget {
  const FloatingSaveButton({required this.saveForm, super.key});

  final Function()? saveForm;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: const ValueKey('save'),
      tooltip: GetIt.instance<CoreI18n>().save,
      onPressed: saveForm,
      child: IconsHelper.getIconByEnum(IconSettingsEnum.save),
    );
  }
}
