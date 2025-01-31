abstract class AppFailure implements Exception {
  String message;
  StackTrace? stackTrace;
  AppFailure(this.message, [this.stackTrace]);
}

class HttpResponseError extends AppFailure {
  HttpResponseError({
    required String message,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  @override
  String toString() {
    if (stackTrace != null) {
      return '$runtimeType: $message\n$stackTrace';
    }
    return '$runtimeType: $message';
  }
}
