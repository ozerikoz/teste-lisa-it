import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';
import 'package:teste_lisa_it/data/services/auth/firebase_auth_service.dart';
import 'package:teste_lisa_it/domain/entities/user/user_entity.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  FirebaseAuthRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  User? _user;

  @override
  Future<User?> isAuthenticated() async {
    // Return cached value if already determined
    if (_user != null) {
      return _user!;
    }

    _user = _getCurrentUser();

    return _user;
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuthService.login(
        email: email,
        password: password,
      );

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
    try {
      return _firebaseAuthService.logout();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  User? _getCurrentUser() {
    final user = _firebaseAuthService.getCurrentUser();

    if (user == null) {
      return null;
    }

    return User(
      userUid: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      profileImageUrl: user.photoURL ?? "",
    );
  }
}
