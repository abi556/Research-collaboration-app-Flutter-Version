import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/test/helpers/test_helpers.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthNotifier authNotifier;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authNotifier = AuthNotifier(mockAuthRepository);
  });

  group('AuthNotifier', () {
    test('initial state should be initial', () {
      expect(authNotifier.state, const AuthState.initial());
    });

    group('checkAuthStatus', () {
      test('should emit authenticated state when user is found', () async {
        // Arrange
        final user = createTestUser();
        when(() => mockAuthRepository.getCurrentUser())
            .thenAnswer((_) async => Right(user));

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, AuthState.authenticated(user));
      });

      test('should emit unauthenticated state when no user is found', () async {
        // Arrange
        when(() => mockAuthRepository.getCurrentUser())
            .thenAnswer((_) async => const Right(null));

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
      });

      test('should emit error state when repository throws error', () async {
        // Arrange
        when(() => mockAuthRepository.getCurrentUser())
            .thenAnswer((_) async => Left(ServerFailure('Error')));

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, const AuthState.error('Error'));
      });
    });

    group('login', () {
      test('should emit authenticated state when login is successful', () async {
        // Arrange
        final user = createTestUser();
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => Right(user));

        // Act
        await authNotifier.login('test@example.com', 'password');

        // Assert
        expect(authNotifier.state, AuthState.authenticated(user));
      });

      test('should emit error state when login fails', () async {
        // Arrange
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => Left(ServerFailure('Invalid credentials')));

        // Act
        await authNotifier.login('test@example.com', 'password');

        // Assert
        expect(authNotifier.state, const AuthState.error('Invalid credentials'));
      });
    });

    group('signup', () {
      test('should emit authenticated state when signup is successful', () async {
        // Arrange
        final user = createTestUser();
        when(() => mockAuthRepository.signup(any(), any(), any(), any()))
            .thenAnswer((_) async => Right(user));

        // Act
        await authNotifier.signup('test@example.com', 'password', 'researcher', 'Test User');

        // Assert
        expect(authNotifier.state, AuthState.authenticated(user));
      });

      test('should emit error state when signup fails', () async {
        // Arrange
        when(() => mockAuthRepository.signup(any(), any(), any(), any()))
            .thenAnswer((_) async => Left(ServerFailure('Email already exists')));

        // Act
        await authNotifier.signup('test@example.com', 'password', 'researcher', 'Test User');

        // Assert
        expect(authNotifier.state, const AuthState.error('Email already exists'));
      });
    });

    group('logout', () {
      test('should emit unauthenticated state when logout is successful', () async {
        // Arrange
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Right(null));

        // Act
        await authNotifier.logout();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
      });

      test('should emit error state when logout fails', () async {
        // Arrange
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => Left(ServerFailure('Logout failed')));

        // Act
        await authNotifier.logout();

        // Assert
        expect(authNotifier.state, const AuthState.error('Logout failed'));
      });
    });

    group('forgotPassword', () {
      test('should emit unauthenticated state when forgot password is successful', () async {
        // Arrange
        when(() => mockAuthRepository.forgotPassword(any()))
            .thenAnswer((_) async => const Right(null));

        // Act
        await authNotifier.forgotPassword('test@example.com');

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
      });

      test('should emit error state when forgot password fails', () async {
        // Arrange
        when(() => mockAuthRepository.forgotPassword(any()))
            .thenAnswer((_) async => Left(ServerFailure('Email not found')));

        // Act
        await authNotifier.forgotPassword('test@example.com');

        // Assert
        expect(authNotifier.state, const AuthState.error('Email not found'));
      });
    });
  });
}