import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/student_model/student_model.dart';

class ViewStudentScreen extends StatefulWidget {
  const ViewStudentScreen({super.key});

  @override
  State<ViewStudentScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ViewStudentScreen> {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    List<StudentModel> students = studentProvider.mockStudentList;

    // Show a debug snackbar (you can toggle this for debugging purposes)
    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Loaded ${students.length} students."),
          duration: Duration(seconds: 2),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showStudentDetails(context, students[index]);
            },
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                child: Row(
                  children: [
                    // Profile Picture with a fallback placeholder
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: students[index].photoLink != null
                          ? Image.network(
                        students[index].photoLink!,
                        width: 50, // Reduced size of the image
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
                            '${students[index].firstName} ${students[index].lastName}',
                            style: const TextStyle(
                              fontSize: 16, // Reduced font size
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Student ID
                          Text(
                            'ID: ${students[index].studentId}',
                            style: TextStyle(
                              fontSize: 12, // Reduced font size
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Class & Section
                          Row(
                            children: [
                              Text(
                                'Class: ${students[index].classID}',
                                style: TextStyle(
                                  fontSize: 12, // Reduced font size
                                  color: Colors.blueGrey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Section: ${students[index].section}',
                                style: TextStyle(
                                  fontSize: 12, // Reduced font size
                                  color: Colors.blueGrey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow icon to indicate tap action
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey[600],
                      size: 20, // Reduced icon size
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to show student details in a new screen or dialog
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
}
