import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/staff_provider.dart';

import '../../../data/models/staff_model.dart';
import '../../../data/models/teacherModel/teacher_model.dart';

class SalaryPaymentScreen extends StatefulWidget {
  const SalaryPaymentScreen({super.key});

  @override
  _SalaryPaymentScreenState createState() => _SalaryPaymentScreenState();
}

class _SalaryPaymentScreenState extends State<SalaryPaymentScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // Default values for selected month and year
  String selectedMonth = 'January';
  String selectedYear = '2025';

  // List of months and years for the dropdowns
  final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final List<String> years = ['2025', '2024', '2023', '2022', '2021']; // You can add more years if needed.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Two tabs: Staff, Teachers
  }

  void _markAsPaid(dynamic employee, String month) {
    setState(() {
      if (employee is StaffModel) {
        employee.salaries?[month]?.netSalary = employee.salaries?[month]?.netSalary ?? 0.0; // Mark as paid
        employee.salaries?[month]?.isPaid = true; // Mark as paid
      } else if (employee is TeacherModel) {
        employee.salaries?[month]?.netSalary = employee.salaries?[month]?.netSalary ?? 0.0; // Mark as paid
        employee.salaries?[month]?.isPaid = true; // Mark as paid
      }
    });
  }

  void _downloadPayslip(dynamic employee, String month) {
    // Logic to download payslip
    if (employee is StaffModel) {
      print('Downloading Payslip for ${employee.name} for $month');
    } else if (employee is TeacherModel) {
      print('Downloading Payslip for ${employee.teacherFirstName} ${employee.teacherLastName} for $month');
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Payment"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Staff'),
            Tab(text: 'Teachers'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Month and Year Selection Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Month Dropdown
                DropdownButton<String>(
                  value: selectedMonth,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  items: months.map<DropdownMenuItem<String>>((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),

                // Year Dropdown
                DropdownButton<String>(
                  value: selectedYear,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                  items: years.map<DropdownMenuItem<String>>((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Staff Tab
                ListView.builder(
                  itemCount: staffProvider.staffMembers.length,
                  itemBuilder: (context, index) {
                    final staff = staffProvider.staffMembers[index];
                    return ListTile(
                      title: Text(staff.name),
                      subtitle: Text(staff.role),
                      trailing: (staff.salaries?[selectedMonth]?.isPaid ?? false) // Check if paid
                          ? ElevatedButton(
                        onPressed: () => _downloadPayslip(staff, selectedMonth),
                        child: Text("Download Payslip"),
                      )
                          : ElevatedButton(
                        onPressed: () => _markAsPaid(staff, selectedMonth),
                        child: Text("Pay"),
                      ),
                    );
                  },
                ),

                // Teachers Tab
                ListView.builder(
                  itemCount: staffProvider.mockTeacherListWithSalaries.length,
                  itemBuilder: (context, index) {
                    final teacher = staffProvider.mockTeacherListWithSalaries[index];
                    return ListTile(
                      title: Text("${teacher.teacherFirstName} ${teacher.teacherLastName}"),
                      subtitle: Text(teacher.qualification.toString()),
                      trailing: (teacher.salaries?[selectedMonth]?.isPaid ?? false) // Check if paid
                          ? ElevatedButton(
                        onPressed: () => _downloadPayslip(teacher, selectedMonth),
                        child: Text("Download Payslip"),
                      )
                          : ElevatedButton(
                        onPressed: () => _markAsPaid(teacher, selectedMonth),
                        child: Text("Pay"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
