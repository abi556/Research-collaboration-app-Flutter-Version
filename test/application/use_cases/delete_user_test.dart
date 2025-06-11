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
      when(mockRepository.deleteUser(1)).thenAnswer((_) async {});

      await useCase(1);

      verify(mockRepository.deleteUser(1)).called(1);
    });

    test('should throw exception when repository fails', () async {
      when(mockRepository.deleteUser(1)).thenThrow(Exception('Failed to delete user'));

      expect(() => useCase(1), throwsA(isA<Exception>()));
      verify(mockRepository.deleteUser(1)).called(1);
    });
  });
} 