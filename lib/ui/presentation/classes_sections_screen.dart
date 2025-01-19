import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';

class ClassesSectionsScreen extends StatefulWidget {
  const ClassesSectionsScreen({super.key});

  @override
  State<ClassesSectionsScreen> createState() => _ClassesSectionsScreenState();
}

class _ClassesSectionsScreenState extends State<ClassesSectionsScreen>
    with TickerProviderStateMixin {
  late TabController _classTabController; // TabController for classes
  late TabController _sectionTabController; // TabController for sections



  @override
  void initState() {
    super.initState();

    // Initialize TabController for class tabs (length = 3 classes)
    _classTabController = TabController(length: 12, vsync: this);
    // Initialize TabController for sections tabs (length = 3 sections for each class)
    _sectionTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _classTabController.dispose();
    _sectionTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classes and Sections"),
        bottom: TabBar(
          controller: _classTabController,
          tabs: const [
            Tab(text: "Nursery"),
            Tab(text: "Prep"),
            Tab(text: "Class 1"),
            Tab(text: "Class 2"),
            Tab(text: "Class 3"),
            Tab(text: "Class 4"),
            Tab(text: "Class 5"),
            Tab(text: "Class 6"),
            Tab(text: "Class 7"),
            Tab(text: "Class 8"),
            Tab(text: "Class 9"),
            Tab(text: "Class 10"),


          ],
        ),
      ),
      body: TabBarView(
        controller: _classTabController,
        children: [
          _buildClassTabView(1),
          _buildClassTabView(2),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),
          _buildClassTabView(3),

        ],
      ),
    );
  }

  Widget _buildClassTabView(int classIndex) {
    return Column(
      children: [
        // Sub-tabs for Sections
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(labelColor: Colors.blue,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            controller: _sectionTabController,
            tabs: [
              Tab(text: "Section A",),
              Tab(text: "Section B"),
              Tab(text: "Section C"),
              Tab(text: "Section D"),



              // Tab(text: "Nursery"),
              // Tab(text: "Prep"),
              // Tab(text: "One"),
              // Tab(text: "Two"),
              // Tab(text: "Three"),
              // Tab(text: "Four"),
              // Tab(text: "Five"),
              // Tab(text: "Six"),
              // Tab(text: "Seven"),
              // Tab(text: "Eight"),
              // Tab(text: "Nine"),
              // Tab(text: "Ten"),


            ],
          ),
        ),
        // Display the content based on selected section
        Expanded(
          child: TabBarView(
            controller: _sectionTabController,
            children: [
              _buildStudentDataTable(students, 'A'),
              _buildStudentDataTable(students, 'B'),
              _buildStudentDataTable(students, 'C'),
              _buildStudentDataTable(students, 'D'),

            ],
          ),
        ),
      ],
    );
  }

  List<Student> students = [
    Student(name: "John Doe", className: "Class 1", section: "A", grade: "A", attendance: 95.0),
    Student(name: "Jane Smith", className: "Class 1", section: "B", grade: "B", attendance: 88.0),
    Student(name: "Robert Brown", className: "Class 2", section: "A", grade: "A+", attendance: 98.0),
    Student(name: "Emily Clark", className: "Class 2", section: "B", grade: "B+", attendance: 92.0),
    Student(name: "Michael White", className: "Class 3", section: "C", grade: "C", attendance: 85.0),
  ];

  // Builds the DataTable for the student data
  Widget _buildStudentDataTable(List<Student> students, String section) {
    List<Student> sectionStudents = students.where((student) => student.section == section).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 20.0,
        horizontalMargin: 10.0,
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Class')),
          DataColumn(label: Text('Section')),
          DataColumn(label: Text('Grade')),
          DataColumn(label: Text('Attendance')),
        ],
        rows: sectionStudents.map((student) {
          return DataRow(
            cells: [
              DataCell(Text(student.name)),
              DataCell(Text(student.className)),
              DataCell(Text(student.section)),
              DataCell(Text(student.grade)),
              DataCell(Text("${student.attendance}%")),
            ],
          );
        }).toList(),
      ),
    );
  }
}


class Student {
  final String name;
  final String className;
  final String section;
  final String grade;
  final double attendance;

  Student({
    required this.name,
    required this.className,
    required this.section,
    required this.grade,
    required this.attendance,
  });
}

