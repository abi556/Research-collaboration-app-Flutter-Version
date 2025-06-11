import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/domain/entities/project.dart';
import 'package:research_collaboration_app/domain/entities/application.dart';
import 'package:research_collaboration_app/domain/repositories/project_repository.dart';
import 'package:research_collaboration_app/domain/repositories/application_repository.dart';
import 'package:research_collaboration_app/infrastructure/repositories/project_repository_impl.dart';
import 'package:research_collaboration_app/infrastructure/repositories/application_repository_impl.dart';

// Provider for ProjectRepository
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl();
});

// Provider for ApplicationRepository
final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  return ApplicationRepositoryImpl();
});

/// Provider to fetch all projects owned by the current professor
final professorProjectsProvider = FutureProvider<List<Project>>((ref) async {
  final authState = ref.watch(authProvider);
  final user = authState.maybeWhen(authenticated: (u) => u, orElse: () => null);
  print('Authenticated professor id: \\${user?.id}');
  if (user == null) return [];
  final repo = ref.read(projectRepositoryProvider);
  final allProjects = await repo.getAllProjects();
  print('All projects: \\${allProjects.map((p) => 'id: \\${p.id}, title: \\${p.title}, professorId: \\${p.professorId}').toList()}');
  final filtered = allProjects.where((p) {
    print('Comparing project.professorId (\\${p.professorId.runtimeType}): \\${p.professorId} with user.id (\\${user.id.runtimeType}): \\${user.id}');
    return p.professorId.toString() == user.id.toString();
  }).toList();
  print('Filtered projects for professor: \\${filtered.map((p) => 'id: \\${p.id}, title: \\${p.title}').toList()}');
  return filtered;
});

/// Provider to fetch all applications for the professor's projects
final professorApplicationsProvider = FutureProvider<List<Application>>((ref) async {
  print('professorApplicationsProvider called');
  final projects = await ref.watch(professorProjectsProvider.future);
  final repo = ref.read(applicationRepositoryProvider);
  List<Application> allApplications = [];
  for (final project in projects) {
    final apps = await repo.getApplicationsByProject(project.id!);
    print('Applications for project \\${project.id}: \\${apps}');
    allApplications.addAll(apps);
  }
  print('All applications for professor: \\${allApplications}');
  return allApplications;
});

/// Provider to aggregate dashboard stats
final professorDashboardStatsProvider = FutureProvider<({
  int activeProjects,
  int pendingApplications,
  int acceptedStudents,
})>((ref) async {
  print('professorDashboardStatsProvider called');
  final projects = await ref.watch(professorProjectsProvider.future);
  final applications = await ref.watch(professorApplicationsProvider.future);
  print('Stats - projects: \\${projects}');
  print('Stats - applications: \\${applications}');
  print('Application statuses: \\${applications.map((a) => a.status).toList()}');
  final pending = applications.where((a) => a.status == ApplicationStatus.PENDING).length;
  final accepted = applications.where((a) => a.status == ApplicationStatus.APPROVED).length;
  print('Stats - pending: \\${pending}, accepted: \\${accepted}');
  return (
    activeProjects: projects.length,
    pendingApplications: pending,
    acceptedStudents: accepted,
  );
}); 