import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
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
    print('AuthNotifier: Created, calling checkAuthStatus');
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    print('AuthNotifier: checkAuthStatus called');
    state = const AuthState.loading();
    final result = await _authRepository.getCurrentUser();
    result.fold(
      (failure) {
        print('AuthNotifier: checkAuthStatus error: \'${failure.message}\'');
        state = AuthState.error(failure.message);
      },
      (user) {
        print('AuthNotifier: checkAuthStatus user: $user');
        state = user != null ? AuthState.authenticated(user) : const AuthState.unauthenticated();
      },
    );
  }

  Future<void> login(String email, String password, [String? name]) async {
    print('AuthNotifier: login called');
    state = const AuthState.loading();
    final result = await _authRepository.login(email, password, name);
    result.fold(
      (failure) {
        print('AuthNotifier: login error: \'${failure.message}\'');
        state = AuthState.error(failure.message);
      },
      (user) {
        print('AuthNotifier: login success: $user');
        state = AuthState.authenticated(user);
      },
    );
  }

  Future<void> signup(String email, String password, String role, String name) async {
    print('AuthNotifier: signup called');
    state = const AuthState.loading();
    final result = await _authRepository.signup(email, password, role, name);
    result.fold(
      (failure) {
        print('AuthNotifier: signup error: \'${failure.message}\'');
        state = AuthState.error(failure.message);
      },
      (user) {
        print('AuthNotifier: signup success: $user');
        state = AuthState.authenticated(user);
      },
    );
  }

  Future<void> logout() async {
    print('AuthNotifier: logout called');
    state = const AuthState.loading();
    final result = await _authRepository.logout();
    result.fold(
      (failure) {
        print('AuthNotifier: logout error: \'${failure.message}\'');
        state = AuthState.error(failure.message);
      },
      (_) {
        print('AuthNotifier: logout success');
        state = const AuthState.unauthenticated();
      },
    );
  }

  Future<void> forgotPassword(String email) async {
    print('AuthNotifier: forgotPassword called');
    state = const AuthState.loading();
    final result = await _authRepository.forgotPassword(email);
    result.fold(
      (failure) {
        print('AuthNotifier: forgotPassword error: \'${failure.message}\'');
        state = AuthState.error(failure.message);
      },
      (_) {
        print('AuthNotifier: forgotPassword success');
        state = const AuthState.unauthenticated();
      },
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
final authServiceProvider = Provider.family<AuthService, SharedPreferences>((ref, prefs) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio: dio, prefs: prefs);
});

final authRepositoryProvider = Provider.family<AuthRepository, SharedPreferences>((ref, prefs) {
  final authService = ref.watch(authServiceProvider(prefs));
  return AuthRepositoryImpl(authService: authService);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final prefsAsync = ref.watch(sharedPreferencesProvider);
  return prefsAsync.when(
    data: (prefs) {
      final authRepository = ref.watch(authRepositoryProvider(prefs));
      return AuthNotifier(authRepository);
    },
    loading: () => AuthNotifier(_LoadingAuthRepository()),
    error: (e, _) => AuthNotifier(_ErrorAuthRepository(e.toString())),
  );
});

// Dummy repositories for loading/error states
class _LoadingAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, User?>> getCurrentUser() async => const Right(null);
  @override
  Future<Either<Failure, User>> login(String email, String password, [String? name]) async => Left(ServerFailure('Loading'));
  @override
  Future<Either<Failure, void>> logout() async => const Right(null);
  @override
  Future<Either<Failure, User>> signup(String email, String password, String role, String name) async => Left(ServerFailure('Loading'));
  @override
  Future<Either<Failure, void>> forgotPassword(String email) async => const Right(null);
}
class _ErrorAuthRepository implements AuthRepository {
  final String message;
  _ErrorAuthRepository(this.message);
  @override
  Future<Either<Failure, User?>> getCurrentUser() async => Left(ServerFailure(message));
  @override
  Future<Either<Failure, User>> login(String email, String password, [String? name]) async => Left(ServerFailure(message));
  @override
  Future<Either<Failure, void>> logout() async => Left(ServerFailure(message));
  @override
  Future<Either<Failure, User>> signup(String email, String password, String role, String name) async => Left(ServerFailure(message));
  @override
  Future<Either<Failure, void>> forgotPassword(String email) async => Left(ServerFailure(message));
} 