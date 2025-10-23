import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchCaseSensitiveWarningWidget extends StatelessWidget {
  const SearchCaseSensitiveWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool caseSensitive =
        context.read<SettingsBloc>().getUserOrDefaultValueByNamed(CoreSettingsEnum.searchCaseSensitive.name) == 'true';
    return caseSensitive
        ? Row(
            children: [
              Text(GetIt.instance<CoreI18n>().caseSensitiveSearchWarning),
              TextButton(
                onPressed: () => RouteHelper.toNamed(
                  SettingsRouteNames.settingsViewPage,
                  arguments: const SettingsSearchEntity(name: 'search.caseSensitive'),
                ),
                child: IconsHelper.getIconByEnum(IconSettingsEnum.settingsItem),
              ),
            ],
          )
        : const SizedBox();
  }
}
