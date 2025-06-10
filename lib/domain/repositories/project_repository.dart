import '../entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAllProjects();
  Future<Project> getProjectById(int id);
  Future<Project> createProject(Project project);
  Future<Project> updateProject(Project project);
  Future<void> deleteProject(int id);
} 