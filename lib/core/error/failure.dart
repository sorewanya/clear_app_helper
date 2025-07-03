sealed class Failure {
  const factory Failure.serverFailure(Exception exception, StackTrace stackTrace) = ServerFailure;
  const factory Failure.emptyLocalStorageFailure() = EmptyLocalStorageFailure;
  const factory Failure.cacheFailure(Exception exception, StackTrace stackTrace) = CacheFailure;
  const factory Failure.castDeleteOnUndeleted() = CastDeleteOnUndeleted;
  const factory Failure.tryRemoveAll() = TryRemoveAll;
}

class TryRemoveAll implements Failure {
  const TryRemoveAll();
}

mixin FailureWithExAndStack {
  Exception get exception;
  StackTrace get stackTrace;
}

class ServerFailure with FailureWithExAndStack implements Failure {
  const ServerFailure(this.exception, this.stackTrace);
  @override
  final Exception exception;
  @override
  final StackTrace stackTrace;
}

class EmptyLocalStorageFailure implements Failure {
  const EmptyLocalStorageFailure();
}

class CacheFailure with FailureWithExAndStack implements Failure {
  const CacheFailure(this.exception, this.stackTrace);
  @override
  final Exception exception;
  @override
  final StackTrace stackTrace;
}

class CastDeleteOnUndeleted implements Failure {
  const CastDeleteOnUndeleted();
}
