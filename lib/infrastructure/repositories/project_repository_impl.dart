import 'package:dio/dio.dart';
import '../../core/utils/api_client.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../dto/project_dto.dart';
import '../../core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Dio _dio = ApiClient.dio;

  @override
  Future<List<Project>> getAllProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      print('getAllProjects: token = $token');
      final response = await _dio.get(
        '/projects',
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      print('getAllProjects: response = \\${response.data}');
      final List data = response.data as List;
      return data.map((json) => ProjectDto.fromJson(json).toDomain()).toList();
    } on DioException catch (e) {
      print('getAllProjects DioException: \\${e.response?.data}');
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
      print('Creating project payload: \\${dto.toJson()}');
      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final response = await _dio.post(
        '/projects',
        data: dto.toJson(),
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      print('Create project response: \\${response.data}');
      return ProjectDto.fromJson(response.data).toDomain();
    } on DioException catch (e) {
      print('Create project DioException: \\${e.response?.data}');
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