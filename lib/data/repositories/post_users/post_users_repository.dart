import 'package:teste_lisa_it/domain/entities/post_user/post_user_entity.dart';

abstract class PostUsersRepository {
  /// Fetch [PostUser] by [userId].
  Future<PostUser?> getUserById({required int userId});
}
