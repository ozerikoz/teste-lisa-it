abstract class ApiClient {
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? params,
  });

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
