import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:research_collaboration_app/core/routing/app_router.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';

class ProfessorDrawer extends ConsumerWidget {
  final User user;

  const ProfessorDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get current route to highlight active item
    final String currentRoute = GoRouterState.of(context).matchedLocation;
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/collabrix_logo.png', height: 28, width: 28, errorBuilder: (_, __, ___) => const Icon(Icons.science)),
                  const SizedBox(width: 8),
                  const Text('Collabrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _DrawerItem(
                label: 'Dashboard',
                isActive: currentRoute == AppRoutes.professorDashboard,
                onTap: () {
                  context.go(AppRoutes.professorDashboard);
                  Navigator.pop(context);
                },
              ),
              _DrawerItem(
                label: 'My Projects',
                isActive: currentRoute == '/professor/projects',
                onTap: () {
                  context.go('/professor/projects');
                  Navigator.pop(context);
                },
              ),
              _DrawerItem(
                label: 'Applications',
                isActive: currentRoute == '/professor/applications',
                onTap: () {
                  context.go('/professor/applications');
                  Navigator.pop(context);
                },
              ),
              _DrawerItem(
                label: 'Profile',
                isActive: currentRoute == '/professor/profile',
                onTap: () {
                  context.go('/professor/profile');
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text('Logout', style: TextStyle(color: Colors.black)),
                onTap: () async {
                  // Terminate session and navigate to splash screen
                  await ref.read(authProvider.notifier).logout();
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: isActive ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 