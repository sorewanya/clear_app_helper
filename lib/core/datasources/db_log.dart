import 'package:clear_app_helper/core/domain/entities/app_entity.dart';

abstract class DBLog extends AppEntity {
  @override
  // ignore: overridden_fields
  final int? id = 0;
  final DateTime timestamp = DateTime.now();
  final int itemId = 0;
}
