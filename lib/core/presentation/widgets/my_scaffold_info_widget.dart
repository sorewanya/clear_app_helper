import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// wrapper around [MyScaffoldWidget]
class MyScaffoldInfoWidget extends StatelessWidget {
  const MyScaffoldInfoWidget({
    required this.appBarTitle,
    required this.drawer,
    required this.description,
    required this.textButtonsMap,
    required this.settingsSearchName,
    this.appBarLeading,
    super.key,
  });

  /// send to [MyScaffoldWidget]
  final String appBarTitle;

  /// send to [MyScaffoldWidget]
  final Widget? appBarLeading;

  /// send to [MyScaffoldWidget]
  final Widget? drawer;

  ///main AppEntity discription
  final Widget description;

  /// Map\<child,onPressed\> converted to [TextButton] list
  final Map<Widget, Function()?> textButtonsMap;

  ///sended to [SettingsSearchEntity] (name: [settingsSearchName])
  final String settingsSearchName;

  @override
  Widget build(BuildContext context) {
    final List<Widget> textButtons = [];
    textButtonsMap.forEach((key, value) => textButtons.add(TextButton(onPressed: value, child: key)));

    return MyScaffoldWidget(
      appBarTitle: Text(appBarTitle),
      appBarLeading: appBarLeading,
      drawer: drawer,
      body: Column(
        children: [
          description,
          ...textButtons,
          TextButton(
            onPressed: () => RouteHelper.toNamed(
              SettingsRouteNames.settingsViewPage,
              arguments: SettingsSearchEntity(name: settingsSearchName),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(GetIt.instance<CoreI18n>().settings),
                Icon(IconsHelper.getIconDataByEnum(IconSettingsEnum.settingsItem)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
