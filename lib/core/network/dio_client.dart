import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('[DioClient] Request: ${options.method} ${options.path}');
        print('[DioClient] Headers: ${options.headers}');
        print('[DioClient] Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('[DioClient] Response: ${response.statusCode} ${response.requestOptions.path}');
        print('[DioClient] Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('[DioClient] Error: ${e.type} ${e.requestOptions.path}');
        print('[DioClient] Error Response: ${e.response?.data}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
} 