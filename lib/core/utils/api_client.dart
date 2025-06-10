import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000', // Change to your backend URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
} 