import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  const FirebaseAuthService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

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
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("login failed, error: $e");
    }
  }
}
