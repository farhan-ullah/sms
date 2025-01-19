// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/id_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';
import 'package:school/businessLogic/providers/teacher_provider.dart';
import 'package:school/data/models/classNameModel/class_name_model.dart';
import 'package:school/data/models/subjectModel/subject_model.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';

import '../../../data/models/student_model/student_model.dart';
import '../../../utils/custom_toast.dart';

class ManageClassScreen extends StatefulWidget {
  const ManageClassScreen({super.key});

  @override
  State<ManageClassScreen> createState() => _ManageClassScreenState();
}

class _ManageClassScreenState extends State<ManageClassScreen> {
  String? classID;

  @override
  void initState() {
    super.initState();
    final idProvider = Provider.of<IdProvider>(context, listen: false);
    classID = idProvider.getClassID().toString();
  }

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassNameProvider>(context);
    List<ClassNameModel> classes = classProvider.mockClassList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Classes"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeaderRow(),
            Expanded(
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final studentProvider = Provider.of<StudentProvider>(context, listen: false);
                  final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);

                  return _buildClassRow(context, index, classes, studentProvider, subjectProvider);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAddClassDialog(context);
      },child: Icon(Icons.add),),
    );
  }

// This will be a custom header row widget to make it clearer and visually separate
  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderText('Class ID'),
          _buildHeaderText('Class Name'),
          _buildHeaderText('No. of Students'),
          _buildHeaderText('Subjects'),
          _buildHeaderText('Section'),
          _buildHeaderText('View Class'),
          _buildHeaderText('Options'),
        ],
      ),
    );
  }

// This will build the heading text style
  Widget _buildHeaderText(String text) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

// Here's the updated data row for class item
  Widget _buildClassRow(BuildContext context, int index, List<ClassNameModel> classes, StudentProvider studentProvider, SubjectProvider subjectProvider) {
    final className = classes[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildClassColumnText(className.classID.toString(), align: TextAlign.center),
          _buildClassColumnText(className.className.toString(), align: TextAlign.center),
          _buildClassColumnButton(className.classStudentIDs!.length.toString(), () async {
            List<StudentModel> studentsOfClass = await studentProvider.getStudentsByStudentIds(className.classStudentIDs ?? [], studentProvider);
            showCustomDialog("Students", studentsOfClass);
          }),
          _buildClassColumnButton("View Subjects", () => _showSubjectDialog(className.subjectIDs ?? [], subjectProvider)),
          _buildClassColumnText(className.section.toString(), align: TextAlign.center),
          _buildViewClassButton(context, className),
          _buildOptionsMenu(context, className),
        ],
      ),
    );
  }

// This builds a single class data column (text or button)
  Widget _buildClassColumnText(String text, {TextAlign align = TextAlign.center}) {
    return Expanded(
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

// This builds the button in the class data row (for subjects or students)
  Widget _buildClassColumnButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.blueAccent),
        ),
      ),
    );
  }

