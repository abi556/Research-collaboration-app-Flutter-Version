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
  });
} 