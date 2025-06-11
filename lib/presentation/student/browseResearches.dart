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
        title: Text(
          'Browse Researches',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search researches...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
                setState(() {});
              },
            ),
          ),
          // Research List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _researches.length,
              itemBuilder: (context, index) {
                final research = _researches[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          research['title'],
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              research['author'],
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.business, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              research['department'],
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: research['status'] == 'Ongoing'
                                ? Colors.blue[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            research['status'],
                            style: GoogleFonts.inter(
                              color: research['status'] == 'Ongoing'
                                  ? Colors.blue[700]
                                  : Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 
