/// Api client interface
/// This interface defines the methods for making HTTP requests.
abstract class ApiClient {
  Future<dynamic> get(
    String apiUrl, {
    Map<String, dynamic>? params,
  });

  Future<dynamic> post(
    String apiUrl, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> put(
    String apiUrl, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> delete(
    String apiUrl, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> patch(
    String apiUrl, {
    Map<String, dynamic>? data,
  });
}
