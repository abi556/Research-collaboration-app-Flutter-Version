import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/presentation/student/student_dashboard.dart';
import 'package:research_collaboration_app/presentation/professor/professor_dashboard.dart';
import 'package:research_collaboration_app/presentation/admin/admin_dashboard.dart';

final dashboardProvider = Provider<Widget>((ref) {
  final user = ref.watch(authProvider).maybeWhen(
        authenticated: (user) => user,
        orElse: () => null,
      );

  if (user == null) {
    return const SizedBox.shrink();
  }

  switch (user.role.toLowerCase()) {
    case 'student':
      return const StudentDashboard();
    case 'professor':
      return const ProfessorDashboard();
    case 'admin':
      return const AdminDashboard();
    default:
      return const SizedBox.shrink();
  }
}); 