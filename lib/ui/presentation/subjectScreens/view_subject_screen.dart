import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';
import 'package:school/data/models/subjectModel/subject_model.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import '../../../businessLogic/providers/class_name_provider.dart';
import '../../../businessLogic/providers/id_provider.dart';
import '../../../businessLogic/providers/teacher_provider.dart';
import '../../../utils/custom_toast.dart';
import 'editing_subject_dialog.dart';

class ViewSubjectScreen extends StatefulWidget {
  const ViewSubjectScreen({super.key});

  @override
  State<ViewSubjectScreen> createState() => _ViewSubjectScreenState();
}

class _ViewSubjectScreenState extends State<ViewSubjectScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _searchQuery = "";
  String? _selectedClass;
  String? _selectedTeacher;

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectProvider>(context);
    final teacherProvider = Provider.of<TeacherProvider>(context);

    List<SubjectModel> subjects = subjectProvider.mockSubjectList;

    // Get a list of unique teacher names from the subjects for the filter
    List<String> teacherNames = _getTeacherNames(subjects);

    // Filtering the subjects based on search query and selected filters
    List<SubjectModel> filteredSubjects = subjects.where((subject) {
      final matchesSearchQuery = _searchQuery.isEmpty ||
          subject.subjectName!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject.teacherName!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject.className.toString().contains(_searchQuery.toLowerCase());
      final matchesClassFilter = _selectedClass == null || subject.className.toString() == _selectedClass;
      final matchesTeacherFilter = _selectedTeacher == null || subject.teacherName == _selectedTeacher;

      return matchesSearchQuery && matchesClassFilter && matchesTeacherFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("View Subjects"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Filters and Reset button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filter by Class
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select Class'),
                        value: _selectedClass,
                        items: _getClassNames(subjects).map((className) {
                          return DropdownMenuItem<String>(
                            value: className,
                            child: Text(className),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedClass = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // Filter by Teacher
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select Teacher'),
                        value: _selectedTeacher,
                        items: teacherNames.map((teacherName) {
                          return DropdownMenuItem<String>(
                            value: teacherName,
                            child: Text(teacherName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTeacher = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search Bar to search subject or teacher
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Subjects, Teachers, or Class',
                    border: OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // List of subjects
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredSubjects.length,
                itemBuilder: (context, index) {
                  final subject = filteredSubjects[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(subject.subjectName ?? "")),
                          Expanded(child: Text(subject.className.toString())),
                          Expanded(child: Text(subject.subjectID.toString())),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(child: Text(subject.teacherName ?? "")),
                          Expanded(child: Text(subject.teacherID ?? "")),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "Edit") {
                            _showEditDialog(context, subject);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem<String>(
                              value: "Edit",
                              child: Text("Edit"),
                            ),
                            PopupMenuItem<String>(
                              onTap: () {
                                _showDeleteConfirmationDialog(context, subject);
                              },
                              value: "Delete",
                              child: const Text("Delete"),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddSubjectDialog(context);
        },
        child: const Icon(Icons.add), // Use an icon, like the add icon
        tooltip: 'Add New Subject',
      ),
    );
  }

  // Get unique teacher names from subjects
  List<String> _getTeacherNames(List<SubjectModel> subjects) {
    return subjects.map((subject) => subject.teacherName ?? "No Teacher").toSet().toList();
  }

  // Get class names from subjects
  List<String> _getClassNames(List<SubjectModel> subjects) {
    return subjects.map((subject) => subject.className.toString()).toSet().toList();
  }

  // Edit dialog
  void _showEditDialog(BuildContext context, SubjectModel subject) {
    _subjectController.text = subject.subjectName ?? "";
    String selectedTeacherId = subject.teacherID ?? "";
    String teacherName = subject.teacherName ?? "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Subject"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Subject Name TextField
                TextFormField(
                  controller: _subjectController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Subject Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Teacher Dropdown
                FutureBuilder(
                  future: Provider.of<TeacherProvider>(context, listen: false).getAllTeachers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Error fetching teachers");
                    } else if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                      return const Text("No teachers available");
                    } else {
                      List<DropdownMenuItem<String>> dropdownItems = [];
                      for (var teacher in snapshot.data!) {
                        dropdownItems.add(
                          DropdownMenuItem<String>(
                            value: teacher.teacherId.toString(),
                            child: Text("${teacher.teacherFirstName} ${teacher.teacherLastName}"),
                          ),
                        );
                      }

                      return DropdownButtonFormField<String>(
                        value: selectedTeacherId.isEmpty ? null : selectedTeacherId,
                        items: dropdownItems,
                        onChanged: (value) {
                          if (value != null) {
                            selectedTeacherId = value;
                            final selectedTeacher = snapshot.data?.firstWhere(
                                  (teacher) => teacher.teacherId.toString() == selectedTeacherId,
                              orElse: () => TeacherModel(),
                            );
                            if (selectedTeacher != null) {
                              teacherName = "${selectedTeacher.teacherFirstName} ${selectedTeacher.teacherLastName}";
                              subject.teacherName = teacherName;
                            }
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Select Teacher",
                          border: OutlineInputBorder(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);
                  subject.subjectName = _subjectController.text;
                  subject.teacherID = selectedTeacherId;
                  subject.teacherName = teacherName;

                  // Show a success Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Subject updated successfully")),
                  );

                  // Close the dialog
                  Navigator.pop(context);
                }
              },
              child: const Text("Save Changes"),
            ),
            // Cancel Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, SubjectModel subject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Are you sure you want to delete this subject?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                // Show a success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Subject deleted successfully")),
                );

                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Yes, Delete"),
            ),
          ],
        );
      },
    );
  }
  
}


void showAddSubjectDialog(BuildContext context) {
  String selectedClassID = "";
  String selectedTeacherId = "";
  final _subjectController = TextEditingController();
  final _subjectKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _subjectKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<IdProvider>(
                        builder: (context, idProvider, child) {
                          return Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.blueGrey[800],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.account_circle,
                                    size: 40,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Subject ID:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    idProvider.subjectId,
                                    style: const TextStyle(
                                      color: Colors.amberAccent,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _subjectController,
                            validator: (v) {
                              if (v?.isEmpty ?? false) {
                                return "Subject Name is required!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Enter Subject Name",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Consumer<ClassNameProvider>(
                        builder: (context, classProvider, child) {
                          final availableClasses = classProvider.mockClassList
                              .where((classItem) => classItem.classID != "No Class Selected")
                              .toList();

                          return Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: "Select Class",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                value: classProvider.selectedClass == "No Class Selected"
                                    ? null
                                    : classProvider.selectedClass,
                                items: availableClasses.map<DropdownMenuItem<String>>((classItem) {
                                  return DropdownMenuItem<String>(
                                    value: classItem.classID,
                                    child: Text(
                                      '${classItem.classID} - ${classItem.classID}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedClassID = value;
                                    classProvider.changeCLassName(value);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      Consumer<TeacherProvider>(
                        builder: (context, teacherProvider, child) {
                          return Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FutureBuilder(
                                future: teacherProvider.getAllTeachers(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text("Error: ${snapshot.error}"));
                                  } else if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                                    return const Center(child: Text("No teachers available"));
                                  } else {
                                    List<DropdownMenuItem<String>> dropdownItems = [];
                                    for (var teacher in snapshot.data!) {
                                      dropdownItems.add(
                                        DropdownMenuItem<String>(
                                          value: teacher.teacherId.toString(),
                                          child: Text(
                                            "${teacher.teacherFirstName} ${teacher.teacherLastName}",
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    }

                                    return DropdownButton<String>(
                                      value: selectedTeacherId.isEmpty ? null : selectedTeacherId,
                                      items: dropdownItems,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            selectedTeacherId = value;
                                          });
                                          teacherProvider.changeTeacher(value);
                                        }
                                      },
                                      hint: const Text(
                                        "Select Teacher",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          if (selectedTeacherId.isEmpty) {
                            MyToast().showToast("Please select a teacher before submitting.", context);
                            return;
                          }

                          if (_subjectKey.currentState!.validate()) {
                            SubjectModel subjectModel = SubjectModel(
                              teacherID: selectedTeacherId,
                              classID: selectedClassID,
                              subjectID: context.read<IdProvider>().subjectId,
                              subjectName: _subjectController.text,
                            );

                            // Call your handleSubmit function or business logic here
                            print("Subject added successfully");
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
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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

