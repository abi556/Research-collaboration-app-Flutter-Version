import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';

class UpdateApplicationStatus {
  final ApplicationRepository repository;
  UpdateApplicationStatus(this.repository);
  Future<Application> call(int applicationId, ApplicationStatus status) {
    return repository.updateApplicationStatus(applicationId, status);
  }
} 