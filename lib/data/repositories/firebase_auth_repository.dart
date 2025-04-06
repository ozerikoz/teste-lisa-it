import 'package:teste_lisa_it/data/repositories/auth_repository.dart';
import 'package:teste_lisa_it/data/services/firebase_auth_service.dart';
import 'package:teste_lisa_it/domain/entities/user_entity.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  FirebaseAuthRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  bool? _isLoggedIn;

  @override
  Future<bool> isLoggedIn() async {
    // Return cached value if already determined
    if (_isLoggedIn != null) {
      return _isLoggedIn!;
    }

    // Check if the user is logged in via the service
    _isLoggedIn = _firebaseAuthService.getCurrentUser() != null;

    return _isLoggedIn ?? false;
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

  User? getCurrentUser() {
    final user = _firebaseAuthService.getCurrentUser();

    if (user == null) {
      _isLoggedIn = false;
      return null;
    }

    _isLoggedIn = true;

    return User(
      userUid: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      profileImageUrl: user.photoURL ?? "",
    );
  }
}
