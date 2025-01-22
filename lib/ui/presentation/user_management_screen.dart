
import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  // List of users with more attributes
  List<Map<String, String>> users = [
    {'name': 'John Doe', 'role': 'Admin', 'email': 'johndoe@email.com', 'phone': '123-456-7890', 'department': 'Management'},
    {'name': 'Jane Smith', 'role': 'Teacher', 'email': 'janesmith@email.com', 'phone': '987-654-3210', 'department': 'Math'},
    {'name': 'Alice Brown', 'role': 'Accountant', 'email': 'alicebrown@email.com', 'phone': '555-666-7777', 'department': 'Finance'},
  ];

  // Form Key and Controllers for adding users
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  String _selectedRole = 'Teacher';

  // Function to add a user
  void _addUser() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        users.add({
          'name': _nameController.text,
          'role': _selectedRole,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'department': _departmentController.text,
        });
      });
      // Clear the form fields
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _departmentController.clear();
      Navigator.pop(context);  // Close the bottom sheet after adding the user
    }
  }

  // Group users by roles
  Map<String, List<Map<String, String>>> getGroupedUsers() {
    Map<String, List<Map<String, String>>> groupedUsers = {};
    for (var user in users) {
      if (!groupedUsers.containsKey(user['role'])) {
        groupedUsers[user['role'] ?? ""] = [];
      }
      groupedUsers[user['role']]!.add(user);
    }
    return groupedUsers;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> groupedUsers = getGroupedUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User List (Classified by Role)
            Expanded(
              child: ListView(
                children: groupedUsers.keys.map((role) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          role,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...groupedUsers[role]!.map((user) {
                        return ListTile(
                          title: Text(user['name']!),
                          subtitle: Text('${user['email']} | ${user['phone']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                users.remove(user);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(    child: Icon(Icons.add),       onPressed: () {
      // Show the modal bottom sheet to add a user
      showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrollable content
      backgroundColor: Colors.transparent, // To allow custom decoration
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New User',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 10),

                    // Name Input
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'User Name', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Email Input
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
                      validator: (value) {
                        if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Phone Input
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone Number', icon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 10),

                    // Department Input
                    TextFormField(
                      controller: _departmentController,
                      decoration: const InputDecoration(labelText: 'Department', icon: Icon(Icons.business)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a department';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Role Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: const InputDecoration(labelText: 'Role', icon: Icon(Icons.work)),
                      items: const [
                        DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                        DropdownMenuItem(value: 'Teacher', child: Text('Teacher')),
                        DropdownMenuItem(value: 'Accountant', child: Text('Accountant')),
                        DropdownMenuItem(value: 'Student', child: Text('Student')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Add User Button
                    ElevatedButton(
                      onPressed: _addUser,
                      child: const Text('Add User'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  },
    ),
    );
  }
}
