import 'package:flutter_test/flutter_test.dart';
import 'package:research_collaboration_app/domain/entities/user.dart';

void main() {
  group('User Entity Tests', () {
    test('should create a valid User instance', () {
      const user = User(
        id: 1,
        email: 'test@example.com',
        name: 'Test User',
        department: 'Computer Science',
        bio: 'Test bio',
        role: Role.STUDENT,
        skills: ['Flutter', 'Dart'],
        researchInterests: 'AI, ML',
        isActive: true,
      );

      expect(user.id, equals(1));
      expect(user.email, equals('test@example.com'));
      expect(user.name, equals('Test User'));
      expect(user.department, equals('Computer Science'));
      expect(user.bio, equals('Test bio'));
      expect(user.role, equals(Role.STUDENT));
      expect(user.skills, equals(['Flutter', 'Dart']));
      expect(user.researchInterests, equals('AI, ML'));
      expect(user.isActive, isTrue);
    });

    test('should create a User instance with minimal required fields', () {
      const user = User(
        id: 1,
        email: 'test@example.com',
      );

      expect(user.id, equals(1));
      expect(user.email, equals('test@example.com'));
      expect(user.name, isNull);
      expect(user.department, isNull);
      expect(user.bio, isNull);
      expect(user.role, isNull);
      expect(user.skills, isNull);
      expect(user.researchInterests, isNull);
      expect(user.isActive, isNull);
    });

    test('should convert User to and from JSON', () {
      const user = User(
        id: 1,
        email: 'test@example.com',
        name: 'Test User',
        department: 'Computer Science',
        bio: 'Test bio',
        role: Role.STUDENT,
        skills: ['Flutter', 'Dart'],
        researchInterests: 'AI, ML',
        isActive: true,
      );

      final json = user.toJson();
      final fromJson = User.fromJson(json);

      expect(fromJson, equals(user));
    });

    test('should create a copy of User with modified fields', () {
      const user = User(
        id: 1,
        email: 'test@example.com',
        name: 'Test User',
        department: 'Computer Science',
      );

      final modifiedUser = user.copyWith(
        name: 'Updated Name',
        department: 'Updated Department',
        role: Role.PROFESSOR,
      );

      expect(modifiedUser.id, equals(1));
      expect(modifiedUser.email, equals('test@example.com'));
      expect(modifiedUser.name, equals('Updated Name'));
      expect(modifiedUser.department, equals('Updated Department'));
      expect(modifiedUser.role, equals(Role.PROFESSOR));
      expect(modifiedUser.bio, isNull);
      expect(modifiedUser.skills, isNull);
      expect(modifiedUser.researchInterests, isNull);
      expect(modifiedUser.isActive, isNull);
    });

    test('should handle empty skills list', () {
      const user = User(
        id: 1,
        email: 'test@example.com',
        skills: [],
      );

      expect(user.skills, isEmpty);
    });

    test('should handle different Role values', () {
      const student = User(
        id: 1,
        email: 'student@example.com',
        role: Role.STUDENT,
      );

      const professor = User(
        id: 2,
        email: 'professor@example.com',
        role: Role.PROFESSOR,
      );

      const admin = User(
        id: 3,
        email: 'admin@example.com',
        role: Role.ADMIN,
      );

      expect(student.role, equals(Role.STUDENT));
      expect(professor.role, equals(Role.PROFESSOR));
      expect(admin.role, equals(Role.ADMIN));
    });
  });
} 