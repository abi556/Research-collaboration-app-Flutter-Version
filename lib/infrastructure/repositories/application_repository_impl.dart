import 'package:dio/dio.dart';
import '../../core/utils/api_client.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';
import '../dto/application_dto.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final Dio _dio = ApiClient.dio;

  @override
  Future<List<Application>> getApplicationsByProject(int projectId) async {
    try {
      final response = await _dio.get('/applications/project/$projectId');
      final List data = response.data as List;
      return data.map((json) => ApplicationDto.fromJson(json).toDomain()).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<List<Application>> getApplicationsByStudent(int studentId) async {
    try {
      final response = await _dio.get('/applications/student/$studentId');
      final List data = response.data as List;
      return data.map((json) => ApplicationDto.fromJson(json).toDomain()).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<Application> applyForProject(int projectId, int studentId) async {
    try {
      final response = await _dio.post('/applications', data: {
        'projectId': projectId,
        'studentId': studentId,
      });
      return ApplicationDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<Application> updateApplicationStatus(int applicationId, ApplicationStatus status) async {
    try {
      final response = await _dio.patch('/applications/$applicationId', data: {
        'status': status.name,
      });
      return ApplicationDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<void> removeApplication(int applicationId) async {
    try {
      await _dio.delete('/applications/$applicationId');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }
} 