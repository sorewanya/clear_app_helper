import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/platform/network_info.dart';
import 'package:clear_app_helper/core/presentation/bloc/curent_entity/curent_entity_bloc_bloc.dart';
import 'package:clear_app_helper/core/presentation/theme_data.dart';
import 'package:clear_app_helper/settings/data/repositories/settings_description_repository.dart';
import 'package:clear_app_helper/settings/data/repositories/settings_repository.dart';
import 'package:clear_app_helper/settings/domain/usecase/settings_description_use_case.dart';
import 'package:clear_app_helper/settings/domain/usecase/settings_use_case.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

init() {
  ///
  /// !!!!!WARNING!!!!
  ///
  /// UNCOMENT NEXT LINE AND ADD YOUR DefaultData !!
  // getIt.registerLazySingleton<AbstractDefaultData>(() => DefaultData());

  getIt.registerLazySingleton<MyThemeData>(() => MyThemeData());
  getIt.registerLazySingleton<CoreI18n>(() => CoreI18nRu());
  getIt.registerLazySingleton<SharedPreferencesHelper>(() => SharedPreferencesHelper());

  getIt.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(settingsUseCase: getIt(), settingsDescriptionUseCase: getIt(), defaults: getIt()),
  );
  getIt.registerLazySingleton<CurentEntityBloc>(() => CurentEntityBloc());
  getIt.registerLazySingleton(() => SettingsUseCase(getIt<SettingsRepository>()));
  getIt.registerLazySingleton(() => SettingsDescriptionUseCase(getIt<SettingsDescriptionRepository>()));
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  final internetConnectionChecker = InternetConnectionChecker.createInstance(
    addresses: List<AddressCheckOption>.unmodifiable(<AddressCheckOption>[
      AddressCheckOption(uri: Uri.https("google.com")),
    ]),
    slowConnectionConfig: SlowConnectionConfig(
      enableToCheckForSlowConnection: true,
      slowConnectionThreshold: const Duration(seconds: 1),
    ),
  );
  getIt.registerLazySingleton<InternetConnectionChecker>(() => internetConnectionChecker);
}
