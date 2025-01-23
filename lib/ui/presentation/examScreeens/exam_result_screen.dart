import 'package:flutter/material.dart';
import 'package:school/data/models/examModel/exam_model.dart';
import 'package:school/data/models/examModel/paper_model.dart';
import 'package:school/ui/presentation/examScreeens/paper_details_screen.dart'; // Adjust your imports

class ExamResultScreen extends StatelessWidget {
  final ExamModel exam;

  const ExamResultScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.examName ?? 'Unknown Exam'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Details
            Text(
              "Student: ${exam.studentName ?? 'Unknown'}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Student ID: ${exam.studentID ?? 'N/A'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Exam Details
            Text(
              "Exam ID: ${exam.examId}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Exam Date: ${exam.examDate}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Description: ${exam.examDescription ?? 'No description available.'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Overall Grade: ${exam.calculateExamGrade()}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Pass Status: ${exam.checkIfPassed() ? 'Passed' : 'Failed'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Papers in this Exam:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: exam.papers?.length ?? 0,
              itemBuilder: (context, index) {
                final paper = exam.papers![index];
                return Card(
                  margin: EdgeInsets.only(top: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(paper.paperName),
                    subtitle: Text(paper.subjectId),
                    trailing: Text('Grade: ${paper.grade ?? "N/A"}'),
                    onTap: () {
                      // Navigate to PaperDetailsScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaperDetailsScreen(paper: paper),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
