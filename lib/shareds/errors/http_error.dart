abstract class Failure implements Exception {
  String message;
  StackTrace? stackTrace;
  Failure(this.message, [this.stackTrace]);
}

class HttpResponseError extends Failure {
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
