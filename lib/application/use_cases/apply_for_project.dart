import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';

class ApplyForProject {
  final ApplicationRepository repository;
  ApplyForProject(this.repository);
  Future<Application> call(int projectId, int studentId) {
    return repository.applyForProject(projectId, studentId);
  }
} 