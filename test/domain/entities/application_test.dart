import 'package:flutter_test/flutter_test.dart';
import 'package:research_collaboration_app/domain/entities/application.dart';

void main() {
  group('Application Entity Tests', () {
    test('should create a valid Application instance', () {
      const application = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      expect(application.id, equals(1));
      expect(application.studentId, equals(123));
      expect(application.projectId, equals(456));
      expect(application.status, equals(ApplicationStatus.PENDING));
    });

    test('should convert Application to and from JSON', () {
      const application = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      final json = application.toJson();
      final fromJson = Application.fromJson(json);

      expect(fromJson, equals(application));
    });

    test('should handle different application statuses', () {
      const pendingApp = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      const approvedApp = Application(
        id: 2,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.APPROVED,
      );

      const rejectedApp = Application(
        id: 3,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.REJECTED,
      );

      expect(pendingApp.status, equals(ApplicationStatus.PENDING));
      expect(approvedApp.status, equals(ApplicationStatus.APPROVED));
      expect(rejectedApp.status, equals(ApplicationStatus.REJECTED));
    });

    test('should create a copy of Application with modified fields', () {
      const application = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      final modifiedApplication = application.copyWith(
        status: ApplicationStatus.APPROVED,
      );

      expect(modifiedApplication.id, equals(1));
      expect(modifiedApplication.studentId, equals(123));
      expect(modifiedApplication.projectId, equals(456));
      expect(modifiedApplication.status, equals(ApplicationStatus.APPROVED));
    });

    test('should maintain equality between identical applications', () {
      const application1 = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      const application2 = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      expect(application1, equals(application2));
      expect(application1.hashCode, equals(application2.hashCode));
    });

    test('should handle JSON serialization with all status values', () {
      const applications = [
        Application(
          id: 1,
          studentId: 123,
          projectId: 456,
          status: ApplicationStatus.PENDING,
        ),
        Application(
          id: 2,
          studentId: 123,
          projectId: 456,
          status: ApplicationStatus.APPROVED,
        ),
        Application(
          id: 3,
          studentId: 123,
          projectId: 456,
          status: ApplicationStatus.REJECTED,
        ),
      ];

      for (final application in applications) {
        final json = application.toJson();
        final fromJson = Application.fromJson(json);
        expect(fromJson, equals(application));
      }
    });

    test('should handle copyWith with multiple field changes', () {
      const application = Application(
        id: 1,
        studentId: 123,
        projectId: 456,
        status: ApplicationStatus.PENDING,
      );

      final modifiedApplication = application.copyWith(
        studentId: 789,
        projectId: 101,
        status: ApplicationStatus.APPROVED,
      );

      expect(modifiedApplication.id, equals(1));
      expect(modifiedApplication.studentId, equals(789));
      expect(modifiedApplication.projectId, equals(101));
      expect(modifiedApplication.status, equals(ApplicationStatus.APPROVED));
    });
  });
} 