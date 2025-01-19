import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/parent_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/student_model/student_model.dart';
import '../../../data/models/parentModel/parent_model.dart';
import '../new_widgets/custom_text_field.dart';
import '../new_widgets/email_custom_field.dart';
import '../new_widgets/nic_text_field.dart';
import '../widgets/custom_date_picker.dart';

class ParentsScreen extends StatefulWidget {
  const ParentsScreen({super.key});

  @override
  State<ParentsScreen> createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context);
    List<ParentModel> parents = parentProvider.mockParentList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Parents List'),
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddParentDialog();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: parents.length,
          itemBuilder: (context, index) {
            final parent = parents[index];
            List<String>? childrenIDsList = parent.childrenIDs;

            return Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                onTap: () {
                  _showParentProfile(context, parent);
                },
                leading: Icon(Icons.person, size: 40, color: Colors.blueAccent),
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        parent.firstName!.substring(0, 1),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${parent.firstName} ${parent.lastName}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    _buildInfoRow(Icons.email_outlined, parent.email ?? "No email provided"),
                    SizedBox(height: 8),
                    _buildInfoRow(Icons.phone_outlined, parent.phoneNumber ?? "No phone number"),
                    SizedBox(height: 8),
                    _buildInfoRow(Icons.credit_card, parent.nic ?? "No NIC available"),
                  ],
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        _showUpdateParentDialog(context, parent, parent.childrenIDs);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (parent.childrenIDs != null && parent.childrenIDs!.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cannot delete parent with children'), backgroundColor: Colors.orange));
                        } else {
                          parentProvider.mockParentList.remove(parent);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${parent.firstName} ${parent.lastName} deleted'), backgroundColor: Colors.green));
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Row _buildInfoRow(IconData icon, String infoText) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            infoText,
            style: TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<void> _showParentProfile(BuildContext context, ParentModel parent) async {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    List<StudentModel> students = parent.childrenIDs != null
        ? parent.childrenIDs!.map((studentId) => studentProvider.mockStudentList.firstWhere((student) => student.studentId == studentId)).toList()
        : [];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${parent.firstName} ${parent.lastName} - Profile'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Parent Profile Details
                _buildSectionTitle('Parent Information'),
                _buildProfileRow(Icons.person, 'Name: ${parent.firstName} ${parent.lastName}'),
                _buildProfileRow(Icons.phone_outlined, 'Phone: ${parent.phoneNumber ?? "N/A"}'),
                _buildProfileRow(Icons.email_outlined, 'Email: ${parent.email ?? "N/A"}'),
                _buildProfileRow(Icons.credit_card, 'NIC: ${parent.nic ?? "N/A"}'),
                _buildProfileRow(Icons.home, 'Address: ${parent.completeAddress ?? "N/A"}'), // Added Address

                SizedBox(height: 20),

                // Children List Section
                if (students.isNotEmpty) ...[
                  _buildSectionTitle('Children'),
                  ...students.map((student) => _buildProfileRow(Icons.child_care, '${student.firstName} ${student.lastName}')).toList(),
                ] else ...[
                  _buildProfileRow(Icons.child_care, 'No children linked yet'),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Row _buildProfileRow(IconData icon, String infoText) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 24),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            infoText,
            style: TextStyle(fontSize: 16, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueAccent),
      ),
    );
  }

  Future<void> _showUpdateParentDialog(BuildContext context, ParentModel parent, List<String>? childrenIDs) async {
    final TextEditingController _firstNameController = TextEditingController(text: parent.firstName);
    final TextEditingController _lastNameController = TextEditingController(text: parent.lastName);
    final TextEditingController _phoneNumberController = TextEditingController(text: parent.phoneNumber);
    final TextEditingController _emailController = TextEditingController(text: parent.email);
    final TextEditingController _nicController = TextEditingController(text: parent.nic);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Parent Details'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfield(controller: _firstNameController, labelText: 'First Name'),
                  CustomTextfield(controller: _lastNameController, labelText: 'Last Name'),
                  SizedBox(height: 10),
                  CustomTextfield(controller: _phoneNumberController, labelText: 'Phone Number'),
                  EmailCustomTextfield(controller: _emailController),
                  SizedBox(height: 10),
                  NicTextField(controller: _nicController),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedParent = ParentModel(
                  parentId: parent.parentId,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phoneNumber: _phoneNumberController.text,
                  email: _emailController.text,
                  childrenIDs: childrenIDs,
                  nic: _nicController.text,
                );

                final parentProvider = Provider.of<ParentProvider>(context, listen: false);
                parentProvider.updateParent(updatedParent);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Parent details updated!'), backgroundColor: Colors.green),
                );

                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }


  void _showAddParentDialog() {
    // Show a dialog to add a new parent (details omitted for brevity)
  }
}
