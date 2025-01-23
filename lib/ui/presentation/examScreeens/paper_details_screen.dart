import 'package:flutter/material.dart';
import 'package:school/data/models/examModel/paper_model.dart'; // Adjust your imports

class PaperDetailsScreen extends StatelessWidget {
  final PaperModel paper;

  const PaperDetailsScreen({super.key, required this.paper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paper.paperName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Details
            Text(
              "Student: ${paper.studentName ?? 'Unknown'}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Student ID: ${paper.studentID ?? 'N/A'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Paper Details
            Text(
              "Subject ID: ${paper.subjectId}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Total Marks: ${paper.totalMarks ?? 0}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Obtained Marks: ${paper.obtainedMarks ?? 0}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Grade: ${paper.grade ?? 'N/A'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Pass Status: ${paper.isPassed == true ? 'Passed' : 'Failed'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Add any other info you need for the paper
          ],
        ),
      ),
    );
  }
}
