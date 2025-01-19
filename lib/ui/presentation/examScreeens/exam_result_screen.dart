import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';

import '../../../data/marks_model.dart';
import 'mock_data.dart';  // Assuming mock data is in a file called mock_data.dart

class ExamResultsScreen extends StatefulWidget {
  @override
  _ExamResultsScreenState createState() => _ExamResultsScreenState();
}

class _ExamResultsScreenState extends State<ExamResultsScreen> {
  String selectedGrade = 'All Grades';
  String selectedSubject = 'All Subjects';
  String searchQuery = '';

  // Filter function to apply grade, subject, and search query
  List<ExamResult> get filteredResults {
    return mockExamResults.where((exam) {
      // Filter by grade
      bool gradeMatch = selectedGrade == 'All Grades' || exam.grade == selectedGrade;
      // Filter by subject
      bool subjectMatch = selectedSubject == 'All Subjects' || exam.subjectID == selectedSubject;
      // Filter by search query (exam ID or grade or subject name)
      bool searchMatch = exam.examID.toLowerCase().contains(searchQuery.toLowerCase()) ||
          exam.grade.toLowerCase().contains(searchQuery.toLowerCase()) ||
          exam.subjectID.toLowerCase().contains(searchQuery.toLowerCase());

      return gradeMatch && subjectMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Results'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search Exam Results',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Display filtered exam results
          Expanded(
            child: ListView.builder(
              itemCount: filteredResults.length,
              itemBuilder: (context, index) {
                final examResult = filteredResults[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 4,
                  child: ListTile(
                    title: Text('${examResult.subjectID} - ${examResult.grade}'),
                    subtitle: Text(
                      'Student: ${examResult.studentID}\nMarks: ${examResult.marksObtained}\nDate: ${examResult.examDate.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Handle tap - navigate to detailed view if needed
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Show filter dialog to choose grade and subject
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Exam Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grade Filter Dropdown
              DropdownButton<String>(
                value: selectedGrade,
                onChanged: (value) {
                  setState(() {
                    selectedGrade = value!;
                  });
                  Navigator.pop(context);
                },
                items: _getGradeDropdownItems(),  // Use helper function to generate items
              ),
              // Subject Filter Dropdown
              DropdownButton<String>(
                value: selectedSubject,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value!;
                  });
                  Navigator.pop(context);
                },
                items: _getSubjectDropdownItems(),  // Use helper function to generate items
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to generate dropdown items for grades
  List<DropdownMenuItem<String>> _getGradeDropdownItems() {
    return ['All Grades', 'A', 'B', 'C', 'D', 'F'].map((String grade) {
      return DropdownMenuItem<String>(
        value: grade,
        child: Text(grade),
      );
    }).toList();
  }

  // Helper function to generate dropdown items for subjects
  List<DropdownMenuItem<String>> _getSubjectDropdownItems() {
    final subjectProvider = Provider.of<SubjectProvider>(context);
    List<String> subjects = ['All Subjects'] +
        subjectProvider.mockSubjectList.map((subject) => subject.subjectID!).toList().toSet().toList();

    return subjects.map((String subject) {
      return DropdownMenuItem<String>(
        value: subject,
        child: Text(subject),
      );
    }).toList();
  }
}
