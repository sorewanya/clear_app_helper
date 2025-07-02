import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clear_app_helper/core/presentation/widgets/text_warning.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:get_it/get_it.dart';

class ViewDefaultCaseWidget extends StatelessWidget {
  const ViewDefaultCaseWidget({
    super.key,
    required this.viewStyle,
    required this.viewDefaultSettings,
    required this.listWidget,
    required this.treeWidget,
    required this.graphWidget,
  });
  final String? viewStyle;
  final EnumsOfSettings viewDefaultSettings;
  final Widget listWidget;
  final Widget? treeWidget;
  final Widget? graphWidget;

  @override
  Widget build(BuildContext context) {
    final view =
        viewStyle ?? context.read<SettingsBloc>().getValueNameFromUserOrDefaultValueByEnum(viewDefaultSettings);
    if (view == "list") {
      return listWidget;
    }
    if (view == "tree") {
      return treeWidget ?? listWidget;
    }
    if (view == "graph") {
      return graphWidget ?? listWidget;
    }
    return TextWarning("${GetIt.instance<CoreI18n>().viewDefaultErrorText} $viewDefaultSettings");
  }
}
