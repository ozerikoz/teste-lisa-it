import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import "package:teste_lisa_it/data/services/api/api_client.dart";
import "package:teste_lisa_it/data/exceptions/api_exceptions.dart";
import "package:teste_lisa_it/core/exceptions/exceptions.dart";

/// A client for making HTTP requests using [Dio].
///
/// Provides methods for [get], [post], [put], [delete], and [patch] requests,
/// with custom exception handling for API errors.
class DioApiClient extends ApiClient {
  /// The [Dio] instance used for making HTTP requests.
  late Dio _dio;

  DioApiClient({Dio? dio}) {
    _dio = dio ?? _createDio();
  }

  /// Creates a new [Dio] instance with default options.
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
    } on DioException catch (e, s) {
      throw _mapDioException(e, s);
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
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
    } on DioException catch (e, s) {
      throw _mapDioException(e, s);
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
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
    } on DioException catch (e, s) {
      throw _mapDioException(e, s);
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
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
    } on DioException catch (e, s) {
      throw _mapDioException(e, s);
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
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
    } on DioException catch (e, s) {
      throw _mapDioException(e, s);
    } catch (e, s) {
      throw UnknownException("Unexpected exception: $e", s);
    }
  }

  /// Maps [DioException] to [AppException] based on the type of error.
  AppException _mapDioException(DioException e, StackTrace? s) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return NetworkException();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RequestTimeoutException();

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return BadRequestException();
          case 401:
            return UnauthorizedException();
          case 403:
            return ForbiddenException();
          case 404:
            return NotFoundException();
          case 500:
            return ServerErrorException();
          default:
            return UnknownException("Unexpected exception: $e", s);
        }

      case DioExceptionType.cancel:
        return RequestCancelledException();

      case DioExceptionType.unknown:
      default:
        return UnknownException("Unexpected exception: $e", s);
    }
  }
}
