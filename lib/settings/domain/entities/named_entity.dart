import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

class NamedSearchEntity<T extends SearchEntity> {
  NamedSearchEntity(this.name, this.searchEntity);
  final String name;
  final T searchEntity;
}
