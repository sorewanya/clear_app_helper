import 'package:clear_app_helper/core/domain/entities/app_entity.dart';

// ignore: avoid_implementing_value_types
abstract class DBLog implements AppEntity {
  final DateTime timestamp = DateTime.now();
  final int itemId = 0;
}
