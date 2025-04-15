import 'package:teste_lisa_it/core/exceptions/exceptions.dart';

/// Base class for all API-related exceptions.
///
/// This class provides a common structure for exceptions that occur
/// during API requests, such as HTTP errors or unexpected responses.
abstract class ApiException extends AppException {
  /// Creates an [ApiException] with the given [message].
  ApiException(super.message, [super.stackTrace]);
}

/// Exception thrown when the server returns a 400 Bad Request status code.
///
/// This typically indicates that the request sent to the server was invalid
/// or malformed.
class BadRequestException extends ApiException {
  BadRequestException() : super('Bad request.');
}

/// Exception thrown when the server returns a 401 Unauthorized status code.
///
/// This indicates that the client must authenticate itself to get the
/// requested response.
class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized access.');
}

/// Exception thrown when the server returns a 500 Internal Server Error status code.
///
/// This indicates that the server encountered an unexpected condition
/// that prevented it from fulfilling the request.
class ServerErrorException extends ApiException {
  ServerErrorException() : super('Internal server error.');
}

/// Exception thrown when the server returns a 404 Not Found status code.
///
/// This indicates that the requested resource could not be found on the server.
class NotFoundException extends ApiException {
  NotFoundException() : super('Resource not found.');
}

/// Exception thrown when the server returns a 403 Forbidden status code.
///
/// This indicates that the client does not have permission to access the requested resource.
class ForbiddenException extends ApiException {
  ForbiddenException() : super('Forbidden access.');
}

/// Exception thrown when a request times out.
///
/// This typically occurs when the server takes too long to respond to the client's request.
class RequestTimeoutException extends ApiException {
  RequestTimeoutException() : super('Request timed out.');
}

/// Exception thrown when a request is cancelled.
///
/// This typically occurs when the client cancels the request before it is completed.
class RequestCancelledException extends ApiException {
  RequestCancelledException() : super('Request was cancelled.');
}
