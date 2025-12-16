import 'package:clear_app_helper/core/datasources/default_data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  ///
  /// !!!!!WARNING!!!!
  ///
  /// UNCOMENT NEXT LINE AND ADD YOUR DefaultData !!
  // getIt.registerLazySingleton<AbstractDefaultData>(() => DefaultData());
  AbstractDefaultData.defaultGetItSingletons(getIt);
}
