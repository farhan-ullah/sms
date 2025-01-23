// import 'package:flutter/material.dart';
//
// import 'mock_data.dart';  // Assuming mock data exists for subjects and students
//
// class ExamRegistrationScreen extends StatefulWidget {
//   ExamRegistrationScreen();
//
//   @override
//   _ExamRegistrationScreenState createState() => _ExamRegistrationScreenState();
// }
//
// class _ExamRegistrationScreenState extends State<ExamRegistrationScreen> {
//   // Controller for search bar
//   TextEditingController searchController = TextEditingController();
//
//   // List of subjects available for registration
//   List<SubjectModel> subjects = mockSubjects;
//
//   // A set to track selected subjects
//   Set<String> selectedSubjects = {};
//
//   // Function to filter subjects based on search query
//   void _filterSubjects(String query) {
//     setState(() {
//       subjects = mockSubjects
//           .where((subject) =>
//       subject.subjectName!.toLowerCase().contains(query.toLowerCase()) ||
//           subject.subjectID!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   // Function to handle the registration submission
//   void _submitRegistration() {
//     if (selectedSubjects.isEmpty) {
//       // Show a warning if no subject is selected
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select at least one subject to register.')),
//       );
//     } else {
//       // Show a confirmation dialog before finalizing the registration
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Confirm Registration'),
//             content: Text(
//                 'You are about to register for the following subjects: \n\n${selectedSubjects.join(', ')}'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Confirm registration and close the dialog
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Registration successful!')),
//                   );
//                   Navigator.pop(context);
//                 },
//                 child: Text('Confirm'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Cancel the registration and close the dialog
//                   Navigator.pop(context);
//                 },
//                 child: Text('Cancel'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exam Registration'),
//       ),
//       body: Column(
//         children: [
//           // Search bar to filter subjects
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: _filterSubjects,
//               decoration: InputDecoration(
//                 labelText: 'Search Subjects',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           // List of subjects with checkboxes for registration
//           Expanded(
//             child: ListView.builder(
//               itemCount: subjects.length,
//               itemBuilder: (context, index) {
//                 final subject = subjects[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 4,
//                   child: ListTile(
//                     title: Text(subject.subjectName!),
//                     subtitle: Text('Subject ID: ${subject.subjectID}'),
//                     trailing: Checkbox(
//                       value: selectedSubjects.contains(subject.subjectID),
//                       onChanged: (bool? value) {
//                         setState(() {
//                           if (value == true) {
//                             selectedSubjects.add(subject.subjectID!);
//                           } else {
//                             selectedSubjects.remove(subject.subjectID!);
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _submitRegistration,
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }
//
// class SubjectModel {
//   String? subjectID;
//   String? subjectName;
//   String? teacherID;
//   String? classID;
//   String? teacherName;
//   String? className;
//
//   SubjectModel({
//     this.subjectID,
//     this.subjectName,
//     this.teacherID,
//     this.classID,
//     this.teacherName,
//     this.className,
//   });
// }
//
// // Mock Data for subjects (replace with your actual data source)
// List<SubjectModel> mockSubjects = [
//   SubjectModel(subjectID: 'SUB001', subjectName: 'Mathematics'),
//   SubjectModel(subjectID: 'SUB002', subjectName: 'Science'),
//   SubjectModel(subjectID: 'SUB003', subjectName: 'History'),
//   SubjectModel(subjectID: 'SUB004', subjectName: 'English'),
//   SubjectModel(subjectID: 'SUB005', subjectName: 'Geography'),
// ];
