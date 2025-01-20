import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/staff_provider.dart';
import '../../../data/models/staff_model.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var staffProvider = Provider.of<StaffProvider>(context);
    var staffList = staffProvider.staffMembers;

    // Extract unique departments and roles from the staff list
    List<String> departments = staffList
        .map((staff) => staff.department)
        .toSet()
        .toList(); // Convert to Set to get unique values and then back to List
    List<String> roles = staffList
        .map((staff) => staff.role)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search & Filter
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Staff',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Implement search functionality if needed
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: staffList.length,
                itemBuilder: (context, index) {
                  StaffModel staff = staffList[index];
                  return ListTile(
                    title: Text(staff.name),
                    subtitle: Text(staff.role),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement edit functionality if needed
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            staffProvider.deleteStaff(staff.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog to add a new staff member
          _showAddStaffDialog(context, staffProvider, departments, roles);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Method to show the dialog for adding new staff
  void _showAddStaffDialog(BuildContext context, StaffProvider staffProvider, List<String> departments, List<String> roles) {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String role = '';
    String contactNumber = '';
    String email = '';
    double salary = 0.0;
    String department = '';
    String status = '';
    String hireDate = '';
    String nic = '';

    // Predefined statuses
    List<String> statuses = ['Active', 'Inactive', 'On Leave'];

    // Date selection state
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Staff'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView( // Add scroll view to handle keyboard
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Staff Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 10),

                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: role.isEmpty ? null : role,
                    onChanged: (value) {
                      role = value!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: Icon(Icons.work),
                    ),
                    items: roles.map((r) {
                      return DropdownMenuItem<String>(
                        value: r,
                        child: Text(r),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Contact Number
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a contact number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      contactNumber = value;
                    },
                  ),
                  SizedBox(height: 10),

                  // Email
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 10),

                  // Salary
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      prefixIcon: Icon(Icons.monetization_on),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty || double.tryParse(value) == null) {
                        return 'Please enter a valid salary';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      salary = double.tryParse(value) ?? 0.0;
                    },
                  ),
                  SizedBox(height: 10),

                  // Department Dropdown
                  DropdownButtonFormField<String>(
                    value: department.isEmpty ? null : department,
                    onChanged: (value) {
                      department = value!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Department',
                      prefixIcon: Icon(Icons.business),
                    ),
                    items: departments.map((dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a department';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Status Dropdown
                  DropdownButtonFormField<String>(
                    value: status.isEmpty ? null : status,
                    onChanged: (value) {
                      status = value!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Status',
                      prefixIcon: Icon(Icons.info),
                    ),
                    items: statuses.map((stat) {
                      return DropdownMenuItem<String>(
                        value: stat,
                        child: Text(stat),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a status';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Hire Date Picker
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hire Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        selectedDate = pickedDate;
                        hireDate = "${selectedDate.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
                      }
                    },
                    controller: TextEditingController(text: hireDate.isEmpty ? 'Select Hire Date' : hireDate),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a hire date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // NIC
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'NIC',
                      prefixIcon: Icon(Icons.card_membership),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter NIC';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      nic = value;
                    },
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
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Create a new StaffModel object
                  final newStaff = StaffModel(
                    id: DateTime.now().toString(), // Generate a unique ID (or use your preferred method)
                    name: name,
                    role: role,
                    contactNumber: contactNumber,
                    email: email,
                    salaryTier: salary,
                    department: department,
                    status: status,
                    hireDate: hireDate,
                    nic: nic,
                  );
                  staffProvider.addStaff(newStaff); // Add the new staff to the provider
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
