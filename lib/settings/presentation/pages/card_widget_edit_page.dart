import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/settings_builder_widget.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/presentation/widgets/card_widget_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class CardWidgetEditPage extends StatelessWidget {
  final Widget drawer;
  const CardWidgetEditPage({required this.drawer, super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};
    final List<String> listOfNames = arg['list'] as List<String>? ?? [];
    final String routeName = arg['routeName'] as String? ?? SettingsRouteNames.settingsViewPage;

    return Scaffold(
      body: SettingsBuilderWidget(
        childFunc: (sf) => MyScaffoldWidget(
          appBarTitle: Text(GetIt.instance<CoreI18n>().settings),
          body: CardWidgetEditWidget(listOfNames: listOfNames, routeName: routeName),
          drawer: drawer,
        ),
      ),
    );
  }
}
