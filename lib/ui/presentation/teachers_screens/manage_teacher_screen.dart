import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import '../../../businessLogic/providers/teacher_provider.dart';
import '../new_widgets/custom_text_field.dart';
import '../new_widgets/email_custom_field.dart';
import '../new_widgets/nic_text_field.dart';
import '../widgets/custom_date_picker.dart';

class ManageTeacherScreen extends StatefulWidget {
  const ManageTeacherScreen({super.key});

  @override
  State<ManageTeacherScreen> createState() => _ManageTeacherScreenState();
}

class _ManageTeacherScreenState extends State<ManageTeacherScreen> {

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Teachers'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900], // Modern color
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add Teacher functionality can be implemented here.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: teacherProvider.mockTeacherList.length,
          itemBuilder: (context, index) {
            final teacher = teacherProvider.mockTeacherList[index];
            return TeacherTile(teacher: teacher);
          },
        ),
      ),
    );
  }
}

class TeacherTile extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherTile({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        onTap: () {
          Widget _buildInfoRow(String label, String value) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      '$label:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );}          showDialog(
            context: context,
            builder: (context) {
              final subjectProvider = Provider.of<SubjectProvider>(context);
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners for the dialog
                ),
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 500,
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with bold text and custom color
                        Text(
                          "Teacher Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Personal information section
                        _buildInfoRow("Name:", "${teacher.teacherFirstName} ${teacher.teacherLastName}"),
                        _buildInfoRow("Phone:", teacher.teacherPhoneNumber.toString()),
                        _buildInfoRow("Email:", teacher.teacherEmail.toString()),
                        _buildInfoRow("Qualification:", teacher.qualification.toString()),
                        _buildInfoRow("Salary Tier:", teacher.salaryTier.toString()),
                        _buildInfoRow("Date of Joining:", teacher.dateOfJoining.toString()),
                        _buildInfoRow("Address:", teacher.teacherAddress.toString()),
                        _buildInfoRow("NIC:", teacher.teacherNic.toString()),

                        const SizedBox(height: 20),

                        // Button with custom styling
                        ElevatedButton(
                          onPressed: () {
                            showSubjectsDialog(context, teacher.teacherSubjectIDs ?? []);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[800], // Dark blue-grey background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          ),
                          child: Text(
                            'View Subjects',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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

        },
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.blueGrey[700],
              child: Text(
                '${teacher.teacherFirstName?[0]}${teacher.teacherLastName?[0]}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${teacher.teacherFirstName} ${teacher.teacherLastName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('${teacher.qualification}', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.blueGrey),
              onPressed: () {
                _showTeacherOptionsMenu(context, teacher);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTeacherOptionsMenu(BuildContext context, TeacherModel teacher) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Teacher Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blueGrey),
                title: Text("Edit Teacher", style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _showUpdateTeacherDialog(context, teacher);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("Delete Teacher", style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _deleteTeacher(context, teacher);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTeacher(BuildContext context, TeacherModel teacher) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${teacher.teacherFirstName} ${teacher.teacherLastName} deleted')),
    );
  }

  void _showUpdateTeacherDialog(BuildContext context, TeacherModel teacher) {
    final TextEditingController _firstNameController = TextEditingController(text: teacher.teacherFirstName);
    final TextEditingController _lastNameController = TextEditingController(text: teacher.teacherLastName);
    final TextEditingController _phoneNumberController = TextEditingController(text: teacher.teacherPhoneNumber);
    final TextEditingController _emailController = TextEditingController(text: teacher.teacherEmail);
    final TextEditingController _addressController = TextEditingController(text: teacher.teacherAddress);
    final TextEditingController _qualificationController = TextEditingController(text: teacher.qualification);
    final TextEditingController _nicController = TextEditingController(text: teacher.teacherNic);
    final TextEditingController _dateOfJoiningController = TextEditingController(text: teacher.dateOfJoining);
    final TextEditingController _salaryTierController = TextEditingController(text: teacher.salaryTier);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Teacher Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          controller: _firstNameController,
                          labelText: 'First Name',
                        ),
                      ),
                      Expanded(
                        child: CustomTextfield(
                          controller: _lastNameController,
                          labelText: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          controller: _phoneNumberController,
                          labelText: 'Phone Number',
                        ),
                      ),
                      Expanded(
                        child: EmailCustomTextfield(
                          controller: _emailController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          controller: _qualificationController,
                          labelText: 'Qualification',
                        ),
                      ),
                      Expanded(
                        child: CustomTextfield(
                          controller: _nicController,
                          labelText: 'NIC',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  CustomTextfield(
                    controller: _addressController,
                    labelText: 'Address',
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                          controller: _dateOfJoiningController,
                          labelText: 'Date of Joining',
                          onDateSelected: (selectedDate) {
                            _dateOfJoiningController.text = selectedDate;
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextfield(
                          controller: _salaryTierController,
                          labelText: 'Salary Tier',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedTeacher = TeacherModel(
                  teacherId: teacher.teacherId,
                  teacherFirstName: _firstNameController.text,
                  teacherLastName: _lastNameController.text,
                  teacherPhoneNumber: _phoneNumberController.text,
                  teacherEmail: _emailController.text,
                  teacherAddress: _addressController.text,
                  qualification: _qualificationController.text,
                  teacherNic: _nicController.text,
                  dateOfJoining: _dateOfJoiningController.text,
                  salaryTier: _salaryTierController.text,
                );

                final teacherProvider = Provider.of<TeacherProvider>(context, listen: false);
                teacherProvider.updateTeacher(updatedTeacher);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Teacher details updated!')),
                );

                Navigator.of(context).pop();
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void showSubjectsDialog(BuildContext context, List<String> subjectIDs) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Subjects'),
          content: SizedBox(
            height: 300,width: 300,
            child: ListView.builder(
              itemCount: subjectIDs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Subject ID: ${subjectIDs[index]}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
