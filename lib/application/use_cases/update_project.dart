import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class UpdateProject {
  final ProjectRepository repository;
  UpdateProject(this.repository);
  Future<Project> call(Project project) {
    return repository.updateProject(project);
  }
} 