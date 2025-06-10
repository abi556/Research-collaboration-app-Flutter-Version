import 'package:flutter/material.dart';
import 'auth/splash_screen.dart';
import 'auth/login_screen.dart';
import 'auth/signup_screen.dart';
import 'auth/forgot_password_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onGetStarted: () => Navigator.pushReplacementNamed(context, login),
          ),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(
            onSignUp: () => Navigator.pushReplacementNamed(context, signup),
          ),
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => SignupScreen(
            onLogin: () => Navigator.pushReplacementNamed(context, login),
          ),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(
            onBackToLogin: () => Navigator.pushReplacementNamed(context, login),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onGetStarted: () => Navigator.pushReplacementNamed(context, login),
          ),
        );
    }
  }
} 