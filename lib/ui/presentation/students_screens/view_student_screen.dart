import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/student_model/student_model.dart';
import 'package:school/ui/presentation/widgets/custom_date_picker.dart';
import 'package:school/ui/presentation/widgets/upload_photo_widget.dart';

class ViewStudentScreen extends StatefulWidget {
  const ViewStudentScreen({super.key});

  @override
  State<ViewStudentScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ViewStudentScreen> {
  TextEditingController searchController = TextEditingController();
  String? selectedGender;
  String? selectedClassID;
  String? selectedSection;

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    List<StudentModel> students = studentProvider.mockStudentList;

    // Filter students based on search query and selected filters
    List<StudentModel> filteredStudents = students
        .where((student) {
      // Filter by search query (first name, last name, or student ID)
      bool matchesSearchQuery = student.firstName!
          .toLowerCase()
          .contains(searchController.text.toLowerCase()) ||
          student.lastName!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          student.studentId!.toLowerCase().contains(searchController.text.toLowerCase());

      // Filter by gender if selected
      bool matchesGender = selectedGender == null || student.gender == selectedGender;

      // Filter by class ID if selected
      bool matchesClassID = selectedClassID == null || student.classID == selectedClassID;

      // Filter by section if selected
      bool matchesSection = selectedSection == null || student.section == selectedSection;

      return matchesSearchQuery && matchesGender && matchesClassID && matchesSection;
    })
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name or ID',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // Filter Options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Gender Filter
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Class Filter
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedClassID,
                        onChanged: (value) {
                          setState(() {
                            selectedClassID = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Class ID',
                          border: OutlineInputBorder(),
                        ),
                        items: ['1', '2', '3', '4', '5'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Section Filter
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedSection,
                        onChanged: (value) {
                          setState(() {
                            selectedSection = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Section',
                          border: OutlineInputBorder(),
                        ),
                        items: ['A', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Reset Filters Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      selectedGender = null;
                      selectedClassID = null;
                      selectedSection = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for reset button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Reset Filters'),
                ),
              ],
            ),
          ),

          // Student List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showStudentDetails(context, filteredStudents[index]);
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          // Profile Picture with a fallback placeholder
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: filteredStudents[index].photoLink != null
                                ? Image.network(
                              filteredStudents[index].photoLink!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.person, size: 50); // Placeholder icon
                              },
                            )
                                : Icon(Icons.person, size: 50), // Placeholder icon
                          ),
                          const SizedBox(width: 12), // Reduced space between picture and text
                          // Student Info Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Student Name
                                Text(
                                  '${filteredStudents[index].firstName} ${filteredStudents[index].lastName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                // Student ID
                                Text(
                                  'ID: ${filteredStudents[index].studentId}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Class & Section
                                Row(
                                  children: [
                                    Text(
                                      'Class: ${filteredStudents[index].classID}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Section: ${filteredStudents[index].section}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Arrow icon to indicate tap action
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text("Edit Student"),
                                onTap: () {
                                  showEditStudentDialog(context, filteredStudents[index]);
                                },
                              ),
                              PopupMenuItem(
                                child: Text("Struck Off"),
                                onTap: () {
                                  print("Should struck off student");
                                },
                              ),
                            ];
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(BuildContext context, StudentModel student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture with placeholder
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: student.photoLink != null
                          ? Image.network(
                        student.photoLink!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, size: 120);
                        },
                      )
                          : Icon(Icons.person, size: 120),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Student Name and ID
                  Text(
                    '${student.firstName} ${student.lastName}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ID: ${student.studentId}',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]),
                  ),
                  const SizedBox(height: 20),

                  // Student Details Section
                  buildDetailRow("Gender:", student.gender.toString()),
                  buildDetailRow("Date of Birth:", student.dateOfBirth.toString()),
                  buildDetailRow("Place of Birth:", student.placeOfBirth.toString()),
                  buildDetailRow("Date of Admission:", student.dateOfAdmission.toString()),
                  buildDetailRow("Address:", student.completeAddress.toString()),
                  buildDetailRow("Parent ID:", student.parentId.toString()),
                  buildDetailRow("Roll No:", student.rollNo.toString()),
                  buildDetailRow("Class ID:", student.classID.toString()),
                  buildDetailRow("Section:", student.section.toString()),

