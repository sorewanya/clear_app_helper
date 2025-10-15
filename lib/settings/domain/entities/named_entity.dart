import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

// ignore: avoid_types_as_parameter_names
class NamedSearchEntity<Type extends SearchEntity> {
  NamedSearchEntity(this.name, this.searchEntity);
  final String name;
  final Type searchEntity;
}
