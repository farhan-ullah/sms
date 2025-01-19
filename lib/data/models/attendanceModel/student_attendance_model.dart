class StudentAttendanceModel {
  String studentId;
  String studentName;
  DateTime date;
  bool isPresent;
  bool isOnLeave; // Added for leave tracking
  String classId; // Added classId

  StudentAttendanceModel({
    required this.studentId,
    required this.studentName,
    required this.date,
    this.isPresent = false,
    this.isOnLeave = false, // Default to not on leave
    required this.classId,  // Added classId
  });

  // Factory to create from JSON
  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      studentId: json['studentId'],
      studentName: json['studentName'],
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'] ?? false,
      isOnLeave: json['isOnLeave'] ?? false,
      classId: json['classId'] ?? '', // Ensure classId is parsed from JSON
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'isOnLeave': isOnLeave,
      'classId': classId, // Include classId in the output
    };
  }
}
