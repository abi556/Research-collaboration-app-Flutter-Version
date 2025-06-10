import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class CreateProject {
  final ProjectRepository repository;
  CreateProject(this.repository);
  Future<Project> call(Project project) {
    return repository.createProject(project);
  }
} 