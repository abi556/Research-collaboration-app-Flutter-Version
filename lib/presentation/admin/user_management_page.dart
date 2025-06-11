import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Navigation Sidebar */
          Card(
            margin: const EdgeInsets.all(20.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.menu), onPressed: () {}),
                        const Text(
                          'Collabrix',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'User Management',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Manage Users and their permissions',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /* Main Content Area */
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Management Overview',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Manage users and their associated permissions within the system.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for users...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: 'All Departments',
                        onChanged: (String? newValue) {},
                        items: <String>[
                          'All Departments',
                          'Software Engineering',
                          'Computer Science',
                          'Biology',
                          'Psychology',
                          'Medicine'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildTabButton('All Users'),
                      _buildTabButton('Students'),
                      _buildTabButton('Professors'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Role')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: [
                          DataRow(cells: [
                            const DataCell(Text('Dawit Misge')),
                            const DataCell(Text('dawit.misge-@aau.edu.et')),
                            DataCell(Chip(
                                label: const Text('STUDENT'),
                                backgroundColor: Colors.blueAccent[100])),
                            const DataCell(Text('Software Engineering')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('Abiy Hailu')),
                            const DataCell(Text('abiy.hailu-ug@aau.edu.et')),
                            DataCell(Chip(
                                label: const Text('STUDENT'),
                                backgroundColor: Colors.blueAccent[100])),
                            const DataCell(Text('Computer Science')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('Dr. Tesfaye Welde')),
                            const DataCell(Text('tesfaye.welde@aau.edu.et')),
                            DataCell(Chip(
                                label: const Text('PROFESSOR'),
                                backgroundColor: Colors.purpleAccent[100])),
                            const DataCell(Text('Biology')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('Prof Smith Bren')),
                            const DataCell(Text('smith.bren@yale.edu.et')),
                            DataCell(Chip(
                                label: const Text('PROFESSOR'),
                                backgroundColor: Colors.purpleAccent[100])),
                            const DataCell(Text('Psychology')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(Text('Dr. Hiwot Hailu')),
                            const DataCell(Text('hiwot.hailu@mit.edu')),
                            DataCell(Chip(
                                label: const Text('PROFESSOR'),
                                backgroundColor: Colors.purpleAccent[100])),
                            const DataCell(Text('Medicine')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(text),
        selected:
            text == 'All Users', // Handles selection state for the tab
        onSelected: (bool selected) {},
      ),
    );
  }
}