                  const SizedBox(height: 30),
                  // Close Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Close'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper function to build detail rows
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.blueGrey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showEditStudentDialog(BuildContext context, StudentModel student) async {
    print("Opening edit dialog for student: ${student.firstName} ${student.lastName}");

    final TextEditingController firstNameController = TextEditingController(text: student.firstName);
    final TextEditingController lastNameController = TextEditingController(text: student.lastName);
    final TextEditingController genderController = TextEditingController(text: student.gender);
    final TextEditingController dobController = TextEditingController(text: student.dateOfBirth);
    final TextEditingController placeOfBirthController = TextEditingController(text: student.placeOfBirth);
    final TextEditingController admissionDateController = TextEditingController(text: student.dateOfAdmission);
    final TextEditingController photoLinkController = TextEditingController(text: student.photoLink);
    final TextEditingController classIDController = TextEditingController(text: student.classID);
    final TextEditingController sectionController = TextEditingController(text: student.section);
    final TextEditingController previousSchoolController = TextEditingController(text: student.previousSchoolName);
    final TextEditingController reasonOfLeavingController = TextEditingController(text: student.reasonOfLeaving);
    final TextEditingController referenceController = TextEditingController(text: student.reference);
    final TextEditingController addressController = TextEditingController(text: student.completeAddress);
    final TextEditingController rollNoController = TextEditingController(text: student.rollNo);

    double? concessionInPercent = student.concessionInPercent;
    double? concessionInPKR = student.concessionInPKR;

    // A local variable for holding the selected image
    File? selectedImage;

    // Gender options
    final genderOptions = ['Male', 'Female'];

    // Date Pickers
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Student Information'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: UploadPhotoWidget(labelText: "Upload Image"),
                  ),
                  SizedBox(height: 20),
                  _buildTextField('First Name', firstNameController),
                  SizedBox(height: 20),
                  _buildTextField('Last Name', lastNameController),
                  SizedBox(height: 20),
                  _buildDropdownField('Gender', genderOptions, genderController),
                  SizedBox(height: 20),
                  CustomDatePicker(controller: dobController, labelText: 'Date of Birth', onDateSelected: (p0) {
                    print("Selected Birth Date: $p0");
                  }),
                  SizedBox(height: 20),
                  _buildTextField('Place of Birth', placeOfBirthController),
                  SizedBox(height: 20),
                  CustomDatePicker(controller: dobController, labelText: 'Date of Admission', onDateSelected: (p0) {
                    print("Selected Admission Date: $p0");
                  }),
                  SizedBox(height: 20),
                  _buildTextField('Class ID', classIDController),
                  SizedBox(height: 20),
                  _buildTextField('Section', sectionController),
                  SizedBox(height: 20),
                  _buildTextField('Previous School', previousSchoolController),
                  SizedBox(height: 20),
                  _buildTextField('Reason of Leaving', reasonOfLeavingController),
                  SizedBox(height: 20),
                  _buildTextField('Reference', referenceController),
                  SizedBox(height: 20),
                  _buildTextField('Complete Address', addressController),
                  SizedBox(height: 20),
                  _buildTextField('Roll No', rollNoController),
                  SizedBox(height: 10),
                  _buildConcessionField('Concession Percentage', concessionInPercent, (value) {
                    concessionInPercent = value;
                  }),
                  SizedBox(height: 20),
                  _buildConcessionField('Concession in PKR', concessionInPKR, (value) {
                    concessionInPKR = value;
                  }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the updated values to the student object
                student.firstName = firstNameController.text;
                student.lastName = lastNameController.text;
                student.gender = genderController.text;
                student.dateOfBirth = dobController.text;
                student.placeOfBirth = placeOfBirthController.text;
                student.dateOfAdmission = admissionDateController.text;
                student.photoLink = photoLinkController.text;
                student.classID = classIDController.text;
                student.section = sectionController.text;
                student.previousSchoolName = previousSchoolController.text;
                student.reasonOfLeaving = reasonOfLeavingController.text;
                student.reference = referenceController.text;
                student.completeAddress = addressController.text;
                student.rollNo = rollNoController.text;
                student.concessionInPercent = concessionInPercent;
                student.concessionInPKR = concessionInPKR;

                // If there's a selected image, set the photo link to the image path
                if (selectedImage != null) {
                  student.photoLink = selectedImage!.path;
                }

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, TextEditingController controller) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      onChanged: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildConcessionField(String label, double? value, Function(double) onChanged) {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: value?.toString(),
      onChanged: (val) {
        onChanged(double.tryParse(val) ?? 0);
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}


// Helper to build text fields
  Widget _buildTextField(String label, TextEditingController controller, {TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Helper to build dropdown fields
  Widget _buildDropdownField(String label, List<String> options, TextEditingController controller) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      onChanged: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Helper to build the concession fields
  Widget _buildConcessionField(String label, double? value, Function(double) onChanged) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (text) {
        onChanged(double.tryParse(text) ?? 0.0);
      },
      controller: TextEditingController(text: value != null ? value.toString() : ''),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

