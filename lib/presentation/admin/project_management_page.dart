import 'package:flutter/material.dart';

class ProjectManagementPage extends StatelessWidget {
  const ProjectManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* AppBar is not visible in the provided image */
      // appBar: AppBar(
      //   title: const Text('Project Management'),
      // ),
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
                              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Project Management',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Manage and monitor all research projects',
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
                    'Project Management',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Manage and monitor all research projects',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Projects...',
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
                        value: 'All Statuses',
                        onChanged: (String? newValue) {},
                        items: <String>[
                          'All Statuses',
                          'Active',
                          'Pending',
                          'Completed',
                          'Open'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: 'All Departments',
                        onChanged: (String? newValue) {},
                        items: <String>[
                          'All Departments',
                          'Computer Science',
                          'Software Engineering',
                          'Physics',
                          'Medical Research',
                          'Information System'
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
                      _buildTabButton('All Projects'),
                      _buildTabButton('Active'),
                      _buildTabButton('Pending'),
                      _buildTabButton('Completed'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Project Name')),
                          DataColumn(label: Text('Professor')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Students')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: [
                          DataRow(cells: [
                            const DataCell(SizedBox(
                                width: 150,
                                child:
                                    Text('Machine Learning For Climate Data'))),
                            const DataCell(Text('Dr. Smith')),
                            const DataCell(Text('Computer Science')),
                            const DataCell(Text('3/5')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(
                                width: 150,
                                child: Text(
                                    'Neural Network for Image Recognition'))),
                            const DataCell(Text('Dr. Abreham')),
                            const DataCell(Text('Software Engineering')),
                            const DataCell(Text('4/4')),
                            DataCell(Chip(
                                label: const Text('Active'),
                                backgroundColor: Colors.green[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(
                                width: 150,
                                child: Text('Quantum Computing Algorithms'))),
                            const DataCell(Text('Ms. Hana')),
                            const DataCell(Text('Physics')),
                            const DataCell(Text('0/5')),
                            DataCell(Chip(
                                label: const Text('Pending'),
                                backgroundColor: Colors.yellow[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(
                                width: 150,
                                child: Text('AI In Health Diagnostics'))),
                            const DataCell(Text('Prof. Welde')),
                            const DataCell(Text('Medical Research')),
                            const DataCell(Text('0/6')),
                            DataCell(Chip(
                                label: const Text('Open'),
                                backgroundColor: Colors.blue[100])),
                            const DataCell(ElevatedButton(
                                onPressed: null, child: Text('Deactivate'))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(
                                width: 150,
                                child: Text(
                                    'Data Mining for Social Media Analysis'))),
                            const DataCell(Text('Dr. Hiwot')),
                            const DataCell(Text('Information System')),
                            const DataCell(Text('5/5')),
                            DataCell(Chip(
                                label: const Text('Completed'),
                                backgroundColor: Colors.grey[300])),
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
        selected: text == 'All Projects', // Handles selection state for the tab
        onSelected: (bool selected) {},
      ),
    );
  }
}
