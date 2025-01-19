import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // School Information Section
            ListTile(
              title: const Text('School Information'),
              leading: const Icon(Icons.school),
              onTap: () {
                // Navigate to school info settings
              },
            ),
            const Divider(),

            // User Management Section
            ListTile(
              title: const Text('User Management'),
              leading: const Icon(Icons.people),
              onTap: () {
                // Navigate to user management settings
              },
            ),
            const Divider(),

            // Fee Management Section
            ListTile(
              title: const Text('Fee Management'),
              leading: const Icon(Icons.payment),
              onTap: () {
                // Navigate to fee management settings
              },
            ),
            const Divider(),

            // Communication Section
            ListTile(
              title: const Text('Communication Settings'),
              leading: const Icon(Icons.message),
              onTap: () {
                // Navigate to communication settings
              },
            ),
            const Divider(),

            // Timetable Section
            ListTile(
              title: const Text('Timetable & Scheduling'),
              leading: const Icon(Icons.schedule),
              onTap: () {
                // Navigate to timetable settings
              },
            ),
            const Divider(),

            // Security Section
            ListTile(
              title: const Text('Security Settings'),
              leading: const Icon(Icons.security),
              onTap: () {
                // Navigate to security settings
              },
            ),
            const Divider(),

            // Academic Settings Section
            ListTile(
              title: const Text('Academic Settings'),
              leading: const Icon(Icons.grade),
              onTap: () {
                // Navigate to academic settings
              },
            ),
            const Divider(),

            // System Settings Section
            ListTile(
              title: const Text('System Settings'),
              leading: const Icon(Icons.settings_applications),
              onTap: () {
                // Navigate to system settings
              },
            ),
            const Divider(),

            // General Settings Section
            ListTile(
              title: const Text('General Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Navigate to general settings
              },
            ),
            const Divider(),

            // Backup & Data Section
            ListTile(
              title: const Text('Backup & Data'),
              leading: const Icon(Icons.cloud_upload),
              onTap: () {
                // Navigate to backup and data settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
