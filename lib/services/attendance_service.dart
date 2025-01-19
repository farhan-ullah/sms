import 'dart:math';
import '../data/models/attendanceModel/student_attendance_model.dart'; // Import the model

class AttendanceService {
  List<StudentAttendanceModel> _attendanceData = [];

  // List of classes (you can define this as per your requirement)
  List<String> availableClasses = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];

  // Mock attendance data with 'classId' added directly to each record
  AttendanceService() {
    // Generate mock attendance data when the service is initialized
    _attendanceData = generateMockData();
  }

  // Method to generate mock data
  List<StudentAttendanceModel> generateMockData() {
    Random rand = Random();
    List<StudentAttendanceModel> attendanceData = [];
    DateTime startDate = DateTime(2025, 1, 1);
    DateTime endDate = DateTime(2025, 3, 31); // Generate data for 3 months
    final List<String> classes = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];

    final List<String> students = [
      'John Doe',
      'Jane Smith',
      'Alice Brown',
      'Bob White',
      'Charlie Black',
      'Eve Green',
      'Dave Blue',
      'Grace Yellow',
      'Oscar Red',
      'Lily Pink',
    ];

    // Generate attendance for each student
    for (String studentName in students) {
      for (DateTime date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
        // Randomly decide if the student is present, absent, or on leave
        bool isPresent = rand.nextBool(); // Randomly true or false
        bool isOnLeave = rand.nextBool(); // Randomly true or false
        if (isOnLeave) isPresent = false; // If on leave, the student is not present

        // Randomly assign classId (can be for multiple classes per student)
        String classId = classes[rand.nextInt(classes.length)];

        // Add an attendance record for this student on this date
        attendanceData.add(StudentAttendanceModel(
          studentId: 'S${rand.nextInt(100)}', // Random studentId
          studentName: studentName,
          date: date,
          isPresent: isPresent,
          isOnLeave: isOnLeave,
          classId: classId,
        ));
      }
    }

    return attendanceData;
  }

  // Add classID to an Attendance record based on studentId and date (simple logic for class assignment)
  String _getClassByStudent(String studentId, DateTime date) {
    // Simple logic for determining class by student (this can be modified as needed)
    if (studentId == 'S1') return 'Class 1';
    if (studentId == 'S2') return 'Class 1';
    if (studentId == 'S3') return 'Class 2';

    return 'Class 3'; // Default if no class found
  }

  // Get attendance filtered by class
  List<StudentAttendanceModel> getAttendanceByClass(String classID) {
    return _attendanceData.where((attendance) {
      // Get classID dynamically
      String studentClassID = _getClassByStudent(attendance.studentId, attendance.date);
      return studentClassID == classID;
    }).toList();
  }

  // Get all attendance records (all classes)
  List<StudentAttendanceModel> getAllAttendance() {
    return _attendanceData;
  }

  // Add or update attendance
  void addOrUpdateAttendance(StudentAttendanceModel attendance) {
    // Assign classId dynamically before adding or updating
    String assignedClassId = _getClassByStudent(attendance.studentId, attendance.date);

    int index = _attendanceData.indexWhere(
          (existingAttendance) =>
      existingAttendance.studentId == attendance.studentId &&
          existingAttendance.date == attendance.date,
    );

    if (index >= 0) {
      // Update existing record with new classId if necessary
      _attendanceData[index] = StudentAttendanceModel(
        studentId: attendance.studentId,
        studentName: attendance.studentName,
        date: attendance.date,
        isPresent: attendance.isPresent,
        isOnLeave: attendance.isOnLeave,
        classId: assignedClassId, // Add classId to updated record
      );
    } else {
      // Add new record with classId
      _attendanceData.add(StudentAttendanceModel(
        studentId: attendance.studentId,
        studentName: attendance.studentName,
        date: attendance.date,
        isPresent: attendance.isPresent,
        isOnLeave: attendance.isOnLeave,
        classId: assignedClassId, // Add classId to new record
      ));
    }
  }

  // Attendance summary for a specific class
  Map<String, int> getAttendanceSummary(String classID) {
    List<StudentAttendanceModel> filteredAttendance = getAttendanceByClass(classID);

    int present = 0;
    int absent = 0;
    int onLeave = 0;

    for (var record in filteredAttendance) {
      if (record.isPresent) present++;
      if (!record.isPresent && !record.isOnLeave) absent++;
      if (record.isOnLeave) onLeave++;
    }

    return {
      'Present': present,
      'Absent': absent,
      'On Leave': onLeave,
    };
  }
}
