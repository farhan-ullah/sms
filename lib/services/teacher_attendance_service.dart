import 'dart:math';
import '../data/models/attendanceModel/teacher_attendance_model.dart'; // Import the TeacherAttendanceModel

class TeacherAttendanceService {
  List<TeacherAttendanceModel> _attendanceData = [];

  // Mock list of departments (can be expanded as needed)
  List<String> availableDepartments = ['Math', 'Science', 'English', 'History'];

  // Constructor to generate some mock data
  TeacherAttendanceService() {
    _attendanceData = generateMockData();
  }

  // Method to generate mock data for teacher attendance (for testing purposes)
  List<TeacherAttendanceModel> generateMockData() {
    Random rand = Random();
    List<TeacherAttendanceModel> attendanceData = [];
    DateTime startDate = DateTime(2025, 1, 1);
    DateTime endDate = DateTime(2025, 3, 31); // Generate data for 3 months
    final List<String> teachers = [
      'Mr. Smith',
      'Ms. Johnson',
      'Mrs. Brown',
      'Mr. White',
      'Ms. Green',
    ];

    final List<String> departments = availableDepartments;

    // Generate attendance for each teacher
    for (String teacherName in teachers) {
      for (DateTime date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
        // Randomly decide if the teacher is present, absent, or on leave
        bool isPresent = rand.nextBool(); // Randomly true or false
        bool isOnLeave = rand.nextBool(); // Randomly true or false
        if (isOnLeave) isPresent = false; // If on leave, the teacher is not present

        // Randomly assign departmentId (can be for multiple departments per teacher)
        String departmentId = departments[rand.nextInt(departments.length)];

        // Add an attendance record for this teacher on this date
        attendanceData.add(TeacherAttendanceModel(
          teacherId: 'T${rand.nextInt(100)}', // Random teacherId
          teacherName: teacherName,
          date: date,
          isPresent: isPresent,
          isOnLeave: isOnLeave,
          subjectId: departmentId,  // Using departmentId as subjectId here
        ));
      }
    }

    return attendanceData;
  }

  // Method to add or update attendance for a teacher
  void addOrUpdateTeacherAttendance(TeacherAttendanceModel attendance) {
    int index = _attendanceData.indexWhere(
          (existingAttendance) =>
      existingAttendance.teacherId == attendance.teacherId &&
          existingAttendance.date == attendance.date,
    );

    if (index >= 0) {
      // Update existing record
      _attendanceData[index] = attendance;
    } else {
      // Add new record
      _attendanceData.add(attendance);
    }
  }

  // Method to get all teacher attendance records
  List<TeacherAttendanceModel> getAllTeacherAttendance() {
    return _attendanceData;
  }

  // Method to get teacher attendance filtered by department
  List<TeacherAttendanceModel> getTeacherAttendanceByDepartment(String departmentId) {
    return _attendanceData.where((attendance) {
      return attendance.subjectId == departmentId;
    }).toList();
  }

  // Method to get attendance summary (present, absent, on leave) for a specific department
  Map<String, int> getAttendanceSummaryByDepartment(String departmentId) {
    List<TeacherAttendanceModel> filteredAttendance = getTeacherAttendanceByDepartment(departmentId);

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
