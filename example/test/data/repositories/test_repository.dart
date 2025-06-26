import 'package:clear_app_helper/core/datasources/repository.dart';

import '../../domain/entities/search/test_search_entity.dart';
import '../../domain/entities/test_entity.dart';

class TestRepository extends Repository<TestEntity, TestSearchEntity> {
  TestRepository({required super.networkInfo, required super.localDataSource});
}
