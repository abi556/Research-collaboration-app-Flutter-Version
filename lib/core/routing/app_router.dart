import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/presentation/auth/splash_screen.dart';
import 'package:research_collaboration_app/presentation/auth/login_screen.dart';
import 'package:research_collaboration_app/presentation/auth/signup_screen.dart';
import 'package:research_collaboration_app/presentation/auth/forgot_password_screen.dart';
import 'package:research_collaboration_app/presentation/student/student_dashboard.dart';
import 'package:research_collaboration_app/presentation/professor/professor_dashboard.dart';
import 'package:research_collaboration_app/presentation/admin/admin_dashboard.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';

// Route names as constants
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String studentDashboard = '/student';
  static const String professorDashboard = '/professor';
  static const String adminDashboard = '/admin';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final dashboardRoutes = [
        AppRoutes.studentDashboard,
        AppRoutes.professorDashboard,
        AppRoutes.adminDashboard,
      ];

      // Wait for auth state to finish loading before redirecting
      final isLoading = authState.maybeWhen(
        loading: () => true,
        orElse: () => false,
      );
      if (isLoading) {
        // Stay on splash while loading
        if (state.matchedLocation != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      }

      final user = authState.maybeWhen(authenticated: (u) => u, orElse: () => null);
      if (user != null) {
        // If on splash, login, signup, or forgot password, go to dashboard
        if ([AppRoutes.splash, AppRoutes.login, AppRoutes.signup, AppRoutes.forgotPassword].contains(state.matchedLocation)) {
          switch (user.role.toLowerCase()) {
            case 'student':
              return AppRoutes.studentDashboard;
            case 'professor':
              return AppRoutes.professorDashboard;
            case 'admin':
              return AppRoutes.adminDashboard;
          }
        }
      }

      // If not authenticated and trying to access dashboard, redirect to login
      final isAuthenticated = user != null;
      if (!isAuthenticated && dashboardRoutes.contains(state.matchedLocation)) {
        return AppRoutes.login;
      }

      // Do not redirect for loading, initial, or error states
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => SplashScreen(
          onGetStarted: () => context.go(AppRoutes.login),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(
          onSignUp: () => context.go(AppRoutes.signup),
          onForgotPassword: () => context.go(AppRoutes.forgotPassword),
          onLoginSuccess: (role) {}, // Navigation handled by redirect
        ),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => SignupScreen(
          onLogin: () => context.go(AppRoutes.login),
          onSignupSuccess: (role) {}, // Navigation handled by redirect
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(
          onBackToLogin: () => context.go(AppRoutes.login),
        ),
      ),

      // Role-based Dashboard Routes
      GoRoute(
        path: AppRoutes.studentDashboard,
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: AppRoutes.professorDashboard,
        builder: (context, state) => const ProfessorDashboard(),
      ),
      GoRoute(
        path: AppRoutes.adminDashboard,
        builder: (context, state) => const AdminDashboard(),
      ),
    ],
  );
}); 