import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthNotifier extends Mock implements AuthNotifier {}

class TestWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static TestWidgetsFlutterBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) {
      TestWidgetsFlutterBinding();
    }
    return WidgetsBinding.instance as TestWidgetsFlutterBinding;
  }
}

class TestApp extends ConsumerWidget {
  final Widget child;
  final MockAuthRepository mockAuthRepository;

  const TestApp({
    Key? key,
    required this.child,
    required this.mockAuthRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: child,
    );
  }
}

User createTestUser() {
  return User(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    role: 'researcher',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}