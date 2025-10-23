import 'package:clear_app_helper/core/domain/entities/map_of_widgets.dart';
import 'package:flutter/material.dart';

class ListToWidgetHelper {
  ListToWidgetHelper(this.widgetsList, this.mapOfWidgets);
  final List<String> widgetsList;
  final MapOfWidgets mapOfWidgets;
  Widget _getWidgetByName(String name) => widgetsList.contains(name) ? mapOfWidgets.getWidget(name) : const SizedBox();

  Widget _getRowFromList(
    List<String> listOfNames, {
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) => Row(
    crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
    children: listOfNames.map(_getWidgetByName).toList(),
  );
  Widget _getColumnFromList(List<String> listOfNames, {mainAxisAlignment, crossAxisAlignment}) =>
      Column(children: listOfNames.map(_getWidgetByName).toList());

  void getWidgetByName(
    Function(
      Widget Function(String name) getWidgetByName,
      Widget Function(
        List<String> listOfNames, {
        MainAxisAlignment mainAxisAlignment,
        CrossAxisAlignment crossAxisAlignment,
      })
      getRowFromList,
      Widget Function(
        List<String> listOfNames, {
        MainAxisAlignment mainAxisAlignment,
        CrossAxisAlignment crossAxisAlignment,
      })
      getColumnFromList,
    )
    getWidgetByNameFunc,
  ) => getWidgetByNameFunc(_getWidgetByName, _getRowFromList, _getColumnFromList);
}
