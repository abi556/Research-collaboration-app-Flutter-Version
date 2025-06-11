import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:research_collaboration_app/application/use_cases/delete_user.dart';
import 'package:research_collaboration_app/domain/repositories/user_repository.dart';

@GenerateMocks([UserRepository])
import 'delete_user_test.mocks.dart';

void main() {
  late DeleteUser useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = DeleteUser(mockRepository);
  });

  group('DeleteUser Use Case Tests', () {
    test('should delete a user successfully', () async {
      // Arrange
      const userId = 1;
      when(mockRepository.deleteUser(userId)).thenAnswer((_) async {});

      // Act
      await useCase(userId);

      // Assert
      verify(mockRepository.deleteUser(userId)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      const userId = 1;
      when(mockRepository.deleteUser(userId))
          .thenThrow(Exception('Failed to delete user'));

      // Act & Assert
      expect(() => useCase(userId), throwsA(isA<Exception>()));
      verify(mockRepository.deleteUser(userId)).called(1);
    });

    test('should throw exception when user ID is invalid', () async {
      // Arrange
      const invalidUserId = -1;
      when(mockRepository.deleteUser(invalidUserId))
          .thenThrow(Exception('Invalid user ID'));

      // Act & Assert
      expect(() => useCase(invalidUserId), throwsA(isA<Exception>()));
      verify(mockRepository.deleteUser(invalidUserId)).called(1);
    });

    test('should throw exception when user does not exist', () async {
      // Arrange
      const nonExistentUserId = 999;
      when(mockRepository.deleteUser(nonExistentUserId))
          .thenThrow(Exception('User not found'));

      // Act & Assert
      expect(() => useCase(nonExistentUserId), throwsA(isA<Exception>()));
      verify(mockRepository.deleteUser(nonExistentUserId)).called(1);
    });

    test('should handle null user ID gracefully', () async {
      // Arrange
      const nullUserId = 0;
      when(mockRepository.deleteUser(nullUserId))
          .thenThrow(Exception('User ID cannot be null'));

      // Act & Assert
      expect(() => useCase(nullUserId), throwsA(isA<Exception>()));
      verify(mockRepository.deleteUser(nullUserId)).called(1);
    });
  });
} 