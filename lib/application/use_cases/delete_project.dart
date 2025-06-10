import '../../domain/repositories/project_repository.dart';

class DeleteProject {
  final ProjectRepository repository;
  DeleteProject(this.repository);
  Future<void> call(int id) {
    return repository.deleteProject(id);
  }
} 