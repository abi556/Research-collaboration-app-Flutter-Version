import 'package:dio/dio.dart';
import '../../core/utils/api_client.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../dto/project_dto.dart';
import '../../core/error/failures.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Dio _dio = ApiClient.dio;

  @override
  Future<List<Project>> getAllProjects() async {
    try {
      final response = await _dio.get('/projects');
      final List data = response.data as List;
      return data.map((json) => ProjectDto.fromJson(json).toDomain()).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<Project> getProjectById(int id) async {
    try {
      final response = await _dio.get('/projects/$id');
      return ProjectDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  // Implement other methods (create, update, delete) as needed
  @override
  Future<Project> createProject(Project project) async {
    try {
      final dto = ProjectDtoX.fromDomain(project);
      final response = await _dio.post('/projects', data: dto.toJson());
      return ProjectDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<Project> updateProject(Project project) async {
    try {
      final dto = ProjectDtoX.fromDomain(project);
      final response = await _dio.put('/projects/${project.id}', data: dto.toJson());
      return ProjectDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }

  @override
  Future<void> deleteProject(int id) async {
    try {
      await _dio.delete('/projects/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error');
    }
  }
} 