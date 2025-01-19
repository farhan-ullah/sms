import '../../../data/marks_model.dart';

List<ExamResult> mockExamResults = [
  ExamResult(
    examID: 'EX123',
    subjectID: 'S001',
    studentID: 'STU001',
    marksObtained: 92,
    grade: 'A',
    examDate: DateTime.parse('2023-11-15'),
    totalMarks: 100, // Assuming total marks are 100
    teacherID: 'T001', // Teacher ID for this exam
  ),
  ExamResult(
    examID: 'EX124',
    subjectID: 'S002',
    studentID: 'STU002',
    marksObtained: 76,
    grade: 'B',
    examDate: DateTime.parse('2023-11-14'),
    totalMarks: 100, // Assuming total marks are 100
    teacherID: 'T002', // Teacher ID for this exam
  ),
  ExamResult(
    examID: 'EX125',
    subjectID: 'S003',
    studentID: 'STU003',
    marksObtained: 65,
    grade: 'C',
    examDate: DateTime.parse('2023-11-12'),
    totalMarks: 100, // Assuming total marks are 100
    teacherID: 'T003', // Teacher ID for this exam
  ),
  ExamResult(
    examID: 'EX126',
    subjectID: 'S001',
    studentID: 'STU004',
    marksObtained: 85,
    grade: 'B',
    examDate: DateTime.parse('2023-11-11'),
    totalMarks: 100, // Assuming total marks are 100
    teacherID: 'T001', // Teacher ID for this exam
  ),
  ExamResult(
    examID: 'EX127',
    subjectID: 'S002',
    studentID: 'STU005',
    marksObtained: 55,
    grade: 'D',
    examDate: DateTime.parse('2023-11-10'),
    totalMarks: 100, // Assuming total marks are 100
    teacherID: 'T002', // Teacher ID for this exam
  ),
];
