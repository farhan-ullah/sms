// // import 'package:flutter/material.dart';
// //
// // class ExamRegistration {
// //   String registrationID; // Unique ID for the registration
// //   String studentID; // Student ID who is registering for the examModel
// //   String examID; // Exam ID for the examModel being registered
// //   DateTime registrationDate; // Date when the registration was made
// //   DateTime examTime; // Date and time when the examModel is scheduled
// //   String status; // Registration status (e.g., 'Registered', 'Pending', 'Cancelled')
// //
// //   // Constructor to initialize all fields
// //   ExamRegistration({
// //     required this.registrationID,
// //     required this.studentID,
// //     required this.examID,
// //     required this.registrationDate,
// //     required this.examTime,
// //     required this.status,
// //   });
// //
// //   // Factory constructor to create an instance from a JSON map
// //   factory ExamRegistration.fromJson(Map<String, dynamic> json) {
// //     return ExamRegistration(
// //       registrationID: json['registrationID'],
// //       studentID: json['studentID'],
// //       examID: json['examID'],
// //       registrationDate: DateTime.parse(json['registrationDate']),
// //       examTime: DateTime.parse(json['examTime']),
// //       status: json['status'],
// //     );
// //   }
// //
// //   // Method to convert this object into a JSON map
// //   Map<String, dynamic> toJson() {
// //     return {
// //       'registrationID': registrationID,
// //       'studentID': studentID,
// //       'examID': examID,
// //       'registrationDate': registrationDate.toIso8601String(),
// //       'examTime': examTime.toIso8601String(),
// //       'status': status,
// //     };
// //   }
// //
// //   @override
// //   String toString() {
// //     return 'ExamRegistration(registrationID: $registrationID, studentID: $studentID, examID: $examID, registrationDate: $registrationDate, examTime: $examTime, status: $status)';
// //   }
// // }
// //
// //
// //
// // void main() {
// //   runApp(ExamRegistrationApp());
// // }
// //
// // class ExamRegistrationApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Exam Registration',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: ExamRegistrationScreen(),
// //     );
// //   }
// // }
// //
// // class ExamRegistrationScreen extends StatefulWidget {
// //   @override
// //   _ExamRegistrationScreenState createState() => _ExamRegistrationScreenState();
// // }
// //
// // class _ExamRegistrationScreenState extends State<ExamRegistrationScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _studentIDController = TextEditingController();
// //   final TextEditingController _examIDController = TextEditingController();
// //   final TextEditingController _examTimeController = TextEditingController();
// //   String _status = 'Registered';
// //
// //   // Sample exams list
// //   List<String> exams = ['EX123', 'EX124', 'EX125', 'EX126', 'EX127'];
// //
// //   // Registration Type (Bulk, Class-based, Custom)
// //   String _registrationType = 'Custom';
// //
// //   // Student List (for bulk registration or class registration)
// //   List<String> studentList = ['STU001', 'STU002', 'STU003', 'STU004', 'STU005'];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Exam Registration'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               // Title
// //               Text(
// //                 'Register for an Exam',
// //                 style: Theme.of(context).textTheme.headlineLarge,
// //                 textAlign: TextAlign.center,
// //               ),
// //               SizedBox(height: 20),
// //
// //               // Exam Selection (Dropdown)
// //               DropdownButtonFormField<String>(
// //                 decoration: InputDecoration(
// //                   labelText: 'Select Exam',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 value: exams[0], // Default value
// //                 onChanged: (newValue) {
// //                   setState(() {
// //                     _examIDController.text = newValue!;
// //                   });
// //                 },
// //                 items: exams
// //                     .map((examModel) => DropdownMenuItem<String>(
// //                   value: examModel,
// //                   child: Text(examModel),
// //                 ))
// //                     .toList(),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please select an examModel';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 16),
// //
// //               // Registration Type (Radio or Dropdown)
// //               Row(
// //                 children: [
// //                   Text('Select Registration Type:'),
// //                   Radio<String>(
// //                     value: 'Bulk',
// //                     groupValue: _registrationType,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _registrationType = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Bulk'),
// //                   Radio<String>(
// //                     value: 'Class',
// //                     groupValue: _registrationType,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _registrationType = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Class-based'),
// //                   Radio<String>(
// //                     value: 'Custom',
// //                     groupValue: _registrationType,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _registrationType = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Custom'),
// //                 ],
// //               ),
// //               SizedBox(height: 16),
// //
// //               // Conditional Input based on Registration Type
// //               if (_registrationType == 'Custom') ...[
// //                 // Custom Registration (Student ID)
// //                 TextFormField(
// //                   controller: _studentIDController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Student ID',
// //                     hintText: 'Enter student ID',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a student ID';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 16),
// //               ],
// //               if (_registrationType != 'Custom') ...[
// //                 // Bulk/Class Registration (List of Students or Class Name)
// //                 DropdownButtonFormField<String>(
// //                   decoration: InputDecoration(
// //                     labelText: _registrationType == 'Bulk'
// //                         ? 'Select Students'
// //                         : 'Select Class',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   onChanged: (newValue) {
// //                     setState(() {
// //                       // handle selection
// //                     });
// //                   },
// //                   items: studentList
// //                       .map((student) => DropdownMenuItem<String>(
// //                     value: student,
// //                     child: Text(student),
// //                   ))
// //                       .toList(),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please select a student or class';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 16),
// //               ],
// //
// //               // Exam Time (Date and Time)
// //               TextFormField(
// //                 controller: _examTimeController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Exam Time',
// //                   hintText: 'Enter examModel time (e.g., 2023-11-15 09:00)',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a valid examModel time';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 16),
// //
// //               // Status (Radio Button or Dropdown)
// //               Row(
// //                 children: [
// //                   Text('Status:'),
// //                   Radio<String>(
// //                     value: 'Registered',
// //                     groupValue: _status,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _status = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Registered'),
// //                   Radio<String>(
// //                     value: 'Pending',
// //                     groupValue: _status,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _status = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Pending'),
// //                   Radio<String>(
// //                     value: 'Cancelled',
// //                     groupValue: _status,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _status = value!;
// //                       });
// //                     },
// //                   ),
// //                   Text('Cancelled'),
// //                 ],
// //               ),
// //               SizedBox(height: 16),
// //
// //               // Register Button
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     // Registration logic
// //                     final registration = ExamRegistration(
// //                       registrationID: 'REG${DateTime.now().millisecondsSinceEpoch}',
// //                       studentID: _studentIDController.text.isNotEmpty
// //                           ? _studentIDController.text
// //                           : 'Bulk or Class-based Registration',
// //                       examID: _examIDController.text,
// //                       registrationDate: DateTime.now(),
// //                       examTime: DateTime.parse(_examTimeController.text),
// //                       status: _status,
// //                     );
// //
// //                     // Show success message
// //                     showDialog(
// //                       context: context,
// //                       builder: (_) => AlertDialog(
// //                         title: Text('Registration Successful'),
// //                         content: Text(
// //                             'Registration successful for examModel ${registration.examID}.'),
// //                         actions: [
// //                           TextButton(
// //                             onPressed: () {
// //                               Navigator.pop(context);
// //                             },
// //                             child: Text('OK'),
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //
// //                     // Reset form after registration
// //                     _formKey.currentState!.reset();
// //                   }
// //                 },
// //                 child: Text('Register'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// import 'package:flutter/material.dart';
// import 'package:school/data/models/examModel/exam_model.dart';
// import 'package:school/ui/presentation/new_widgets/custom_text_field.dart';
//
// class UnderDevelopmentExam extends StatefulWidget {
//   const UnderDevelopmentExam({super.key});
//
//   @override
//   State<UnderDevelopmentExam> createState() => _UnderDevelopmentExamState();
// }
//
// class _UnderDevelopmentExamState extends State<UnderDevelopmentExam> {
//   final TextEditingController _examNameController = TextEditingController();
//   final TextEditingController _examDetailsController = TextEditingController();
//
//   final TextEditingController _examIdController = TextEditingController();
//   final TextEditingController _examDateController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CustomTextfield(
//             labelText: "Exam Name",
//             controller: _examNameController,
//           ),
//           CustomTextfield(
//             labelText: "Exam ID",
//             controller: _examNameController,
//           ),
//           CustomTextfield(
//             labelText: "Exam Date",
//             controller: _examDateController,
//           ),
//           CustomTextfield(
//             labelText: "Exam Details",
//             controller: _examDetailsController,
//           ),
//
//           //
//           ElevatedButton(
//             onPressed: () {
//               final examData = ExamModel(
//                 examId: _examIdController.text,
//                 examName: _examNameController.text,
//                 examDate: _examDateController.text,
//                 examDescription: _examDetailsController.text,
//               );
//             },
//             child: Text("Submit"),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ExamRegistrationScreen extends StatefulWidget {
  const ExamRegistrationScreen({super.key});

  @override
  State<ExamRegistrationScreen> createState() => _ExamRegistrationScreenState();
}

class _ExamRegistrationScreenState extends State<ExamRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Under Development Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),);
  }
}

