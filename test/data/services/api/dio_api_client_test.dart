import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_lisa_it/data/services/api/dio_api_client.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late DioApiClient dioApiClient;
  late MockDio mockDio;
  late MockResponse mockResponse;

  // Test data
  const String testApiUrl = 'https://api.example.com';

  final Map<String, dynamic> testParams = {
    'param1': 'testValue1',
    'param2': 'testValue2'
  };
  final Map<String, dynamic> testData = {
    'field1': 'testValue1',
    'field2': 'testValue2'
  };
  final Map<String, dynamic> testResponseData = {
    'id': 1,
    'name': 'Test response',
  };

  setUp(() {
    mockDio = MockDio();
    mockResponse = MockResponse();

    // Set up common mock response behavior
    when(() => mockResponse.data).thenReturn(testResponseData);

    // Inject the mock Dio instance into the DioApiClient
    dioApiClient = DioApiClient(dio: mockDio);
  });

  group('DioApiClient', () {
    // Test GET method
    test('get should make correct GET request and return response data',
        () async {
      when(() => mockDio.get(
            testApiUrl,
            queryParameters: testParams,
          )).thenAnswer((_) async => mockResponse);

      final result = await dioApiClient.get(
        testApiUrl,
        params: testParams,
      );

      expect(result, equals(testResponseData));

      verify(() => mockDio.get(
            testApiUrl,
            queryParameters: testParams,
          )).called(1);
    });

    // Test POST method
    test('post should make correct POST request and return response data',
        () async {
      when(() => mockDio.post(
            testApiUrl,
            data: testData,
          )).thenAnswer((_) async => mockResponse);

      final result = await dioApiClient.post(
        testApiUrl,
        data: testData,
      );

      expect(result, equals(testResponseData));

      verify(() => mockDio.post(
            testApiUrl,
            data: testData,
          )).called(1);
    });

    // Test PUT method
    test('put should make correct PUT request and return response data',
        () async {
      when(() => mockDio.put(
            testApiUrl,
            data: testData,
          )).thenAnswer((_) async => mockResponse);

      final result = await dioApiClient.put(
        testApiUrl,
        data: testData,
      );

      expect(result, equals(testResponseData));

      verify(() => mockDio.put(
            testApiUrl,
            data: testData,
          )).called(1);
    });

    // Test DELETE method
    test('delete should make correct DELETE request and return response data',
        () async {
      when(() => mockDio.delete(
            testApiUrl,
            data: testData,
          )).thenAnswer((_) async => mockResponse);

      final result = await dioApiClient.delete(
        testApiUrl,
        data: testData,
      );

      expect(result, equals(testResponseData));
      verify(() => mockDio.delete(
            testApiUrl,
            data: testData,
          )).called(1);
    });

    // Test PATCH method
    test('patch should make correct PATCH request and return response data',
        () async {
      when(() => mockDio.patch(
            testApiUrl,
            data: testData,
          )).thenAnswer((_) async => mockResponse);

      final result = await dioApiClient.patch(
        testApiUrl,
        data: testData,
      );

      expect(result, equals(testResponseData));
      verify(() => mockDio.patch(
            testApiUrl,
            data: testData,
          )).called(1);
    });
  });
}
