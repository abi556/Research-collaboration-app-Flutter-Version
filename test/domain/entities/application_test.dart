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
  });
} 