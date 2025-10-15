import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_info_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsInfoPage extends StatelessWidget {
  const SettingsInfoPage({super.key, this.textButtonsMap, this.drawer});
  final Map<Widget, dynamic Function()?>? textButtonsMap;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return MyScaffoldInfoWidget(
      appBarTitle: GetIt.instance<CoreI18n>().settings,
      description: Text(GetIt.instance<CoreI18n>().settingsMainDiscription),
      settingsSearchName: '',
      drawer: drawer,
      textButtonsMap:
          textButtonsMap ??
          {
            Text('${GetIt.instance<CoreI18n>().settingsList}(${GetIt.instance<CoreI18n>().viewStyleList})'): () =>
                RouteHelper.toNamed(
                  SettingsRouteNames.settingsViewPage,
                  arguments: const SettingsSearchEntity(viewStyle: 'list'),
                ),
            Text('${GetIt.instance<CoreI18n>().settingsList}(${GetIt.instance<CoreI18n>().viewStyleTree})'): () =>
                RouteHelper.toNamed(
                  SettingsRouteNames.settingsViewPage,
                  arguments: const SettingsSearchEntity(viewStyle: 'tree'),
                ),
            Text(GetIt.instance<CoreI18n>().settingsViewStyleDefault): () => RouteHelper.toNamed(
              SettingsRouteNames.settingsDetailPage,
              arguments: SettingsSearchEntity(
                id: context.read<SettingsBloc>().getIdByNamed(SettingsSettingsEnum.viewDefault.name),
              ),
            ),
          },
    );
  }
}
