import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:research_collaboration_app/application/use_cases/create_project.dart';
import 'package:research_collaboration_app/domain/entities/project.dart';
import 'package:research_collaboration_app/domain/repositories/project_repository.dart';

@GenerateMocks([ProjectRepository])
import 'create_project_test.mocks.dart';

void main() {
  late CreateProject useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = CreateProject(mockRepository);
  });

  group('CreateProject Use Case Tests', () {
    const testProject = Project(
      id: 1,
      title: 'Test Project',
      description: 'Test Description',
      requirements: ['Requirement 1', 'Requirement 2'],
      startDate: '2024-03-01',
      endDate: '2024-08-31',
      deadline: '2024-02-15',
    );

    test('should create a project successfully', () async {
      // Arrange
      when(mockRepository.createProject(testProject))
          .thenAnswer((_) async => testProject);

      // Act
      final result = await useCase(testProject);

      // Assert
      expect(result, equals(testProject));
      verify(mockRepository.createProject(testProject)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.createProject(testProject))
          .thenThrow(Exception('Failed to create project'));

      // Act & Assert
      expect(
        () => useCase(testProject),
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.createProject(testProject)).called(1);
    });

    test('should validate project data before creation', () async {
      // TODO: Implement validation in the Project class
      // This test is skipped because validation is not yet implemented
      // When implementing validation, this test should verify that creating a Project
      // with an empty title throws an AssertionError
    }, skip: 'Validation is not implemented in the Project class');
  });
} 