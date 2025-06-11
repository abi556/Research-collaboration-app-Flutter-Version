import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/collabrix_logo.png', height: 32, width: 32, errorBuilder: (_, __, ___) => const Icon(Icons.science)),
            const SizedBox(width: 8),
            const Text('Collabrix', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Student!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track your research projects and applications',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Stats Section
            Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Applied Projects',
                    value: '0',
                    icon: Icons.send,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Active Projects',
                    value: '0',
                    icon: Icons.work,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Applications Section
            Text(
              'Recent Applications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _PlaceholderList(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text('Project ${index + 1}'),
                  subtitle: Text('Status: Pending'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to project details
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Available Projects Section
            Text(
              'Available Projects',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _PlaceholderList(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text('Research Project ${index + 1}'),
                  subtitle: Text('Professor Name'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to project details
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to project search
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const _PlaceholderList({
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: itemBuilder,
    );
  }
}

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              _DrawerItem(label: 'Dashboard', onTap: () { context.go('/student/dashboard'); Navigator.of(context).pop(); }),
              _DrawerItem(label: 'Browse Researches', onTap: () { context.go('/student/browse'); Navigator.of(context).pop(); }),
              _DrawerItem(label: 'My Applications', onTap: () { context.go('/student/applications'); Navigator.of(context).pop(); }),
              _DrawerItem(label: 'Profile', onTap: () { context.go('/student/profile'); Navigator.of(context).pop(); }),
              const Spacer(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text('Logout', style: TextStyle(color: Colors.black)),
                onTap: () {
                  // TODO: Implement logout
                  Navigator.of(context).pop();
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
  final VoidCallback onTap;
  const _DrawerItem({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
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