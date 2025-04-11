import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_lisa_it/data/services/api/api_client.dart';

class DioApiClient extends ApiClient {
  late Dio _dio;

  DioApiClient({Dio? dio}) {
    _dio = dio ?? _createDio();
  }

  Dio _createDio() {
    Dio dio = Dio(BaseOptions(
      responseType: ResponseType.json,
      contentType: "application/json",
    ));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }

  @override
  Future<dynamic> get(
    String apiUrl, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(
        apiUrl,
        queryParameters: params,
      );

      return response.data;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String apiUrl, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: data,
      );

      return response.data;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String apiUrl, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(
        apiUrl,
        data: data,
      );

      return response.data;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String apiUrl, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        apiUrl,
        data: data,
      );

      return response.data;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }

  @override
  Future<dynamic> patch(
    String apiUrl, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.patch(
        apiUrl,
        data: data,
      );

      return response.data;
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }
}
