import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ApplicationStatus { approved, rejected, pending }

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ApplicationList(status: 'Pending Review'),
            _ApplicationList(status: 'Approved'),
            _ApplicationList(status: 'Rejected'),
          ],
        ),
      ),
    );
  }
}

class _ApplicationList extends StatelessWidget {
  final String status;
  const _ApplicationList({required this.status});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Impact of Micro-Interactions on User Engagement in Mobile Apps', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('Led By Dr. Jhon', style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: status == 'Pending Review' ? Colors.yellow[100] : status == 'Approved' ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(status, style: TextStyle(
                    color: status == 'Pending Review' ? Colors.orange : status == 'Approved' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                Text('Your application message: I am very interested in learning Impact of Micro-Interactions in Mobile Apps and I would love to contribute to this research project.'),
                const SizedBox(height: 8),
                if (status == 'Pending Review')
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Withdraw Application'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 
