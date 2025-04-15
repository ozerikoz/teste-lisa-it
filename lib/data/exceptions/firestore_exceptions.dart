import 'package:teste_lisa_it/core/exceptions/exceptions.dart';

/// Exception thrown for Firestore-related errors.
class FirestoreException extends AppException {
  final String? code;

  FirestoreException(super.message, [this.code, super.stackTrace]);
}
