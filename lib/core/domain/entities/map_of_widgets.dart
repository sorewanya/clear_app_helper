import 'package:flutter/material.dart';

///FIXME refactoring to Map<String, Widget Function(Type itemCO)> ?
class MapOfWidgets {
  final Map<String, Widget> mapOfWidgets;

  MapOfWidgets(this.mapOfWidgets);

  Widget getWidget(String widgetName) => mapOfWidgets[widgetName] ?? Text("виджет $widgetName не найден");
}
