import '../entities/application.dart';

abstract class ApplicationRepository {
  Future<List<Application>> getApplicationsByProject(int projectId);
  Future<List<Application>> getApplicationsByStudent(int studentId);
  Future<Application> applyForProject(int projectId, int studentId);
  Future<Application> updateApplicationStatus(int applicationId, ApplicationStatus status);
  Future<void> removeApplication(int applicationId);
} 