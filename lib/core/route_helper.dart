import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RouteHelper {
  static Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) => Get.toNamed(page, arguments: arguments, id: id, parameters: parameters, preventDuplicates: preventDuplicates);
  static back<T>({T? result, bool closeOverlays = false, bool canPop = true, int? id}) =>
      Get.back(result: result, closeOverlays: closeOverlays, canPop: canPop, id: id);
  static Future<T?>? offNamedUntil<T>(
    String page,
    bool Function(Route<dynamic>) predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) => Get.offNamedUntil(page, predicate, id: id, arguments: arguments, parameters: parameters);
  static Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) => Get.offAndToNamed(page, arguments: arguments, id: id, result: result, parameters: parameters);
  static reloadAll({bool force = false}) => Get.reloadAll(force: force);
}
