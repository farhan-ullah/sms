import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationsEnabled = false;
  bool isDarkModeEnabled = false;
  bool isAutoBackupEnabled = false;
  bool isFingerprintEnabled = false;
  bool isBiometricAuthEnabled = false;
  double backupFrequency = 30.0;  // in minutes
  String username = "John Doe";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView(
          children: [
            // General Settings Section
            _buildSectionHeader('General Settings'),
            const Divider(),
            _buildListTile(
              icon: Icons.person,
              title: 'Username',
              subtitle: username,
              onTap: () {
                _showEditUsernameDialog();
              },
            ),
            const Divider(),

            // Communication Settings Section
            _buildSectionHeader('Communication Settings'),
            const Divider(),
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'Enable Notifications',
              value: isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
            ),
            const Divider(),

            // Privacy & Security Settings Section
            _buildSectionHeader('Privacy & Security'),
            const Divider(),
            _buildSwitchTile(
              icon: Icons.fingerprint,
              title: 'Enable Fingerprint Authentication',
              value: isFingerprintEnabled,
              onChanged: (value) {
                setState(() {
                  isFingerprintEnabled = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.lock,
              title: 'Enable Biometric Authentication',
              value: isBiometricAuthEnabled,
              onChanged: (value) {
                setState(() {
                  isBiometricAuthEnabled = value;
                });
              },
            ),
            const Divider(),

            // Preferences Section
            _buildSectionHeader('Preferences'),
            const Divider(),
            _buildSwitchTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                });
              },
            ),
            const Divider(),
            _buildSwitchTile(
              icon: Icons.cloud_upload,
              title: 'Enable Auto Backup',
              value: isAutoBackupEnabled,
              onChanged: (value) {
                setState(() {
                  isAutoBackupEnabled = value;
                });
              },
            ),
            const Divider(),
            _buildSliderTile(
              icon: Icons.timer,
              title: 'Backup Frequency (min)',
              value: backupFrequency,
              onChanged: (value) {
                setState(() {
                  backupFrequency = value;
                });
              },
            ),
            const Divider(),

            // Advanced Settings Section
            _buildSectionHeader('Advanced Settings'),
            const Divider(),
            _buildListTile(
              icon: Icons.cloud,
              title: 'Backup & Data',
              subtitle: "Backup data now",
              onTap: () {
                // Implement backup functionality here
                _showBackupConfirmationDialog();
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  // Helper Method to Build ListTile
  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: subtitle != null
            ? Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12.0))
            : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
        onTap: onTap,
      ),
    );
  }

  // Helper Method to Build SwitchListTile
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ),
    );
  }

  // Helper Method to Build SliderListTile for backup frequency
  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: SizedBox(
          width: 100,
          child: Slider(
            value: value,
            min: 5.0,
            max: 120.0,
            divisions: 23,
            label: '${value.toInt()} min',
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  // Helper Method to Build Section Header
  Widget _buildSectionHeader(String sectionTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        sectionTitle,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Dialog to Edit Username
  void _showEditUsernameDialog() {
    TextEditingController usernameController = TextEditingController(text: username);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  username = usernameController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to Confirm Backup
  void _showBackupConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Backup Data'),
          content: const Text('Are you sure you want to backup your data now?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement your backup logic here
                Navigator.of(context).pop();
                _showBackupSuccessDialog();
              },
              child: const Text('Backup'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to Show Backup Success
  void _showBackupSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Backup Complete'),
          content: const Text('Your data has been successfully backed up!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
