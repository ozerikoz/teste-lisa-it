import 'package:teste_lisa_it/core/constants/api_consts.dart';
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
    final String endpoint = "posts?_page=$page&_limit=$limit";

    try {
      final response = await _apiClient.get(
        '$jsonPlaceHolderBaseUrl/$endpoint',
      );

      final List<JsonPlaceholderPostModel> posts;

      posts = response
          .map<JsonPlaceholderPostModel>(
              (post) => JsonPlaceholderPostModel.fromJson(post))
          .toList();

      return posts;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }
}
