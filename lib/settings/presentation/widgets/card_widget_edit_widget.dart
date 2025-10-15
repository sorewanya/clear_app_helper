import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/list_of_values_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CardWidgetEditWidget extends StatelessWidget {
  final List<String> listOfNames;
  final String routeName;
  const CardWidgetEditWidget({required this.listOfNames, required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsEntity> listOfSettings = listOfNames
        .map((e) => context.read<SettingsBloc>().getByNamed(e))
        .whereType<SettingsEntity>()
        .toList();
    final List<Widget> listOfWidget = [];
    for (SettingsEntity item in listOfSettings) {
      listOfWidget
        ..add(Text("${GetIt.instance<CoreI18n>().widgetEditPartsIn} ${item.name.split(',').last}:"))
        ..add(
          ListOfValuesWidget(
            userValue: item.getUserOrDefaultValueAsString,
            values: item.values ?? [],
            updateUserValue: context.read<SettingsBloc>().updateUserValueCallback(item),
          ),
        )
        ..add(const SizedBox(height: 5));
    }
    listOfWidget.add(
      TextButton(
        onPressed: () => RouteHelper.toNamed(routeName),
        child: Text(GetIt.instance<CoreI18n>().widgetEditSeeResult),
      ),
    );
    return SingleChildScrollView(child: Column(children: listOfWidget));
  }
}
