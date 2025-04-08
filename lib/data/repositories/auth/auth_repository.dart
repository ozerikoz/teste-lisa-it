import 'package:teste_lisa_it/domain/entities/user/user_entity.dart';

abstract class AuthRepository {
  /// Performs user login with the given [email] and [password].
  Future<User> login({
    required String email,
    required String password,
  });

  /// Logs out the current user.
  Future<void> logout();

  /// Checks if the user is logged in.
  Future<bool> isLoggedIn();
}
