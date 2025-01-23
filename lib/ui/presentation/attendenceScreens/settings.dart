// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../businessLogic/providers/setting_provider.dart';
// import '../../../data/models/setting_model.dart';
//
// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   TextEditingController schoolNameController = TextEditingController();
//   TextEditingController schoolAddressController = TextEditingController();
//   TextEditingController schoolContactController = TextEditingController();
//   String? selectedTimezone;
//   String? selectedDateFormat;
//   String? selectedCurrency;
//   bool? isDarkMode;
//   bool? notificationsEnabled;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var settingsProvider = Provider.of<SettingsProvider>(context);
//     SchoolSettings settings = settingsProvider.settings;
//
//     schoolNameController.text = settings.schoolName;
//     schoolAddressController.text = settings.schoolAddress;
//     schoolContactController.text = settings.schoolContact;
//     selectedTimezone = settings.timezone;
//     selectedDateFormat = settings.dateFormat;
//     selectedCurrency = settings.currency;
//     isDarkMode = settings.isDarkMode;
//     notificationsEnabled = settings.notificationsEnabled;
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Settings'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.save),
//               onPressed: () {
//                 // Save the updated settings
//                 SchoolSettings updatedSettings = SchoolSettings(
//                   schoolName: schoolNameController.text,
//                   schoolAddress: schoolAddressController.text,
//                   schoolContact: schoolContactController.text,
//                   schoolLogoUrl: settings.schoolLogoUrl, // Assuming logo URL stays unchanged
//                   academicYear: settings.academicYear,
//                   timezone: selectedTimezone!,
//                   dateFormat: selectedDateFormat!,
//                   currency: selectedCurrency!,
//                   isDarkMode: isDarkMode!,
//                   notificationsEnabled: notificationsEnabled!,
//                 );
//                 settingsProvider.updateSettings(updatedSettings);
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings updated successfully')));
//               },
//             ),
//           ],
//         ),
//         body: ListView(
//             padding: EdgeInsets.all(16),
//             children: [
//               // General Settings Section
//               Text('General Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               TextField(
//                 controller: schoolNameController,
//                 decoration: InputDecoration(labelText: 'School Name'),
//               ),
//               TextField(
//                 controller: schoolAddressController,
//                 decoration: InputDecoration(labelText: 'School Address'),
//               ),
//               TextField(
//                 controller: schoolContactController,
//                 decoration: InputDecoration(labelText: 'Contact Number'),
//               ),
//               SizedBox(height: 20),
//
//               // System Settings Section
//               Text('System Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: selectedTimezone,
//                 decoration: InputDecoration(labelText: 'Timezone'),
//                 items: ['GMT', 'EST', 'PST', 'CET'].map((timezone) {
//                   return DropdownMenuItem(
//                     value: timezone,
//                     child: Text(timezone),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedTimezone = value;
//                   });
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: selectedDateFormat,
//                 decoration: InputDecoration(labelText: 'Date Format'),
//                 items: ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'].map((format) {
//                   return DropdownMenuItem(
//                     value: format,
//                     child: Text(format),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedDateFormat = value;
//                   });
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: selectedCurrency,
//                 decoration: InputDecoration(labelText: 'Currency'),
//                 items: ['USD', 'INR', 'EUR'].map((currency) {
//                   return DropdownMenuItem(
//                     value: currency,
//                     child: Text(currency),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//
//               // User Preferences Section
//               Text('User Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               SwitchListTile(
//                 title: Text('Enable Dark Mode'),
//                 value: isDarkMode!,
//                 onChanged: (bool value) {
//                   setState(() {
//                     isDarkMode = value;
//                   });
//                 },
//               ),
//               SwitchListTile(
//                 title: Text('Enable Notifications'),
//                 value: notificationsEnabled!,
//                 onChanged: (bool value) {
//                   setState(() {
//                     notificationsEnabled = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//
//               // Save Button
//               ElevatedButton(
//                 onPressed: () {
//                   SchoolSettings updatedSettings = SchoolSettings(
//                     schoolName: schoolNameController.text,
//                     schoolAddress: schoolAddressController.text,
//                     schoolContact: schoolContactController.text,
//                     schoolLogoUrl: settings.schoolLogoUrl,
//                     academicYear: settings.academicYear,
//                     timezone: selectedTimezone!,
//                     dateFormat: selectedDateFormat!,
//                     currency: selectedCurrency!,
//                     isDarkMode: isDarkMode!,
//                     notificationsEnabled: notificationsEnabled!,
//                   );
//                   settingsProvider.updateSettings(updatedSettings);
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings updated successfully')));
//                 },
//                 child: Text('Save Settings'),
//               ),
//             ],
//             ),
//         );
//     }
// }
