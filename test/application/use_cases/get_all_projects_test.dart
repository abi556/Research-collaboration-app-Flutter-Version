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

    test('should return all projects successfully', () async {
      // Arrange
      when(mockRepository.getAllProjects()).thenAnswer((_) async => projects);

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(projects));
      expect(result.length, equals(2));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should return empty list when no projects exist', () async {
      // Arrange
      when(mockRepository.getAllProjects()).thenAnswer((_) async => const []);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isEmpty);
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.getAllProjects())
          .thenThrow(Exception('Failed to fetch projects'));

      // Act & Assert
      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should handle network timeout gracefully', () async {
      // Arrange
      when(mockRepository.getAllProjects())
          .thenThrow(Exception('Network timeout'));

      // Act & Assert
      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should handle database connection error', () async {
      // Arrange
      when(mockRepository.getAllProjects())
          .thenThrow(Exception('Database connection error'));

      // Act & Assert
      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should return projects in correct order', () async {
      // Arrange
      final sortedProjects = List<Project>.from(projects)
        ..sort((a, b) => a.id.compareTo(b.id));
      when(mockRepository.getAllProjects())
          .thenAnswer((_) async => sortedProjects);

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(sortedProjects));
      expect(result[0].id, lessThan(result[1].id));
      verify(mockRepository.getAllProjects()).called(1);
    });

    test('should handle empty values in project data', () async {
      // Arrange
      const projectsWithEmpty = [
        Project(
          id: 1,
          title: 'Project 1',
          description: '',
          requirements: [],
          startDate: '2024-01-01',
          endDate: '',
          deadline: '2023-12-01',
        ),
      ];
      when(mockRepository.getAllProjects())
          .thenAnswer((_) async => projectsWithEmpty);

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(projectsWithEmpty));
      expect(result[0].description, isEmpty);
      expect(result[0].endDate, isEmpty);
      verify(mockRepository.getAllProjects()).called(1);
    });
  });
} 