// Button to view class details
  Widget _buildViewClassButton(BuildContext context, ClassNameModel className) {
    return ElevatedButton(
      onPressed: () {
        _showClassDetailDialog(context, className);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text("View Class"),
    );
  }

// Options menu for actions like Edit, Delete, etc.
  Widget _buildOptionsMenu(BuildContext context, ClassNameModel className) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'Add Sections') {
          _createSectionAdditionDialog(context, className.className.toString());
        } else if (value == 'Edit Class') {
          _showEditClassDialog(context, className);
        } else if (value == 'Delete Class') {
          _showDeleteClassDialog(context, className);
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: 'Add Sections',
            child: Text('Add Sections'),
          ),
          PopupMenuItem<String>(
            value: 'Edit Class',
            child: Text('Edit Class'),
          ),
          PopupMenuItem<String>(
            value: 'Delete Class',
            child: Text('Delete Class'),
          ),
        ];
      },
      icon: Icon(Icons.more_vert),
    );
  }


  void showCustomDialog(String title,List<StudentModel> students,){
    showDialog(context: context, builder: (context) {

      return AlertDialog(
        title:Text(title) ,
        content: SizedBox(height: 500,width: 500,
          child: ListView.builder(

            itemCount: students.length,
            itemBuilder: (context, index) {
              if(students.isNotEmpty){
                return ListTile(
                  leading: Text(students[index].studentId.toString()),
                  title: Text("${students[index].firstName}  ${students[index].lastName}"),
                );

              }
            },),
        ),
      );
    },);
  }



  void showAddClassDialog(BuildContext context) {
    TextEditingController classNameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: StatefulBuilder(
            builder: (context, setState) {
              final classProvider = Provider.of<ClassNameProvider>(context);
              final idProvider = Provider.of<IdProvider>(context);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Adding padding and more spacing for modern layout
                        SizedBox(height: 20),

                        // Class Name Text Field
                        TextFormField(
                          controller: classNameController,
                          validator: (v) {
                            if (v?.isEmpty ?? false) {
                              return "Enter the Class Name Please";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text("Class Name"),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            hintText: "Enter class name",
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Class ID Display Card (modern card design)
                        Card(
                          elevation: 6,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.blueGrey[800],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Class ID:',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  idProvider.classId,
                                  style: const TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Create Class Button (Modern, with rounded corners and padding)
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              idProvider.generateClassID(); // Generate new class ID
                              classProvider.createClass(
                                classNameController.text,
                                idProvider.classId,
                                context,
                              );
                              classNameController.clear();
                              Navigator.of(context).pop(); // Close the dialog
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 40.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "Create Class",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Show dialog to view all subjects related to the class
  Future<void> _showSubjectDialog(List<String> subjectIDs, SubjectProvider subjectProvider) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("All Subjects"),
          content: SizedBox(
            height: 400,
            width: 500,
            child: ListView.builder(
              itemCount: subjectProvider.mockSubjectList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjectProvider.mockSubjectList[index].subjectName ?? ""),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Show dialog to view class details (students, teachers, etc.)
  Future<void> _showClassDetailDialog(BuildContext context, ClassNameModel className) async {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    final teacherProvider = Provider.of<TeacherProvider>(context, listen: false);

    List<String> studentIDs = className.classStudentIDs ?? [];
    List<String> teacherIds = className.subjectIDs ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(className.className.toString()),
          content: Row(
            children: [
              Expanded(
                child: _buildStudentColumn(studentIDs, studentProvider),
              ),
              Expanded(
                child: _buildTeacherColumn(teacherIds, teacherProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show a list of students
  Widget _buildStudentColumn(List<String> studentIDs, StudentProvider studentProvider) {
    return Column(
      children: [
        Text("Students"),
        FutureBuilder<List<StudentModel>>(
          future: studentProvider.getStudentsByStudentIds(studentIDs, studentProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].firstName ?? "Unknown Student"),
                  );
                },
              );
            } else {
              return Center(child: Text('No students found.'));
            }
          },
        ),
      ],
    );
  }

  // Show a list of teachers
  Widget _buildTeacherColumn(List<String> teacherIds, TeacherProvider teacherProvider) {
    return Column(
      children: [
        Text("Teachers"),
        FutureBuilder<List<TeacherModel>>(
          future: teacherProvider.getTeachersById(teacherIds),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].teacherFirstName ?? "Unknown Teacher"),
                  );
                },
              );
            } else {
              return Center(child: Text('No teachers found.'));
            }
          },
        ),
      ],
    );
  }

  // Show dialog for adding sections to the class
  Future<void> _createSectionAdditionDialog(BuildContext context, String className) async {
    final classProvider = Provider.of<ClassNameProvider>(context, listen: false);
    final idProvider = Provider.of<IdProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Section"),
          content: Form(
            child: Column(
              children: [
                TextField(
                  controller: sectionController,
                  decoration: InputDecoration(labelText: 'Enter Section (A, B, or C)'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String classID = idProvider.classId;
                    if (sectionController.text.isNotEmpty) {
                      classProvider.createClass(
                        className,
                        classID,
                        context,
                        sectionController.text,
                      );
                      sectionController.clear();
                      idProvider.generateClassID();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Section added successfully")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid section")));
                    }
                  },
                  child: Text("Add Section"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show dialog for editing class name
  Future<void> _showEditClassDialog(BuildContext context, ClassNameModel className) async {
    TextEditingController classNewNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Class Name"),
          content: TextFormField(
            controller: classNewNameController,
            decoration: InputDecoration(labelText: "New Class Name"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                className.className = classNewNameController.text;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Class name updated")));
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for deleting class
  Future<void> _showDeleteClassDialog(BuildContext context, ClassNameModel className) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Are you sure you want to delete this class?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform deletion logic here
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Class deleted successfully")));
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
  TextEditingController sectionController = TextEditingController();
}
