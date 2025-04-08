import 'package:teste_lisa_it/domain/entities/post/post_entity.dart';

abstract class PostsRepository {
  /// Fetches a list of [Post]
  Future<List<Post>> fetchPosts({
    required int limit,
    required int page,
  });
}
