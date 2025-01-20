import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../businessLogic/providers/staff_provider.dart';
import '../../../data/models/staff_model.dart';
import '../../../data/models/teacherModel/teacher_model.dart';

class SalaryReportScreen extends StatefulWidget {
  const SalaryReportScreen({super.key});

  @override
  _SalaryReportScreenState createState() => _SalaryReportScreenState();
}

class _SalaryReportScreenState extends State<SalaryReportScreen> {
  // Search controller and query for searching employee names
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // Date Range Selection
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  // Search functionality based on name
  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text.toLowerCase();
    });
  }

  // Apply search filter for employees
  List<dynamic> _applySearch(List<dynamic> employees) {
    return employees.where((employee) {
      if (employee is StaffModel) {
        return employee.name.toLowerCase().contains(searchQuery);
      } else if (employee is TeacherModel) {
        return '${employee.teacherFirstName} ${employee.teacherLastName}'.toLowerCase().contains(searchQuery);
      }
      return false;
    }).toList();
  }

  // Show the Date Picker to select the start date
  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedStartDate = pickedDate;
      });
    }
  }

  // Show the Date Picker to select the end date
  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedEndDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Salary Report"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh the report or reset filters
              setState(() {
                _searchController.clear();
                selectedStartDate = null;
                selectedEndDate = null;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Employees...',
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Date Range Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _selectStartDate(context),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        selectedStartDate == null
                            ? 'Select Start Date'
                            : DateFormat('MM/dd/yyyy').format(selectedStartDate!),
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => _selectEndDate(context),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        selectedEndDate == null
                            ? 'Select End Date'
                            : DateFormat('MM/dd/yyyy').format(selectedEndDate!),
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Employee List
            Expanded(
              child: ListView.builder(
                itemCount: _applySearch(staffProvider.staffMembers).length,
                itemBuilder: (context, index) {
                  final employee = _applySearch(staffProvider.staffMembers)[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(employee.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(employee.role, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Action on click (e.g., view report or generate payslip)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Viewing report for ${employee.name}")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("View Report", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
