import 'package:school/data/models/examModel/paper_model.dart';

class ExamModel {
  String examId;
  String examDate;
  String? examName;
  String? examDescription;
  List<PaperModel>? papers;
  String? studentID;       // Add student ID
  String? studentName;     // Add student name

  // Constructor
  ExamModel({
    required this.examId,
    required this.examName,
    required this.examDate,
    this.examDescription,
    this.papers,
    this.studentID,        // Initialize student ID
    this.studentName,      // Initialize student name
  });

  // Method to calculate total marks for the exam (sum of totalMarks from all papers)
  double getTotalMarks() {
    if (papers == null) return 0;
    return papers!.fold(0, (sum, paper) => sum + (paper.totalMarks ?? 0)); // Default to 0 if null
  }

  // Method to calculate total obtained marks (sum of obtainedMarks from all papers)
  double getTotalObtainedMarks() {
    if (papers == null) return 0;
    return papers!.fold(0, (sum, paper) => sum + (paper.obtainedMarks ?? 0)); // Default to 0 if null
  }

  // Method to calculate the overall grade for the exam (based on total marks and obtained marks)
  String calculateExamGrade() {
    double totalMarks = getTotalMarks();
    double obtainedMarks = getTotalObtainedMarks();

    if (totalMarks == 0) return 'Not Available';

    double percentage = (obtainedMarks / totalMarks) * 100;
    if (percentage >= 90) {
      return 'A';
    } else if (percentage >= 80) {
      return 'B';
    } else if (percentage >= 70) {
      return 'C';
    } else if (percentage >= 60) {
      return 'D';
    } else {
      return 'F';
    }
  }

  // Method to check if all papers are passed
  bool checkIfPassed() {
    if (papers == null) return false;
    return papers!.every((paper) => paper.isPassed == true);
  }

  // Method to get detailed information about the exam
  String getExamDetails() {
    String paperDetails = papers != null
        ? papers!.map((paper) => paper.getPaperDetails()).join("\n")
        : 'No papers available';
    return '''
      Exam: $examName
      Exam ID: $examId
      Exam Date: $examDate
      Description: ${examDescription ?? 'No description'}
      Papers:
      $paperDetails
    ''';
  }
}
