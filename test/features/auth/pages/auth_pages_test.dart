import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/features/auth/presentation/pages/login_page.dart';
import 'package:research_collaboration_app/features/auth/presentation/pages/signup_page.dart';
import 'package:research_collaboration_app/test/helpers/test_helpers.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockAuthNotifier mockAuthNotifier;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAuthNotifier = MockAuthNotifier();
  });

  group('Login Page Tests', () {
    testWidgets('should show login form with email and password fields',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: LoginPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          // Assert
          expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
          expect(find.byType(ElevatedButton), findsOneWidget); // Login button
        });

    testWidgets('should show error message when login fails',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());
          when(() => mockAuthNotifier.login(any(), any()))
              .thenAnswer((_) async => AuthState.error('Invalid credentials'));

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: LoginPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
          await tester.enterText(find.byType(TextFormField).last, 'password');
          await tester.tap(find.byType(ElevatedButton));
          await tester.pumpAndSettle();

          // Assert
          expect(find.text('Invalid credentials'), findsOneWidget);
        });

    testWidgets('should navigate to signup page when signup link is tapped',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: LoginPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          await tester.tap(find.text('Sign up'));
          await tester.pumpAndSettle();

          // Assert
          expect(find.byType(SignupPage), findsOneWidget);
        });
  });

  group('Signup Page Tests', () {
    testWidgets('should show signup form with all required fields',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: SignupPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          // Assert
          expect(find.byType(TextFormField), findsNWidgets(4)); // Name, email, password, and role fields
          expect(find.byType(ElevatedButton), findsOneWidget); // Signup button
        });

    testWidgets('should show error message when signup fails',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());
          when(() => mockAuthNotifier.signup(any(), any(), any(), any()))
              .thenAnswer((_) async => AuthState.error('Email already exists'));

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: SignupPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          await tester.enterText(find.byType(TextFormField).first, 'Test User');
          await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
          await tester.enterText(find.byType(TextFormField).at(2), 'password');
          await tester.tap(find.byType(ElevatedButton));
          await tester.pumpAndSettle();

          // Assert
          expect(find.text('Email already exists'), findsOneWidget);
        });

    testWidgets('should navigate to login page when login link is tapped',
            (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthNotifier.state).thenReturn(const AuthState.initial());

          // Act
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authProvider.overrideWith((ref) => mockAuthNotifier),
              ],
              child: const TestApp(
                child: SignupPage(),
                mockAuthRepository: mockAuthRepository,
              ),
            ),
          );

          await tester.tap(find.text('Login'));
          await tester.pumpAndSettle();

          // Assert
          expect(find.byType(LoginPage), findsOneWidget);
        });
  });
}