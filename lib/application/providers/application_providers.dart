import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/application.dart';
import '../../infrastructure/repositories/application_repository_impl.dart';
import '../use_cases/get_applications_by_project.dart';
import '../use_cases/get_applications_by_student.dart';
import '../use_cases/apply_for_project.dart';
import '../use_cases/update_application_status.dart';
import '../use_cases/remove_application.dart';

final applicationRepositoryProvider = Provider<ApplicationRepositoryImpl>((ref) {
  return ApplicationRepositoryImpl();
});

final getApplicationsByProjectProvider = Provider<GetApplicationsByProject>((ref) {
  return GetApplicationsByProject(ref.watch(applicationRepositoryProvider));
});

final getApplicationsByStudentProvider = Provider<GetApplicationsByStudent>((ref) {
  return GetApplicationsByStudent(ref.watch(applicationRepositoryProvider));
});

final applyForProjectProvider = Provider<ApplyForProject>((ref) {
  return ApplyForProject(ref.watch(applicationRepositoryProvider));
});

final updateApplicationStatusProvider = Provider<UpdateApplicationStatus>((ref) {
  return UpdateApplicationStatus(ref.watch(applicationRepositoryProvider));
});

final removeApplicationProvider = Provider<RemoveApplication>((ref) {
  return RemoveApplication(ref.watch(applicationRepositoryProvider));
});

final applicationsByProjectStateProvider = FutureProvider.family<List<Application>, int>((ref, projectId) async {
  final getApplicationsByProject = ref.watch(getApplicationsByProjectProvider);
  return await getApplicationsByProject(projectId);
});

final applicationsByStudentStateProvider = FutureProvider.family<List<Application>, int>((ref, studentId) async {
  final getApplicationsByStudent = ref.watch(getApplicationsByStudentProvider);
  return await getApplicationsByStudent(studentId);
}); 