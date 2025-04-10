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
        const limit = 2;
        const page = 0;
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

        when(() => mockApiClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        final result = await service.fetchPosts(limit: limit, page: page);

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

        verify(() => mockApiClient
                .get("$jsonPlaceHolderBaseUrl/posts?page=_$page&_limit=$limit"))
            .called(1);
      });
    });
  });
}
