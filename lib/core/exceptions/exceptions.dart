/// Base class for all exceptions in the app.
///
/// This class extends the [Exception] class and provides a custom message
/// and an optional stack trace
abstract class AppException implements Exception {
  /// The message that describes the exception.
  final String message;

  /// The stack trace that provides information about where the exception occurred.
  final StackTrace? stackTrace;

  ///- [message] parameter is required and should provide a description of the exception.
  ///- [stackTrace] parameter is optional and can be used to provide additional information about the exception.
  AppException(this.message, [this.stackTrace]);

  @override
  String toString() {
    if (stackTrace != null) {
      return '$runtimeType: $message\n$stackTrace';
    }

    return '$runtimeType: $message';
  }
}

/// Exception thrown when an unexpected error occurs.
class UnknownException extends AppException {
  UnknownException(super.message, [super.stackTrace]);
}

/// Exception thrown when a network error occurs.
class NetworkException extends AppException {
  NetworkException([
    super.message = "Network error occurred",
    super.stackTrace,
  ]);
}

/// Exception thrown when a data format is invalid.
class FormatException extends AppException {
  FormatException(super.message, [super.stackTrace]);
}

/// Exception thrown when parsing data fails.
class ParseException extends AppException {
  ParseException(super.message, [super.stackTrace]);
}
