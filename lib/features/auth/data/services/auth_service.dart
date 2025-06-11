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

  // Manual JWT decode function
  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded);
  }

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
        final accessToken = data['access_token'];
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', data['refresh_token']);

        // Decode JWT to get user info
        Map<String, dynamic> decoded = decodeJwt(accessToken);
        print('Decoded JWT in login: $decoded');
        return User(
          id: decoded['sub'].toString(),
          email: decoded['email'],
          name: decoded['name'],
          role: decoded['role'],
          profilePicture: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
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
        final accessToken = data['access_token'];
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', data['refresh_token']);

        // Decode JWT to get user info
        Map<String, dynamic> decoded = decodeJwt(accessToken);
        print('Decoded JWT in signup: $decoded');
        return User(
          id: decoded['sub'].toString(),
          email: decoded['email'],
          name: decoded['name'],
          role: decoded['role'],
          profilePicture: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
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
    final accessToken = prefs.getString('access_token');
    if (accessToken == null) return null;
    try {
      Map<String, dynamic> decoded = decodeJwt(accessToken);
      print('Decoded JWT in getCurrentUser: $decoded');
      return User(
        id: decoded['sub'].toString(),
        email: decoded['email'],
        name: decoded['name'],
        role: decoded['role'],
        profilePicture: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
} 