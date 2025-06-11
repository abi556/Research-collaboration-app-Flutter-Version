import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:research_collaboration_app/application/use_cases/apply_for_project.dart';
import 'package:research_collaboration_app/domain/entities/application.dart';
import 'package:research_collaboration_app/domain/repositories/application_repository.dart';

@GenerateMocks([ApplicationRepository])
import 'apply_for_project_test.mocks.dart';

void main() {
  late ApplyForProject useCase;
  late MockApplicationRepository mockRepository;

  setUp(() {
    mockRepository = MockApplicationRepository();
    useCase = ApplyForProject(mockRepository);
  });

  group('ApplyForProject Use Case Tests', () {
    const testApplication = Application(
      id: 1,
      studentId: 2,
      projectId: 3,
      status: ApplicationStatus.PENDING,
    );

    test('should apply for a project successfully', () async {
      when(mockRepository.applyForProject(3, 2))
          .thenAnswer((_) async => testApplication);

      final result = await useCase(3, 2);

      expect(result, equals(testApplication));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should throw exception when repository fails', () async {
      when(mockRepository.applyForProject(3, 2))
          .thenThrow(Exception('Failed to apply'));

      expect(() => useCase(3, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should throw exception for invalid project ID', () async {
      when(mockRepository.applyForProject(-1, 2))
          .thenThrow(Exception('Invalid project ID'));

      expect(() => useCase(-1, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(-1, 2)).called(1);
    });

    test('should throw exception for invalid student ID', () async {
      when(mockRepository.applyForProject(3, -1))
          .thenThrow(Exception('Invalid student ID'));

      expect(() => useCase(3, -1), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, -1)).called(1);
    });

    test('should throw exception for duplicate application', () async {
      when(mockRepository.applyForProject(3, 2))
          .thenThrow(Exception('Duplicate application'));

      expect(() => useCase(3, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should handle application with APPROVED status', () async {
      const approvedApplication = Application(
        id: 2,
        studentId: 2,
        projectId: 3,
        status: ApplicationStatus.APPROVED,
      );
      when(mockRepository.applyForProject(3, 2))
          .thenAnswer((_) async => approvedApplication);

      final result = await useCase(3, 2);

      expect(result.status, ApplicationStatus.APPROVED);
      expect(result, equals(approvedApplication));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should handle application with REJECTED status', () async {
      const rejectedApplication = Application(
        id: 3,
        studentId: 2,
        projectId: 3,
        status: ApplicationStatus.REJECTED,
      );
      when(mockRepository.applyForProject(3, 2))
          .thenAnswer((_) async => rejectedApplication);

      final result = await useCase(3, 2);

      expect(result.status, ApplicationStatus.REJECTED);
      expect(result, equals(rejectedApplication));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should handle zero project ID', () async {
      when(mockRepository.applyForProject(0, 2))
          .thenThrow(Exception('Invalid project ID'));

      expect(() => useCase(0, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(0, 2)).called(1);
    });

    test('should handle zero student ID', () async {
      when(mockRepository.applyForProject(3, 0))
          .thenThrow(Exception('Invalid student ID'));

      expect(() => useCase(3, 0), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, 0)).called(1);
    });

    test('should handle network timeout', () async {
      when(mockRepository.applyForProject(3, 2))
          .thenThrow(Exception('Network timeout'));

      expect(() => useCase(3, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should handle server error', () async {
      when(mockRepository.applyForProject(3, 2))
          .thenThrow(Exception('Server error'));

      expect(() => useCase(3, 2), throwsA(isA<Exception>()));
      verify(mockRepository.applyForProject(3, 2)).called(1);
    });

    test('should handle maximum integer values', () async {
      const maxIntApplication = Application(
        id: 9223372036854775807,
        studentId: 9223372036854775807,
        projectId: 9223372036854775807,
        status: ApplicationStatus.PENDING,
      );
      when(mockRepository.applyForProject(9223372036854775807, 9223372036854775807))
          .thenAnswer((_) async => maxIntApplication);

      final result = await useCase(9223372036854775807, 9223372036854775807);

      expect(result, equals(maxIntApplication));
      verify(mockRepository.applyForProject(9223372036854775807, 9223372036854775807)).called(1);
    });

    test('should handle application with same IDs', () async {
      const sameIdApplication = Application(
        id: 1,
        studentId: 1,
        projectId: 1,
        status: ApplicationStatus.PENDING,
      );
      when(mockRepository.applyForProject(1, 1))
          .thenAnswer((_) async => sameIdApplication);

      final result = await useCase(1, 1);

      expect(result, equals(sameIdApplication));
      verify(mockRepository.applyForProject(1, 1)).called(1);
    });
  });
}