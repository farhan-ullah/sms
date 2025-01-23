import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: ListView(
        children: [
          // Reports Section
          ListTile(
            title: const Text('Student Reports'),
            subtitle: const Text('Generate and view student reports'),
            leading: const Icon(Icons.school),
            onTap: () {
              // Navigate to Student Report Screen
            },
          ),
          const Divider(),

          ListTile(
            title: const Text('Teacher Reports'),
            subtitle: const Text('Generate and view teacher reports'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Navigate to Teacher Report Screen
            },
          ),
          const Divider(),

          ListTile(
            title: const Text('Fee Reports'),
            subtitle: const Text('Generate and view fee payment reports'),
            leading: const Icon(Icons.attach_money),
            onTap: () {
              // Navigate to Fee Report Screen
            },
          ),
          const Divider(),

          ListTile(
            title: const Text('Attendance Reports'),
            subtitle: const Text('Generate and view student attendance reports'),
            leading: const Icon(Icons.access_alarm),
            onTap: () {
              // Navigate to Attendance Report Screen
            },
          ),
          const Divider(),

          // Additional Reports
          ListTile(
            title: const Text('Grade Reports'),
            subtitle: const Text('View student grade reports'),
            leading: const Icon(Icons.grade),
            onTap: () {
              // Navigate to Grade Report Screen
            },
          ),
          const Divider(),

          ListTile(
            title: const Text('Exam Reports'),
            subtitle: const Text('Generate examModel performance reports'),
            leading: const Icon(Icons.assignment),
            onTap: () {
              // Navigate to Exam Report Screen
            },
          ),
          const Divider(),

          ListTile(
            title: const Text('Financial Reports'),
            subtitle: const Text('View school financial summary'),
            leading: const Icon(Icons.account_balance_wallet),
            onTap: () {
              // Navigate to Financial Report Screen
            },
          ),
          const Divider(),

          // Date Range Picker or Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Generate Reports for Specific Date Range:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Date range picker or date filter (Placeholder for now)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Open date range picker
                      },
                      child: const Text('Select Date Range'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Export Options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Export Report:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Export report as PDF
                      },
                      child: const Text('Export as PDF'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Export report as CSV
                      },
                      child: const Text('Export as CSV'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
