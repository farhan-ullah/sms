class StaffAttendanceModel {
  String staffId;
  String staffName;
  DateTime date;
  bool isPresent;
  bool isOnLeave;  // For leave tracking
  String departmentId;  // Added departmentId to track which department the staff belongs to

  StaffAttendanceModel({
    required this.staffId,
    required this.staffName,
    required this.date,
    this.isPresent = false,
    this.isOnLeave = false, // Default to not on leave
    required this.departmentId,  // Ensure departmentId is passed in the constructor
  });

  // Factory to create from JSON
  factory StaffAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StaffAttendanceModel(
      staffId: json['staffId'],
      staffName: json['staffName'],
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'] ?? false,
      isOnLeave: json['isOnLeave'] ?? false,
      departmentId: json['departmentId'], // Ensure departmentId is parsed from JSON
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'staffId': staffId,
      'staffName': staffName,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'isOnLeave': isOnLeave,
      'departmentId': departmentId,  // Include departmentId in the output JSON
    };
  }
}
