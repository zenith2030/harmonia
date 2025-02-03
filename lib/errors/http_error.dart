abstract class AppFailure implements Exception {
  String message;
  StackTrace? stackTrace;
  AppFailure(this.message, [this.stackTrace]);

  @override
  String toString() {
    if (stackTrace != null) {
      return '$runtimeType: $message\n$stackTrace';
    }
    return '$runtimeType: $message';
  }
}

class HttpResponseError extends AppFailure {
  HttpResponseError({
    required String message,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

class LoginError extends AppFailure {
  LoginError({
    required String message,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

class LocalStorageError extends AppFailure {
  LocalStorageError({
    required String message,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}
