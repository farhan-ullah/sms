import 'package:flutter/material.dart';
import '../../data/models/setting_model.dart';


class SettingsProvider extends ChangeNotifier {
  SchoolSettings _settings = SchoolSettings(
    schoolName: 'Greenfield School',
    schoolAddress: '123 School Lane, Cityville, State',
    schoolContact: '+1234567890',
    schoolLogoUrl: 'https://example.com/logo.png',
    academicYear: '2024-2025',
    timezone: 'GMT',
    dateFormat: 'DD/MM/YYYY',
    currency: 'USD',
    isDarkMode: false,
    notificationsEnabled: true,
  );

  SchoolSettings get settings => _settings;

  // Method to update the settings
  void updateSettings(SchoolSettings updatedSettings) {
    _settings = updatedSettings;
    notifyListeners();
  }
}
