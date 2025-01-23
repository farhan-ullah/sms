class ExamResult {
  String examID;
  String subjectID;
  String studentID;
  int marksObtained;
  String grade;
  DateTime examDate; // Additional field for the examModel date
  int totalMarks; // Total marks available for the examModel
  String teacherID; // Teacher ID associated with the examModel

  // Constructor with required fields, including totalMarks and teacherID
  ExamResult({
    required this.examID,
    required this.subjectID,
    required this.studentID,
    required this.marksObtained,
    required this.grade,
    required this.examDate,
    required this.totalMarks,
    required this.teacherID,
  });

  // Factory constructor to create an instance from a JSON map
  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      examID: json['examID'],
      subjectID: json['subjectID'],
      studentID: json['studentID'],
      marksObtained: json['marksObtained'],
      grade: json['grade'],
      examDate: DateTime.parse(json['examDate']),
      totalMarks: json['totalMarks'], // Added mapping for totalMarks
      teacherID: json['teacherID'], // Added mapping for teacherID
    );
  }

  // Method to convert this object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'examID': examID,
      'subjectID': subjectID,
      'studentID': studentID,
      'marksObtained': marksObtained,
      'grade': grade,
      'examDate': examDate.toIso8601String(),
      'totalMarks': totalMarks, // Added totalMarks to the JSON
      'teacherID': teacherID, // Added teacherID to the JSON
    };
  }

  // Method to calculate the grade based on marks (assuming a typical grading scale)
  String calculateGrade() {
    if (marksObtained >= 90) {
      return 'A';
    } else if (marksObtained >= 80) {
      return 'B';
    } else if (marksObtained >= 70) {
      return 'C';
    } else if (marksObtained >= 60) {
      return 'D';
    } else {
      return 'F';
    }
  }

  // Method to check if the examModel result is valid (example validation based on marks)
  bool isValidResult() {
    return marksObtained >= 0 && marksObtained <= totalMarks;
  }

  @override
  String toString() {
    return 'ExamResult(examID: $examID, subjectID: $subjectID, studentID: $studentID, marksObtained: $marksObtained, grade: $grade, examDate: $examDate, totalMarks: $totalMarks, teacherID: $teacherID)';
  }
}
