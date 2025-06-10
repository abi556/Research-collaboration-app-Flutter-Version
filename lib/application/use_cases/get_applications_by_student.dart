import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';

class GetApplicationsByStudent {
  final ApplicationRepository repository;
  GetApplicationsByStudent(this.repository);
  Future<List<Application>> call(int studentId) {
    return repository.getApplicationsByStudent(studentId);
  }
} 