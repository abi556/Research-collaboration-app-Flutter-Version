import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class GetProjectById {
  final ProjectRepository repository;
  GetProjectById(this.repository);
  Future<Project> call(int id) {
    return repository.getProjectById(id);
  }
} 