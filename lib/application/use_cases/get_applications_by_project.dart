import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';

class GetApplicationsByProject {
  final ApplicationRepository repository;
  GetApplicationsByProject(this.repository);
  Future<List<Application>> call(int projectId) {
    return repository.getApplicationsByProject(projectId);
  }
} 