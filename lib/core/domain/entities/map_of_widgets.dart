import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

///FIXME refactoring to [Map<String, Widget Function(Type itemCO)>] ?
class MapOfWidgets {
  MapOfWidgets(this.mapOfWidgets);

  final Map<String, Widget> mapOfWidgets;

  Widget getWidget(String widgetName) =>
      mapOfWidgets[widgetName] ??
      Text('${GetIt.instance<CoreI18n>().widget} $widgetName ${GetIt.instance<CoreI18n>().notFound.toLowerCase()}');
}
