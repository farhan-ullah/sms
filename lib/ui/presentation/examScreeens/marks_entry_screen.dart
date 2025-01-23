import 'package:flutter/material.dart';

import 'mock_data.dart';  // Assuming mock data exists for students and examModel results.

class MarksEntryScreen extends StatefulWidget {
  final String examID;  // Exam ID to which marks belong

  MarksEntryScreen({required this.examID});

  @override
  _MarksEntryScreenState createState() => _MarksEntryScreenState();
}

class _MarksEntryScreenState extends State<MarksEntryScreen> {
  // Controller for search bar
  TextEditingController searchController = TextEditingController();

  // List of students who are enrolled for the examModel
  List<Student> students = [];

  // Map to store the marks entered for students
  Map<String, int> studentMarks = {};

  @override
  void initState() {
    super.initState();
    // Initialize the students list based on the examModel ID
    students = _getStudentsForExam(widget.examID);
  }

  // Get a list of students who are enrolled in the examModel
  List<Student> _getStudentsForExam(String examID) {
    return mockStudents.where((student) => student.examID == examID).toList();
  }

  // Function to handle saving of marks
  void _saveMarks() {
    // For now, we just show a snackbar confirming marks have been saved
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Marks saved successfully!')));
  }

  // Function to filter the students list based on the search query
  void _filterStudents(String query) {
    setState(() {
      students = mockStudents
          .where((student) => student.name.toLowerCase().contains(query.toLowerCase()) ||
          student.studentID.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks Entry for Exam ${widget.examID}'),
      ),
      body: Column(
        children: [
          // Search Bar for filtering students
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterStudents,
              decoration: InputDecoration(
                labelText: 'Search by Name or ID',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // List of Students for whom marks can be entered
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(student.name),
                    subtitle: Text('ID: ${student.studentID}'),
                    trailing: Container(
                      width: 120,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Marks',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            studentMarks[student.studentID] = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveMarks,
        child: Icon(Icons.save),
      ),
    );
  }
}

// Sample Student class
class Student {
  final String studentID;
  final String name;
  final String examID;

  Student({required this.studentID, required this.name, required this.examID});
}

// Mock Data for students (you can replace it with actual data from an API or database)
List<Student> mockStudents = [
  Student(studentID: 'S001', name: 'John Doe', examID: 'EXAM001'),
  Student(studentID: 'S002', name: 'Jane Smith', examID: 'EXAM001'),
  Student(studentID: 'S003', name: 'Michael Johnson', examID: 'EXAM001'),
  Student(studentID: 'S004', name: 'Emily Davis', examID: 'EXAM002'),
  Student(studentID: 'S005', name: 'Chris Wilson', examID: 'EXAM001'),
];

