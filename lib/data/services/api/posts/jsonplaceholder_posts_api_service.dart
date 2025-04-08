import 'package:teste_lisa_it/consts.dart';
import 'package:teste_lisa_it/data/services/api/api_client.dart';
import 'package:teste_lisa_it/data/services/api/models/posts/jsonplaceholder_post_model.dart';

class JsonPlaceholderPostsApiService {
  final ApiClient _apiClient;

  JsonPlaceholderPostsApiService({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  Future<List<JsonPlaceholderPostModel>> fetchPosts({
    required int limit,
    required int page,
  }) async {
    try {
      final response = await _apiClient.get(
        '$jsonPlaceHolderBaseUrl/posts?page=_$page&_limit=$limit',
      );

      final List<JsonPlaceholderPostModel> posts;

      posts = response
          .map((post) => JsonPlaceholderPostModel.fromJson(post))
          .toList()
          .cast<JsonPlaceholderPostModel>();

      return posts;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }
}
