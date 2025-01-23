class PaperModel {
  String paperName;
  String subjectId;
  double? totalMarks;
  double? obtainedMarks;
  String? grade;
  bool? isPassed;
  String? studentID;
  String? studentName;  // New field for student name

  // Constructor
  PaperModel({
    this.studentID,
    this.studentName,  // Initialize student name
    required this.paperName,
    required this.subjectId,
    this.totalMarks,
    this.obtainedMarks,
    this.grade,
    this.isPassed,
  });

  // Method to display paper details
  String getPaperDetails() {
    return 'Paper: $paperName, Subject ID: $subjectId, Total Marks: $totalMarks, Obtained Marks: $obtainedMarks, Grade: $grade, Passed: ${isPassed ?? "Unknown"}';
  }

  // Method to calculate grade based on obtained marks
  void calculateGrade() {
    if (totalMarks == null || obtainedMarks == null) {
      grade = 'Not Available';
      return;
    }
    double percentage = (obtainedMarks! / totalMarks!) * 100;
    if (percentage >= 90) {
      grade = 'A';
    } else if (percentage >= 80) {
      grade = 'B';
    } else if (percentage >= 70) {
      grade = 'C';
    } else if (percentage >= 60) {
      grade = 'D';
    } else {
      grade = 'F';
    }
  }

  // Method to determine if the student passed the paper
  void checkPassStatus() {
    if (totalMarks == null || obtainedMarks == null) {
      isPassed = null;
      return;
    }
    double passPercentage = 33;
    double percentage = (obtainedMarks! / totalMarks!) * 100;
    isPassed = percentage >= passPercentage;
  }
}
