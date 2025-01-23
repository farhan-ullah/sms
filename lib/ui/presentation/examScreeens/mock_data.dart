import 'package:school/data/models/examModel/paper_model.dart';

import '../../../data/models/examModel/exam_model.dart';

void main() {
  // Creating some mock data for PaperModel
  List<PaperModel> papers1 = [
    PaperModel(
      paperName: 'Mathematics',
      subjectId: 'MTH101',
      totalMarks: 100,
      obtainedMarks: 85,
      grade: 'B',
      isPassed: true,
      studentID: 'S12345',
    ),
    PaperModel(
      paperName: 'Science',
      subjectId: 'SCI101',
      totalMarks: 100,
      obtainedMarks: 92,
      grade: 'A',
      isPassed: true,
      studentID: 'S12345',
    ),
    PaperModel(
      paperName: 'History',
      subjectId: 'HIS101',
      totalMarks: 100,
      obtainedMarks: 75,
      grade: 'C',
      isPassed: true,
      studentID: 'S12345',
    ),
    PaperModel(
      paperName: 'Geography',
      subjectId: 'GEO101',
      totalMarks: 100,
      obtainedMarks: 80,
      grade: 'B',
      isPassed: true,
      studentID: 'S12345',
    ),
  ];

  List<PaperModel> papers2 = [
    PaperModel(
      paperName: 'English',
      subjectId: 'ENG101',
      totalMarks: 100,
      obtainedMarks: 88,
      grade: 'B',
      isPassed: true,
      studentID: 'S67890',
    ),
    PaperModel(
      paperName: 'Physics',
      subjectId: 'PHY101',
      totalMarks: 100,
      obtainedMarks: 77,
      grade: 'C',
      isPassed: true,
      studentID: 'S67890',
    ),
    PaperModel(
      paperName: 'Chemistry',
      subjectId: 'CHE101',
      totalMarks: 100,
      obtainedMarks: 95,
      grade: 'A',
      isPassed: true,
      studentID: 'S67890',
    ),
    PaperModel(
      paperName: 'Biology',
      subjectId: 'BIO101',
      totalMarks: 100,
      obtainedMarks: 89,
      grade: 'B',
      isPassed: true,
      studentID: 'S67890',
    ),
  ];

  // Creating mock data for ExamModel
  List<ExamModel> exams = [
    ExamModel(
      examId: 'EXAM001',
      examName: 'Semester 1 Exams',
      examDate: '2025-01-10',
      examDescription: 'Final exams for Semester 1',
      papers: papers1,
    ),
    ExamModel(
      examId: 'EXAM002',
      examName: 'Mid-term Exams',
      examDate: '2025-02-15',
      examDescription: 'Mid-term exams for all courses',
      papers: papers2,
    ),
  ];

  // Displaying mock exam details
  for (var exam in exams) {
    print(exam.getExamDetails());
    print('Total Marks: ${exam.getTotalMarks()}');
    print('Total Obtained Marks: ${exam.getTotalObtainedMarks()}');
    print('Overall Grade: ${exam.calculateExamGrade()}');
    print('Passed All Papers: ${exam.checkIfPassed() ? 'Yes' : 'No'}');
    print('\n--------------------------------------\n');
  }
}
