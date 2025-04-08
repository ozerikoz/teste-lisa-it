import 'package:teste_lisa_it/data/repositories/posts/posts_repository.dart';
import 'package:teste_lisa_it/data/services/api/posts/jsonplaceholder_posts_api_service.dart';
import 'package:teste_lisa_it/domain/entities/post/post_entity.dart';

class JsonplaceholderPostsRepository extends PostsRepository {
  final JsonPlaceholderPostsApiService _postsApiService;

  JsonplaceholderPostsRepository({
    required JsonPlaceholderPostsApiService postsApiService,
  }) : _postsApiService = postsApiService;

  @override
  Future<List<Post>> fetchPosts({
    required int limit,
    required int page,
  }) async {
    try {
      final posts =
          _postsApiService.fetchPosts(limit: limit, page: page).then((posts) {
        return posts.map((post) {
          return Post(
            userId: post.userId,
            title: post.title,
            body: post.body,
          );
        }).toList();
      });

      return posts;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }
}
