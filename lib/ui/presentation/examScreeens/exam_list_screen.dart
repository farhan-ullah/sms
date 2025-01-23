import 'package:flutter/material.dart';
import 'package:school/data/models/examModel/exam_model.dart';

import '../../../data/models/examModel/paper_model.dart';
import 'exam_result_screen.dart'; // Adjust the path to your screen

class ExamListScreen extends StatelessWidget {
  // This is just mock data to simulate a list of exams
  final List<ExamModel> exams = [
    ExamModel(
      examId: '001',
      examName: 'Math Exam',
      examDate: '2025-01-30',
      studentID: 'S1001',
      studentName: 'John Doe',
      papers: [
        PaperModel(
          paperName: 'Algebra',
          subjectId: 'MATH101',
          totalMarks: 100,
          obtainedMarks: 85,
          grade: 'B',
          isPassed: true,
          studentID: 'S1001',
          studentName: 'John Doe',
        ),
        PaperModel(
          paperName: 'Calculus',
          subjectId: 'MATH102',
          totalMarks: 100,
          obtainedMarks: 90,
          grade: 'A',
          isPassed: true,
          studentID: 'S1001',
          studentName: 'John Doe',
        ),
      ],
    ),
    ExamModel(
      examId: '002',
      examName: 'English Exam',
      examDate: '2025-02-05',
      studentID: 'S1002',
      studentName: 'Jane Smith',
      papers: [
        PaperModel(
          paperName: 'Grammar',
          subjectId: 'ENG101',
          totalMarks: 100,
          obtainedMarks: 80,
          grade: 'B',
          isPassed: true,
          studentID: 'S1002',
          studentName: 'Jane Smith',
        ),
        PaperModel(
          paperName: 'Literature',
          subjectId: 'ENG102',
          totalMarks: 100,
          obtainedMarks: 88,
          grade: 'A',
          isPassed: true,
          studentID: 'S1002',
          studentName: 'Jane Smith',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];

          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 3,
            child: ListTile(
              title: Text(exam.examName ?? 'Unknown Exam'),
              subtitle: Text('Date: ${exam.examDate}'),
              onTap: () {
                // Navigate to ExamResultScreen and pass the ExamModel
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamResultScreen(exam: exam),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
