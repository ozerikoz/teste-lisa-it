import "package:firebase_auth/firebase_auth.dart";
import "package:teste_lisa_it/data/exceptions/auth_exceptions.dart";
import "package:teste_lisa_it/core/exceptions/exceptions.dart";

/// This class provides authentication services using Firebase Authentication.
class FirebaseAuthService {
  /// The [FirebaseAuth] instance used for authentication.
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Perform [FirebaseAuth] login with email and password.
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential user =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
        case "wrong-password":
        case "user-not-found":
        case "invalid-credential":
          throw InvalidCredentialsException(e.code);
        case 'network-request-failed':
          throw NetworkException();
        default:
          throw AuthException("Authentication error: ${e.message}");
      }
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
    }
  }

  /// Perform [FirebaseAuth] sign out
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          throw NetworkException();
        default:
          throw AuthException('Logout error: ${e.message}');
      }
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
    }
  }

  /// Get the current user from [FirebaseAuth]
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
