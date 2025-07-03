import 'package:clear_app_helper/core/error/failure.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:get_it/get_it.dart';

String mapFailureToMessage(Failure failure) {
  return switch (failure) {
    Failure.serverFailure => GetIt.instance<CoreI18n>().serverFailureMessage,
    Failure.emptyLocalStorageFailure => GetIt.instance<CoreI18n>().emptyLocalStorageFailureMessage,
    Failure.cacheFailure => GetIt.instance<CoreI18n>().cachedFailureMessage,
    _ => "Unexpected Error $failure",
  };
}
