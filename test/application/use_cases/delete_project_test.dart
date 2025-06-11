import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:research_collaboration_app/application/use_cases/delete_project.dart';
import 'package:research_collaboration_app/domain/repositories/project_repository.dart';

@GenerateMocks([ProjectRepository])
import 'delete_project_test.mocks.dart';

void main() {
  late DeleteProject useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = DeleteProject(mockRepository);
  });

  group('DeleteProject Use Case Tests', () {
    test('should delete a project successfully', () async {
      when(mockRepository.deleteProject(1)).thenAnswer((_) async {});

      await useCase(1);

      verify(mockRepository.deleteProject(1)).called(1);
    });

    test('should throw exception when repository fails', () async {
      when(mockRepository.deleteProject(1)).thenThrow(Exception('Failed to delete project'));

      expect(() => useCase(1), throwsA(isA<Exception>()));
      verify(mockRepository.deleteProject(1)).called(1);
    });
  });
} 