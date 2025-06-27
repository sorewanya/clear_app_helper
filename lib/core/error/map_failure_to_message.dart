import 'package:clear_app_helper/core/error/failure.dart';

const String serverFailureMessage = "Ошибка сервера! Повтор попытки каждые 5 сек.";
//TODO разобраться, при пустом поиске по идее тоже повторы каждые 5 сек. нужно ли такое?
const String emptyLocalStorageFailureMessage = "Ничего не найдено!";
const String cachedFailureMessage = "Ошибка локальной БД. Повтор попытки каждые 5 сек.";

String mapFailureToMessage(Failure failure) {
  return switch (failure) {
    Failure.serverFailure => serverFailureMessage,
    Failure.emptyLocalStorageFailure => emptyLocalStorageFailureMessage,
    Failure.cacheFailure => cachedFailureMessage,
    _ => "Unexpected Error $failure",
  };
}
