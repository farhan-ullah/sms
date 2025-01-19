// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:collection'; // For using UnmodifiableListView
//
// // Mock Attendance Model Class
// class AttendanceModel {
//   String studentId;
//   String studentName;
//   DateTime date;
//   bool isPresent;
//   bool isOnLeave; // Added for leave tracking
//
//   AttendanceModel({
//     required this.studentId,
//     required this.studentName,
//     required this.date,
//     this.isPresent = false,
//     this.isOnLeave = false, // Default to not on leave
//   });
//
//   // Factory to create from JSON
//   factory AttendanceModel.fromJson(Map<String, dynamic> json) {
//     return AttendanceModel(
//       studentId: json['studentId'],
//       studentName: json['studentName'],
//       date: DateTime.parse(json['date']),
//       isPresent: json['isPresent'] ?? false,
//       isOnLeave: json['isOnLeave'] ?? false,
//     );
//   }
//
//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'studentId': studentId,
//       'studentName': studentName,
//       'date': date.toIso8601String(),
//       'isPresent': isPresent,
//       'isOnLeave': isOnLeave,
//     };
//   }
// }
//
// // Mock data for Students
// class Student {
//   String studentId;
//   String studentName;
//
//   Student({required this.studentId, required this.studentName});
// }
//
// // Mock data for Attendance
// class AttendanceProvider extends ChangeNotifier {
//   // Mocked student and attendance data
//   final List<Student> _students = [
//     Student(studentId: "S001", studentName: "John Doe"),
//     Student(studentId: "S002", studentName: "Jane Smith"),
//     Student(studentId: "S003", studentName: "Alice Johnson"),
//     Student(studentId: "S004", studentName: "Bob Lee"),
//   ];
//
//   final List<AttendanceModel> _attendanceRecords = [
//     AttendanceModel(
//         studentId: "S001",
//         studentName: "John Doe",
//         date: DateTime(2025, 1, 17),
//         isPresent: true),
//     AttendanceModel(
//         studentId: "S002",
//         studentName: "Jane Smith",
//         date: DateTime(2025, 1, 17),
//         isPresent: false),
//     AttendanceModel(
//         studentId: "S003",
//         studentName: "Alice Johnson",
//         date: DateTime(2025, 1, 17),
//         isOnLeave: true),
//   ];
//
//   // Get student IDs from the mock students list
//   List<String> getStudentIds() {
//     return _students.map((student) => student.studentId).toList();
//   }
//
//   // Generate attendance for all students on a given date
//   void generateAttendanceForAllStudents(List<String> studentIds, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     // Check if attendance already exists for the class on the given date
//     bool attendanceExists = _attendanceRecords.any((attendance) =>
//     attendance.date == attendanceDate &&
//         studentIds.contains(attendance.studentId));
//
//     // If attendance does not exist, add new attendance for all students
//     if (!attendanceExists) {
//       for (var studentId in studentIds) {
//         _attendanceRecords.add(AttendanceModel(
//           studentId: studentId,
//           studentName: _students.firstWhere((student) => student.studentId == studentId).studentName,
//           date: attendanceDate,
//           isPresent: false, // Default to false for all students
//         ));
//       }
//     }
//     notifyListeners();
//   }
//
//   // Generate Attendance for all students in a class
//   void generateAttendanceForClass(List<String> studentIds, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     for (var studentId in studentIds) {
//       if (!_attendanceRecords.any((attendance) =>
//       attendance.date == attendanceDate &&
//           attendance.studentId == studentId)) {
//         _attendanceRecords.add(AttendanceModel(
//           studentId: studentId,
//           studentName: _students.firstWhere((student) => student.studentId == studentId).studentName,
//           date: attendanceDate,
//           isPresent: false,
//         ));
//       }
//     }
//     notifyListeners();
//   }
//
//   // Fetch student's attendance status for a class on a particular date
//   String getAttendanceStatus(String studentId, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     var attendance = _attendanceRecords.firstWhere(
//           (attendance) =>
//       attendance.studentId == studentId && attendance.date == attendanceDate,
//       orElse: () => AttendanceModel(
//         studentId: studentId,
//         studentName: "",
//         date: attendanceDate,
//         isPresent: false,
//         isOnLeave: false,
//       ),
//     );
//
//     if (attendance.isPresent) return "Present";
//     if (attendance.isOnLeave) return "Leave";
//     return "Absent";
//   }
//
//   // Mark a student as Present for a specific class on a specific date
//   void markStudentPresent(String studentId, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     var attendance = _attendanceRecords.firstWhere(
//           (attendance) =>
//       attendance.studentId == studentId && attendance.date == attendanceDate,
//       orElse: () => AttendanceModel(
//         studentId: studentId,
//         studentName: "",
//         date: attendanceDate,
//         isPresent: false,
//         isOnLeave: false,
//       ),
//     );
//
//     attendance.isPresent = true;
//     attendance.isOnLeave = false; // Mark as not on leave
//     notifyListeners();
//   }
//
//   // Mark a student as Absent for a specific class on a specific date
//   void markStudentAbsent(String studentId, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     var attendance = _attendanceRecords.firstWhere(
//           (attendance) =>
//       attendance.studentId == studentId && attendance.date == attendanceDate,
//       orElse: () => AttendanceModel(
//         studentId: studentId,
//         studentName: "",
//         date: attendanceDate,
//         isPresent: false,
//         isOnLeave: false,
//       ),
//     );
//
//     attendance.isPresent = false;
//     attendance.isOnLeave = false;
//     notifyListeners();
//   }
//
//   // Mark a student as Leave for a specific class on a specific date
//   void markStudentLeave(String studentId, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     var attendance = _attendanceRecords.firstWhere(
//           (attendance) =>
//       attendance.studentId == studentId && attendance.date == attendanceDate,
//       orElse: () => AttendanceModel(
//         studentId: studentId,
//         studentName: "",
//         date: attendanceDate,
//         isPresent: false,
//         isOnLeave: false,
//       ),
//     );
//
//     attendance.isOnLeave = true;
//     attendance.isPresent = false;
//     notifyListeners();
//   }
//
//   // Reset student's attendance status for a given class and date
//   void resetStudentAttendance(String studentId, String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//
//     var attendance = _attendanceRecords.firstWhere(
//           (attendance) =>
//       attendance.studentId == studentId && attendance.date == attendanceDate,
//       orElse: () => AttendanceModel(
//         studentId: studentId,
//         studentName: "",
//         date: attendanceDate,
//         isPresent: false,
//         isOnLeave: false,
//       ),
//     );
//
//     attendance.isPresent = false;
//     attendance.isOnLeave = false;
//     notifyListeners();
//   }
//
//   // Get all attendance records for a class on a particular date
//   List<String> getAllStudentAttendanceForClass(String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//     var attendanceForDate = _attendanceRecords
//         .where((attendance) => attendance.date == attendanceDate)
//         .toList();
//
//     return attendanceForDate.map((attendance) => attendance.studentId).toList();
//   }
//
//   // Get a list of all students' attendance statuses in a class for a specific date
//   Map<String, String> getClassAttendanceForDate(String date) {
//     DateTime attendanceDate = DateFormat('yyyy-MM-dd').parse(date);
//     var attendanceForDate = _attendanceRecords
//         .where((attendance) => attendance.date == attendanceDate)
//         .toList();
//
//     // Create a map with studentId and their status
//     Map<String, String> attendanceMap = {};
//     for (var attendance in attendanceForDate) {
//       if (attendance.isPresent) {
//         attendanceMap[attendance.studentId] = "Present";
//       } else if (attendance.isOnLeave) {
//         attendanceMap[attendance.studentId] = "Leave";
//       } else {
//         attendanceMap[attendance.studentId] = "Absent";
//       }
//     }
//
//     return attendanceMap;
//   }
//
//   // Return a list of students for the mock data
//   List<Student> getAllStudents() {
//     return UnmodifiableListView(_students);
//   }
// }
