import 'dart:math';
import '../data/models/attendanceModel/staff_attendance_model.dart'; // Your Staff Attendance Model

class StaffAttendanceService {
  List<StaffAttendanceModel> _staffAttendanceData = [];

  // List of departments for staff (you can define this as per your requirement)
  List<String> availableDepartments = ['HR', 'Sales', 'IT', 'Admin', 'Finance'];

  // Mock staff attendance data generation
  StaffAttendanceService() {
    // Generate mock attendance data when the service is initialized
    _staffAttendanceData = generateMockStaffData();
  }

  // Method to generate mock staff data
  List<StaffAttendanceModel> generateMockStaffData() {
    Random rand = Random();
    List<StaffAttendanceModel> attendanceData = [];
    DateTime startDate = DateTime(2025, 1, 1);
    DateTime endDate = DateTime(2025, 3, 31); // Generate data for 3 months
    final List<String> staffMembers = [
      'Alice Johnson',
      'Bob Brown',
      'Clara White',
      'Daniel Black',
      'Eve Green',
    ];

    // Generate attendance for each staff member
    for (String staffName in staffMembers) {
      for (DateTime date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
        bool isPresent = rand.nextBool();
        bool isOnLeave = rand.nextBool();
        if (isOnLeave) isPresent = false; // If on leave, the staff member is not present

        String departmentId = availableDepartments[rand.nextInt(availableDepartments.length)];

        attendanceData.add(StaffAttendanceModel(
          staffId: 'A${rand.nextInt(100)}',
          staffName: staffName,
          date: date,
          isPresent: isPresent,
          isOnLeave: isOnLeave,
          departmentId: departmentId,
        ));
      }
    }

    return attendanceData;
  }

  // Get all staff attendance records
  List<StaffAttendanceModel> getAllStaffAttendance() {
    return _staffAttendanceData;
  }

  // Get staff attendance filtered by department
  List<StaffAttendanceModel> getStaffAttendanceByDepartment(String departmentId) {
    return _staffAttendanceData.where((attendance) => attendance.departmentId == departmentId).toList();
  }

  // Get all attendance records by date (for filtering by date)
  List<StaffAttendanceModel> getStaffAttendanceByDate(DateTime date) {
    return _staffAttendanceData.where((attendance) => attendance.date.isAtSameMomentAs(date)).toList();
  }

  // Add or update staff attendance
  void addOrUpdateStaffAttendance(StaffAttendanceModel attendance) {
    int index = _staffAttendanceData.indexWhere((existingAttendance) =>
    existingAttendance.staffId == attendance.staffId &&
        existingAttendance.date == attendance.date,
    );

    if (index >= 0) {
      _staffAttendanceData[index] = attendance;
    } else {
      _staffAttendanceData.add(attendance);
    }
  }

  // Delete staff attendance record
  void deleteStaffAttendance(String staffId, DateTime date) {
    _staffAttendanceData.removeWhere((attendance) =>
    attendance.staffId == staffId && attendance.date.isAtSameMomentAs(date));
  }

  // Attendance summary for a specific department (staff)
  Map<String, int> getStaffAttendanceSummary(String departmentId) {
    List<StaffAttendanceModel> filteredAttendance = getStaffAttendanceByDepartment(departmentId);
    int present = 0, absent = 0, onLeave = 0;

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

  // Filter staff attendance by date range (e.g. startDate to endDate)
  List<StaffAttendanceModel> getStaffAttendanceByDateRange(DateTime startDate, DateTime endDate) {
    return _staffAttendanceData.where((attendance) {
      return attendance.date.isAfter(startDate.subtract(Duration(days: 1))) && attendance.date.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  // Get attendance summary for all departments (global summary)
  Map<String, Map<String, int>> getGlobalAttendanceSummary() {
    Map<String, Map<String, int>> globalSummary = {};

    for (var department in availableDepartments) {
      globalSummary[department] = getStaffAttendanceSummary(department);
    }
    return globalSummary;
  }
}
