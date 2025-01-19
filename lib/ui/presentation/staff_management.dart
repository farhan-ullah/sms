import 'package:flutter/material.dart';


class StaffManagement extends StatefulWidget {
  const StaffManagement({super.key});

  @override
  State<StaffManagement> createState() => _StaffManagementState();
}

class _StaffManagementState extends State<StaffManagement> {
  // List of staff members with sample data
  List<Map<String, String>> staffMembers = [
    {'name': 'John Doe', 'role': 'Admin', 'email': 'johndoe@email.com', 'phone': '123-456-7890', 'department': 'Management'},
    {'name': 'Jane Smith', 'role': 'Teacher', 'email': 'janesmith@email.com', 'phone': '987-654-3210', 'department': 'Math'},
    {'name': 'Alice Brown', 'role': 'Accountant', 'email': 'alicebrown@email.com', 'phone': '555-666-7777', 'department': 'Finance'},
  ];

  // Search Controller
  final TextEditingController _searchController = TextEditingController();

  // Form Key and Controllers for adding new staff members
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  String _selectedRole = 'Teacher';

  // Function to add a new staff member
  void _addStaffMember() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        staffMembers.add({
          'name': _nameController.text,
          'role': _selectedRole,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'department': _departmentController.text,
        });
      });

      // Clear the form fields and close the bottom sheet
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _departmentController.clear();
      Navigator.pop(context);
    }
  }

  // Group staff members by roles for better categorization
  Map<String, List<Map<String, String>>> getGroupedStaffMembers() {
    Map<String, List<Map<String, String>>> groupedStaff = {};
    for (var staff in staffMembers) {
      if (!groupedStaff.containsKey(staff['role'])) {
        groupedStaff[staff['role'] ?? ""] = [];
      }
      groupedStaff[staff['role']]!.add(staff);
    }
    return groupedStaff;
  }

  // Filter staff by search term
  List<Map<String, String>> _filterStaffMembers(String query) {
    if (query.isEmpty) {
      return staffMembers;
    } else {
      return staffMembers
          .where((staff) =>
      staff['name']!.toLowerCase().contains(query.toLowerCase()) ||
          staff['role']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> groupedStaff = getGroupedStaffMembers();
    List<Map<String, String>> filteredStaff = _filterStaffMembers(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Management'),
        actions: [
          // Button to show the bottom sheet for adding new staff members
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show the modal bottom sheet to add a staff member
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Allow scrollable content
                backgroundColor: Colors.transparent, // Transparent background to style it
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
                                'Add New Staff Member',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                              ),
                              const SizedBox(height: 10),

                              // Name Input
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(labelText: 'Staff Name', icon: Icon(Icons.person)),
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

                              // Add Staff Button
                              ElevatedButton(
                                onPressed: _addStaffMember,
                                child: const Text('Add Staff Member'),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by Name or Role',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            // Staff List (Filtered by search term and grouped by role)
            Expanded(
              child: ListView(
                children: filteredStaff.isEmpty
                    ? [const Center(child: Text('No staff found'))]
                    : groupedStaff.keys.map((role) {
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
                      ...groupedStaff[role]!.map((staff) {
                        return ListTile(
                          title: Text(staff['name']!),
                          subtitle: Text('${staff['email']} | ${staff['phone']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                staffMembers.remove(staff);
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
    );
  }
}
