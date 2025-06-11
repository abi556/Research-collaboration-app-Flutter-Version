import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:research_collaboration_app/features/auth/domain/entities/user.dart';
import 'package:research_collaboration_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:research_collaboration_app/presentation/professor/widgets/professor_drawer.dart';
import 'package:research_collaboration_app/presentation/professor/professor_create_project_screen.dart';
import 'package:research_collaboration_app/features/professor/dashboard/providers/dashboard_providers.dart';
import 'package:research_collaboration_app/core/error/failures.dart';

class ProfessorDashboard extends ConsumerWidget {
  const ProfessorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (user) => _buildDashboard(context, user, ref),
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, User user, WidgetRef ref) {
    final statsAsync = ref.watch(professorDashboardStatsProvider);
    final projectsAsync = ref.watch(professorProjectsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/collabrix_logo.png', height: 32, width: 32, errorBuilder: (_, __, ___) => const Icon(Icons.science)),
            const SizedBox(width: 8),
            const Text('Collabrix', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.science, color: Colors.black, size: 24),
              ),
            ),
          ),
        ],
      ),
      drawer: ProfessorDrawer(user: user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text('Welcome back, Professor ${user.name ?? ''}', style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 12),
            SizedBox(
              width: 160,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('New Project', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfessorCreateProjectScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            // Stat cards from provider
            Center(
              child: Column(
                children: [
                  _buildStatCard('Active Projects', '-'),
                  const SizedBox(height: 16),
                  _buildStatCard('Student Applications', '-'),
                  const SizedBox(height: 16),
                  _buildStatCard('Total Students', '-'),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text('Your Research Projects', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            projectsAsync.when(
              data: (projects) => projects.isEmpty
                  ? const Text('No projects yet.')
                  : Column(
                      children: projects.map((p) => _buildProjectCard(p.title, p.description)).toList(),
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: \\${e is Failure ? e.message : e.toString()}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      width: 380, // or MediaQuery.of(context).size.width * 0.95 for responsiveness
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(color: Colors.black87, fontSize: 13)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // TODO: Navigate to project details
                },
                child: const Text('View Details', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 