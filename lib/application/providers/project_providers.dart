import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/project.dart';
import '../../infrastructure/repositories/project_repository_impl.dart';
import '../use_cases/get_all_projects.dart';
import '../use_cases/get_project_by_id.dart';
import '../use_cases/create_project.dart';
import '../use_cases/update_project.dart';
import '../use_cases/delete_project.dart';

final projectRepositoryProvider = Provider<ProjectRepositoryImpl>((ref) {
  return ProjectRepositoryImpl();
});

final getAllProjectsProvider = Provider<GetAllProjects>((ref) {
  return GetAllProjects(ref.watch(projectRepositoryProvider));
});

final getProjectByIdProvider = Provider<GetProjectById>((ref) {
  return GetProjectById(ref.watch(projectRepositoryProvider));
});

final createProjectProvider = Provider<CreateProject>((ref) {
  return CreateProject(ref.watch(projectRepositoryProvider));
});

final updateProjectProvider = Provider<UpdateProject>((ref) {
  return UpdateProject(ref.watch(projectRepositoryProvider));
});

final deleteProjectProvider = Provider<DeleteProject>((ref) {
  return DeleteProject(ref.watch(projectRepositoryProvider));
});

final allProjectsStateProvider = FutureProvider<List<Project>>((ref) async {
  final getAllProjects = ref.watch(getAllProjectsProvider);
  return await getAllProjects();
}); 