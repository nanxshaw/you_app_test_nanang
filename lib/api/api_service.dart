import 'package:dio/dio.dart';

class ApiService {
  late Dio dio;
  final String baseUrl = "https://techtest.youapp.ai/api";

  ApiService() {
    dio = Dio();
  }

  Future<Response> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.request(
        '$baseUrl/$path',
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to perform $method request: $e');
    }
  }
}
