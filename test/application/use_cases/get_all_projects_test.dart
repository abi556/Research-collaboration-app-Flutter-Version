import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:research_collaboration_app/application/use_cases/get_all_projects.dart';
import 'package:research_collaboration_app/domain/entities/project.dart';
import 'package:research_collaboration_app/domain/repositories/project_repository.dart';

@GenerateMocks([ProjectRepository])
import 'get_all_projects_test.mocks.dart';

void main() {
  late GetAllProjects useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = GetAllProjects(mockRepository);
  });

  group('GetAllProjects Use Case Tests', () {
    const projects = [
      Project(
        id: 1,
        title: 'Project 1',
        description: 'Description 1',
        requirements: ['Req1'],
        startDate: '2024-01-01',
        endDate: '2024-06-01',
        deadline: '2023-12-01',
      ),
      Project(
        id: 2,
        title: 'Project 2',
        description: 'Description 2',
        requirements: ['Req2'],
        startDate: '2024-02-01',
        endDate: '2024-07-01',
        deadline: '2024-01-01',
      ),
    ];

    test('should return all projects', () async {
      when(mockRepository.getAllProjects()).thenAnswer((_) async => projects);

      final result = await useCase();

      expect(result, equals(projects));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should throw exception when repository fails', () async {
      when(mockRepository.getAllProjects()).thenThrow(Exception('Failed'));

      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getAllProjects()).called(1);
    });
  });
} 