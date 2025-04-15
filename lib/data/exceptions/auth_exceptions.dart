import 'package:teste_lisa_it/core/exceptions/exceptions.dart';

/// Exception thrown when auth related errors occur.
class AuthException extends AppException {
  AuthException(super.message, [super.stackTrace]);
}

/// Exception thrown when the provided credentials are invalid.
class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(super.message, [super.stackTrace]);
}
