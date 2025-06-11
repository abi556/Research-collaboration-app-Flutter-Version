import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ApplicationStatus { approved, rejected, pending }

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  ApplicationStatus _selectedStatus = ApplicationStatus.pending;

  final List<Map<String, dynamic>> _applications = [
    {
      'title': 'Machine Learning in Healthcare',
      'supervisor': 'Dr. John Smith',
      'department': 'Computer Science',
      'status': ApplicationStatus.pending,
      'description': 'Research on implementing machine learning algorithms in healthcare systems for better patient care and diagnosis.',
      'date': '2024-03-15',
    },
    {
      'title': 'Quantum Computing Applications',
      'supervisor': 'Dr. Sarah Johnson',
      'department': 'Physics',
      'status': ApplicationStatus.approved,
      'description': 'Study of quantum computing applications in solving complex mathematical problems.',
      'date': '2024-03-10',
    },
    {
      'title': 'Sustainable Energy Solutions',
      'supervisor': 'Dr. Michael Brown',
      'department': 'Engineering',
      'status': ApplicationStatus.rejected,
      'description': 'Research on developing sustainable energy solutions for urban environments.',
      'date': '2024-03-05',
    },
  ];

  Color _getStatusColor(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.approved:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
      case ApplicationStatus.pending:
        return Colors.orange;
    }
  }

  String _getStatusText(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.approved:
        return 'Approved';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredApplications = _applications
        .where((app) => app['status'] == _selectedStatus)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // TODO: Implement drawer functionality
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Collabrix',
                  style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'My Application',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Research Applications',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Track the status of your research project applications',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 24),

              // Status Filter Box
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background for the segmented control
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(color: Colors.grey[300]!), // Removed border to match image
                ),
                child: Row(
                  children: ApplicationStatus.values.map((status) {
                    final isSelected = _selectedStatus == status;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStatus = status;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Text(
                            _getStatusText(status),
                            style: GoogleFonts.inter(
                              color: isSelected ? Colors.black87 : Colors.black54,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Applications List
              ...filteredApplications.map((application) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application['title'],
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Led By ${application['supervisor']}',
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: application['status'] == ApplicationStatus.pending
                                    ? Colors.yellow[100]
                                    : _getStatusColor(application['status'])
                                        .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20), // More rounded corners
                              ),
                              child: Text(
                                application['status'] == ApplicationStatus.pending
                                    ? 'Pending Review'
                                    : _getStatusText(application['status']),
                                style: GoogleFonts.inter(
                                  color: application['status'] == ApplicationStatus.pending
                                      ? Colors.yellow[900] // Darker yellow for text
                                      : _getStatusColor(application['status']),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your application message:',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          application['description'],
                          style: GoogleFonts.inter(
                            color: Colors.black87,
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement withdraw functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              'Withdraw Application',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
} 
