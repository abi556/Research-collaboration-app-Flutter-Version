import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../../../core/error/exceptions.dart';

class AuthService {
  final Dio dio;
  final SharedPreferences prefs;

  AuthService({
    required this.dio,
    required this.prefs,
  });

  Future<User> login(String email, String password, [String? name]) async {
    try {
      final response = await dio.post(
        '/auth/signin',
        data: {
          'email': email,
          'password': password,
          if (name != null) 'name': name,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Store tokens
        await prefs.setString('access_token', data['access_token']);
        await prefs.setString('refresh_token', data['refresh_token']);
        
        // Get user data
        final userResponse = await dio.get(
          '/auth/me',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${data['access_token']}',
            },
          ),
        );

        if (userResponse.statusCode == 200) {
          return User.fromJson(userResponse.data);
        } else {
          throw ServerException(message: userResponse.data['message']);
        }
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<User> signup(String email, String password, String role, String name) async {
    try {
      final response = await dio.post(
        '/auth/signup',
        data: {
          'email': email,
          'password': password,
          'role': role,
          'name': name,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        // Store tokens
        await prefs.setString('access_token', data['access_token']);
        await prefs.setString('refresh_token', data['refresh_token']);
        
        // Get user data
        final userResponse = await dio.get(
          '/auth/me',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${data['access_token']}',
            },
          ),
        );

        if (userResponse.statusCode == 200) {
          return User.fromJson(userResponse.data);
        } else {
          throw ServerException(message: userResponse.data['message']);
        }
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) return;

      final response = await dio.post(
        '/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        await prefs.remove('access_token');
        await prefs.remove('refresh_token');
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );

      if (response.statusCode != 200) {
        throw ServerException(message: response.data['message']);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) return null;

      final response = await dio.get(
        '/auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 401) {
        // Try to refresh token
        final refreshToken = prefs.getString('refresh_token');
        if (refreshToken == null) return null;

        final refreshResponse = await dio.post(
          '/auth/refresh',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
            },
          ),
        );

        if (refreshResponse.statusCode == 200) {
          final data = refreshResponse.data;
          await prefs.setString('access_token', data['access_token']);
          await prefs.setString('refresh_token', data['refresh_token']);

          // Retry getting user data with new token
          final userResponse = await dio.get(
            '/auth/me',
            options: Options(
              headers: {
                'Authorization': 'Bearer ${data['access_token']}',
              },
            ),
          );

          if (userResponse.statusCode == 200) {
            return User.fromJson(userResponse.data);
          }
        }
        return null;
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return null;
      }
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
} 