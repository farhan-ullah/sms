class TeacherAttendanceModel {
  String teacherId;
  String teacherName;
  DateTime date;
  bool isPresent;
  bool isOnLeave;  // For leave tracking
  String subjectId;  // Added subjectId to track which subject the teacher is responsible for

  TeacherAttendanceModel({
    required this.teacherId,
    required this.teacherName,
    required this.date,
    this.isPresent = false,
    this.isOnLeave = false, // Default to not on leave
    required this.subjectId,  // Ensure subjectId is passed in the constructor
  });

  // Factory to create from JSON
  factory TeacherAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TeacherAttendanceModel(
      teacherId: json['teacherId'],
      teacherName: json['teacherName'],
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'] ?? false,
      isOnLeave: json['isOnLeave'] ?? false,
      subjectId: json['subjectId'], // Ensure subjectId is parsed from JSON
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'teacherId': teacherId,
      'teacherName': teacherName,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'isOnLeave': isOnLeave,
      'subjectId': subjectId,  // Include subjectId in the output JSON
    };
  }
}
