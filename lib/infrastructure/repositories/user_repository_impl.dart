import 'package:dio/dio.dart';
import '../../core/utils/api_client.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../dto/user_dto.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio = ApiClient.dio;

  @override
  Future<User> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return UserDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final response = await _dio.get('/users');
      final List data = response.data as List;
      return data.map((json) => UserDto.fromJson(json).toDomain()).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      final dto = UserDtoX.fromDomain(user);
      final response = await _dio.put('/users/${user.id}', data: dto.toJson());
      return UserDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await _dio.delete('/users/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }
} 