import 'package:flutter/material.dart';

import '../../../data/models/classNameModel/class_name_model.dart';
import 'mock_data.dart'; // Assuming mock data exists for exam scheduling.

class ExamSchedulingScreen extends StatefulWidget {
  @override
  _ExamSchedulingScreenState createState() => _ExamSchedulingScreenState();
}

class _ExamSchedulingScreenState extends State<ExamSchedulingScreen> {
  // Controllers for search input and filter values
  TextEditingController searchController = TextEditingController();
  String selectedSubject = 'All Subjects';
  String selectedDate = 'Any Date';

  // Sample data for the list of exams (you should replace this with your actual data)
  List<ExamSchedule> scheduledExams = mockExamSchedules;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Scheduling'),
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
              controller: searchController,
              onChanged: _filterExams,
              decoration: InputDecoration(
                labelText: 'Search Exam Schedules',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Exam Schedule List
          Expanded(
            child: ListView.builder(
              itemCount: scheduledExams.length,
              itemBuilder: (context, index) {
                final exam = scheduledExams[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 4,
                  child: ListTile(
                    title: Text('${exam.subjectID} - ${exam.examDate}'),
                    subtitle: Text('Class: ${exam.className} | Duration: ${exam.duration} hours'),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      // Navigate to edit screen
                    },
                    onLongPress: () {
                      // Delete exam schedule (confirmation dialog can be added)
                      setState(() {
                        scheduledExams.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExamDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  // Function to filter exams based on search and selected filters
  void _filterExams(String query) {
    setState(() {
      scheduledExams = mockExamSchedules.where((exam) {
        final subjectMatch = selectedSubject == 'All Subjects' || exam.subjectID.contains(selectedSubject);
        final dateMatch = selectedDate == 'Any Date' || exam.examDate.contains(selectedDate);
        final searchMatch = exam.subjectID.toLowerCase().contains(query.toLowerCase()) ||
            exam.examDate.toLowerCase().contains(query.toLowerCase()) ||
            exam.className.toLowerCase().contains(query.toLowerCase());
        return subjectMatch && dateMatch && searchMatch;
      }).toList();
    });
  }

  // Show the dialog for filters (Subject, Date)
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Exam Schedules'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subject Filter Dropdown
              DropdownButton<String>(
                value: selectedSubject,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value!;
                  });
                  Navigator.pop(context);
                  _filterExams(searchController.text);
                },
                items: ['All Subjects', 'Math', 'Science', 'History', 'English']
                    .map<DropdownMenuItem<String>>((String subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
              ),
              // Date Filter Dropdown
              DropdownButton<String>(
                value: selectedDate,
                onChanged: (value) {
                  setState(() {
                    selectedDate = value!;
                  });
                  Navigator.pop(context);
                  _filterExams(searchController.text);
                },
                items: ['Any Date', '2025-02-15', '2025-03-10', '2025-04-01']
                    .map<DropdownMenuItem<String>>((String date) {
                  return DropdownMenuItem<String>(
                    value: date,
                    child: Text(date),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show dialog to add a new exam schedule
  void _showAddExamDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Exam Schedule'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Class Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Exam Date'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Duration'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement adding exam schedule functionality
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class ExamSchedule {
  String subjectID;
  String className;
  String examDate;
  double duration;

  ExamSchedule({
    required this.subjectID,
    required this.className,
    required this.examDate,
    required this.duration,
  });
}

// Mock Data
List<ExamSchedule> mockExamSchedules = [
  ExamSchedule(subjectID: 'Math', className: 'Class A', examDate: '2025-02-15', duration: 2.0),
  ExamSchedule(subjectID: 'Science', className: 'Class B', examDate: '2025-03-10', duration: 1.5),
  ExamSchedule(subjectID: 'History', className: 'Class C', examDate: '2025-04-01', duration: 3.0),
];
