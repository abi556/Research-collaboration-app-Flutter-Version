import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/presentation/professor/widgets/professor_drawer.dart';
import 'package:research_collaboration_app/features/auth/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfessorProfileScreen extends ConsumerWidget {
  const ProfessorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (user) => _buildProfileScreen(context, user),
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildProfileScreen(BuildContext context, User user) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset('assets/images/collabrix_logo.png', height: 32, width: 32, errorBuilder: (_, __, ___) => const Icon(Icons.science)),
            const SizedBox(width: 8),
            const Text('Collabrix', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                // TODO: Implement edit profile navigation
              },
              child: const Text('Edit Profile'),
            ),
          ),
        ],
      ),
      drawer: ProfessorDrawer(user: user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.person, size: 48, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    Text(user.name ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Professor', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const SizedBox(height: 8),
                    Text('Professor of Computer Science', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(user.email ?? 'No Email', style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 2),
                    Text('University of Technology', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                    const SizedBox(height: 2),
                    Text('Department of CS', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Danger Zone
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Danger Zone', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Actions here cannot be undone', style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (shouldDelete == true) {
                          final scaffoldMessenger = ScaffoldMessenger.of(context);
                          try {
                            final container = ProviderScope.containerOf(context);
                            final prefs = await SharedPreferences.getInstance();
                            final authService = AuthService(
                              dio: container.read(dioProvider),
                              prefs: prefs,
                            );
                            await authService.deleteAccount();
                            // Optionally, log out and navigate to splash screen
                            container.read(authProvider.notifier).logout();
                            // Use GoRouter to navigate to splash screen
                            context.go('/');
                          } catch (e) {
                            scaffoldMessenger.showSnackBar(
                              SnackBar(content: Text('Failed to delete account: $e')),
                            );
                          }
                        }
                      },
                      child: const Text('Delete Account'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // About Me
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('About Me', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Professor of computer science with over 15 years of experience in machine learning research'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Research Interests
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Research Interests', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(label: Text('AI')),
                        Chip(label: Text('ML')),
                        Chip(label: Text('LLM')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 