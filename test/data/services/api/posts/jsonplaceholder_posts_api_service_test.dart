import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_lisa_it/core/constants/api_consts.dart';
import 'package:teste_lisa_it/data/services/api/api_client.dart';
import 'package:teste_lisa_it/data/services/api/models/posts/jsonplaceholder_post_model.dart';
import 'package:teste_lisa_it/data/services/api/posts/jsonplaceholder_posts_api_service.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockApiClient;
  late JsonPlaceholderPostsApiService service;

  setUp(() {
    mockApiClient = MockApiClient();
    service = JsonPlaceholderPostsApiService(apiClient: mockApiClient);
  });

  group("JsonPlaceholderPostsApiService", () {
    // fetchPosts method tests
    group("fetchPosts", () {
      test("should return a list of posts when the API call is successful",
          () async {
        // Define the limit for pagination
        const limit = 2;
        // Define the page for pagination
        const page = 1;

        // Construct the endpoint URL
        final String endpoint = "posts?_page=$page&_limit=$limit";

        // Mock response data
        final mockResponse = [
          {
            "userId": 1,
            "id": 1,
            "title": "post 1",
            "body": "content 1",
          },
          {
            "userId": 2,
            "id": 2,
            "title": "post 2",
            "body": "content 2",
          },
        ];

        // Mock the API client response
        when(() => mockApiClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        // Call the fetchPosts method
        final result = await service.fetchPosts(limit: limit, page: page);

        // Validate the result
        expect(result, isA<List<JsonPlaceholderPostModel>>());
        expect(result.length, limit);

        // Validate the first post item
        final post1 = result[0];
        expect(post1.userId, 1);
        expect(post1.id, 1);
        expect(post1.title, "post 1");
        expect(post1.body, "content 1");

        // Validate the second post item
        final post2 = result[1];
        expect(post2.userId, 2);
        expect(post2.id, 2);
        expect(post2.title, "post 2");
        expect(post2.body, "content 2");

        // Verify that the API client was called with the correct endpoint
        verify(() => mockApiClient.get("$jsonPlaceHolderBaseUrl/$endpoint"))
            .called(1);
      });
    });
  });
}
