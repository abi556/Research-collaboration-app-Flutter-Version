import '../../domain/repositories/application_repository.dart';

class RemoveApplication {
  final ApplicationRepository repository;
  RemoveApplication(this.repository);
  Future<void> call(int applicationId) {
    return repository.removeApplication(applicationId);
  }
} 