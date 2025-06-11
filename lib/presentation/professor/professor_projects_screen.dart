import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/presentation/professor/widgets/professor_drawer.dart';
import 'package:research_collaboration_app/features/professor/dashboard/providers/dashboard_providers.dart';

class ProfessorProjectsScreen extends ConsumerWidget {
  const ProfessorProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (user) => _buildProjectsScreen(context, user),
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildProjectsScreen(BuildContext context, User user) {
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
      ),
      drawer: ProfessorDrawer(user: user),
      body: Consumer(
        builder: (context, ref, _) {
          final projectsAsync = ref.watch(professorProjectsProvider);
          return projectsAsync.when(
            data: (projects) => SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search project',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Project Cards
                  if (projects.isEmpty)
                    const Text('No projects yet.'),
                  ...projects.map((p) => _buildProjectCard(p.title, p.description)).toList(),
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          );
        },
      ),
    );
  }

  Widget _buildProjectCard(String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: Navigate to project details
                },
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 