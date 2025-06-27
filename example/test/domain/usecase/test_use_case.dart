import 'package:clear_app_helper/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/search/test_search_entity.dart';
import '../entities/test_entity.dart';

class TestUseCase extends UseCase<TestEntity, TestSearchEntity> with UseCaseWithRevertDelete {
  TestUseCase(super.repository);
}

class TestUseCaseParams extends UseCaseParams<TestSearchEntity> with EquatableMixin {
  TestUseCaseParams(super.searchEntity);

  @override
  List<Object?> get props => [searchEntity];
}
