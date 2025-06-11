import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseResearches extends StatefulWidget {
  const BrowseResearches({super.key});

  @override
  State<BrowseResearches> createState() => _BrowseResearchesState();
}

class _BrowseResearchesState extends State<BrowseResearches> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _researches = [
    {
      'title': 'Machine Learning in Healthcare',
      'author': 'Dr. John Smith',
      'department': 'Computer Science',
      'status': 'Ongoing',
    },
    {
      'title': 'Quantum Computing Applications',
      'author': 'Dr. Sarah Johnson',
      'department': 'Physics',
      'status': 'Completed',
    },
    {
      'title': 'Sustainable Energy Solutions',
      'author': 'Dr. Michael Brown',
      'department': 'Engineering',
      'status': 'Ongoing',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Browse Researches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Projects',
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
            _ResearchCard(
              title: 'AI in Healthcare Diagnostics',
              professor: 'Dr. Prof. Weide',
              status: 'Open',
              description: 'Using artificial intelligence to improve early disease detection and diagnosis.',
            ),
            const SizedBox(height: 12),
            _ResearchCard(
              title: 'Neural Networks for Image Recognition',
              professor: 'Dr. Abreham',
              status: 'Open',
              description: 'Developing advanced neural networks for improved image recognition capabilities..',
            ),
          ],
        ),
      ),
    );
  }
}

class _ResearchCard extends StatelessWidget {
  final String title;
  final String professor;
  final String status;
  final String description;
  const _ResearchCard({required this.title, required this.professor, required this.status, required this.description});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text('Led By $professor', style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
