import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/staff_provider.dart';
import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/staff_model.dart';
import '../../../data/models/teacherModel/teacher_model.dart';
import '../../../data/models/salary_model.dart';

class SalaryGenerationScreen extends StatefulWidget {
  @override
  _SalaryGenerationScreenState createState() => _SalaryGenerationScreenState();
}

class _SalaryGenerationScreenState extends State<SalaryGenerationScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // Search controller and filter
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _markAsPaid(dynamic employee, String month) {
    setState(() {
      if (employee is StaffModel) {
        employee.salaries?[month]?.netSalary = employee.salaries?[month]?.netSalary ?? 0.0;
        employee.salaries?[month]?.isPaid = true;
      } else if (employee is TeacherModel) {
        employee.salaries?[month]?.netSalary = employee.salaries?[month]?.netSalary ?? 0.0;
        employee.salaries?[month]?.isPaid = true;
      }
    });
  }

  void _downloadPayslip(dynamic employee, String month) {
    if (employee is StaffModel) {
      print('Downloading Payslip for ${employee.name} for $month');
    } else if (employee is TeacherModel) {
      print('Downloading Payslip for ${employee.teacherFirstName} ${employee.teacherLastName} for $month');
    }
  }

  // Apply search filter to the list
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

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    final salaryProvider = Provider.of<SalaryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Salary Generation"),
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
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Employees...',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              ),
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Staff Tab
                ListView.builder(
                  itemCount: _applySearch(staffProvider.staffMembers).length,
                  itemBuilder: (context, index) {
                    final staff = _applySearch(staffProvider.staffMembers)[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(staff.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(staff.role),
                        trailing: (staff.salaries?['January']?.isPaid ?? false)
                            ? ElevatedButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Salary Generated Already"))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Salary Generated"),
                        )
                            : ElevatedButton(
                          onPressed: () => _markAsPaid(staff, 'January'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Generate Salary"),
                        ),
                      ),
                    );
                  },
                ),

                // Teachers Tab
                ListView.builder(
                  itemCount: _applySearch(staffProvider.mockTeacherListWithSalaries).length,
                  itemBuilder: (context, index) {
                    final teacher = _applySearch(staffProvider.mockTeacherListWithSalaries)[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text("${teacher.teacherFirstName} ${teacher.teacherLastName}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(teacher.qualification ?? ""),
                        trailing: (teacher.salaries?['January']?.isPaid ?? false)
                            ? ElevatedButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Salary Generated Already"))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Salary Generated"),
                        )
                            : ElevatedButton(
                          onPressed: () => _markAsPaid(teacher, 'January'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Generate Salary"),
                        ),
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
