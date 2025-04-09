import 'package:teste_lisa_it/data/repositories/post_users/post_users_repository.dart';
import 'package:teste_lisa_it/data/services/db/firestore_service.dart';
import 'package:teste_lisa_it/domain/entities/post_user/post_user_entity.dart';

final String _userCollection = 'users';

class FirestorePostUsersRepository extends PostUsersRepository {
  final FirestoreService _firestoreService;

  FirestorePostUsersRepository({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  @override
  Future<PostUser?> getUserById({required int userId}) async {
    final String field = "userId";

    try {
      final user = await _firestoreService.getFilteredCollection(
        collection: _userCollection,
        field: field,
        value: userId,
      );

      if (user.docs.isEmpty) return null;

      final userData = user.docs.first.data() as Map<String, dynamic>;

      return PostUser.fromJson(userData);
    } catch (e) {
      rethrow;
    }
  }
}
