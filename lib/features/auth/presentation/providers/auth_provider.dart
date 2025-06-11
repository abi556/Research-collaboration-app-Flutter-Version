import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    final result = await _authRepository.getCurrentUser();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = user != null ? AuthState.authenticated(user) : const AuthState.unauthenticated(),
    );
  }

  Future<void> login(String email, String password, [String? name]) async {
    state = const AuthState.loading();
    final result = await _authRepository.login(email, password, name);
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signup(String email, String password, String role, String name) async {
    state = const AuthState.loading();
    final result = await _authRepository.signup(email, password, role, name);
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    final result = await _authRepository.logout();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }

  Future<void> forgotPassword(String email) async {
    state = const AuthState.loading();
    final result = await _authRepository.forgotPassword(email);
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
}

// Provider for Dio
final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000')));

// Provider for SharedPreferences (async)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final prefs = ref.watch(sharedPreferencesProvider).maybeWhen(
    data: (prefs) => prefs,
    orElse: () => throw Exception('SharedPreferences not ready'),
  );
  return AuthService(dio: dio, prefs: prefs);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepositoryImpl(authService: authService);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
}); 