import 'package:teste_lisa_it/core/constants/api_consts.dart';
import 'package:teste_lisa_it/core/exceptions/exceptions.dart';
import 'package:teste_lisa_it/data/services/api/api_client.dart';
import 'package:teste_lisa_it/data/services/api/models/posts/jsonplaceholder_post_model.dart';

/// A service for fetching posts from the JSONPlaceholder API.
class JsonPlaceholderPostsApiService {
  /// The [ApiClient] instance used for making HTTP requests.
  final ApiClient _apiClient;

  JsonPlaceholderPostsApiService({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  /// Fetches a list of posts from the JSONPlaceholder API.
  ///
  /// - [limit] specifies the maximum number of posts to fetch.
  /// - [page] specifies the page number to fetch.
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

      // Check if the response is a list of maps
      if (response is! List<dynamic>) {
        throw FormatException(
          "Invalid JSONPlaceholder posts response format: ${response.runtimeType}",
        );
      }

      try {
        posts = response
            .map<JsonPlaceholderPostModel>(
                (post) => JsonPlaceholderPostModel.fromJson(post))
            .toList();
      } catch (e) {
        throw ParseException("Failed to parse JSONPlaceholder posts: $e");
      }

      return posts;
    } on AppException {
      rethrow;
    } catch (e, s) {
      throw UnknownException(
        "Unexpected exception while fetching JSONPlaceholder posts: $e",
        s,
      );
    }
  }
}
