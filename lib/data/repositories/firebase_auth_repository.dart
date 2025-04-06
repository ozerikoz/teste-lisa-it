import 'package:teste_lisa_it/data/repositories/auth_repository.dart';
import 'package:teste_lisa_it/data/services/firebase_auth_service.dart';
import 'package:teste_lisa_it/domain/entities/user_entity.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  FirebaseAuthRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  @override
  Future<bool> isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final userCredential =
          await _firebaseAuthService.login(email: email, password: password);

      final user = User(
        userUid: userCredential.user?.uid ?? "",
        name: userCredential.user?.displayName ?? "",
        email: email,
        profileImageUrl: userCredential.user?.photoURL ?? "",
      );

      return user;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
