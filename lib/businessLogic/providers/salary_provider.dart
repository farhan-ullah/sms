import 'package:flutter/material.dart';
import '../../data/models/salary_model.dart';




class SalaryTier {
  final String role;
  final double salary;

  SalaryTier({required this.role, required this.salary});
}

// Creating dummy data for salary tiers
class SalaryProvider extends ChangeNotifier {
  List<Salary> _salaryRecords = [];
  List<SalaryTier> dummySalaryTiers = [
    SalaryTier(role: "Teacher", salary: 30000.0),
    SalaryTier(role: "Accountant", salary: 40000.0),
    SalaryTier(role: "Librarian", salary: 35000.0),
    SalaryTier(role: "Canteen Manager", salary: 25000.0),
    SalaryTier(role: "HR Manager", salary: 50000.0),
    SalaryTier(role: "Security Officer", salary: 28000.0),
    SalaryTier(role: "IT Specialist", salary: 45000.0),
    SalaryTier(role: "Cleaner", salary: 20000.0),
    SalaryTier(role: "Receptionist", salary: 32000.0),
    SalaryTier(role: "Maintenance Technician", salary: 35000.0),
    SalaryTier(role: "Marketing Manager", salary: 60000.0),
  ];

  // Getter for salary history (this will be used to fetch all salaries for a given employee)
  List<Salary> getSalaryHistory(String employeeId) {
    return _salaryRecords.where((salary) => salary.employeeId == employeeId).toList();
  }

  // Dummy method to create a new salary
  void createNewSalary(Salary salary) {
    // Simulate saving the salary to the list
    _salaryRecords.add(salary);

    // Notify listeners that the salary history has been updated
    notifyListeners();
  }
  List<Salary> get salaryRecords => _salaryRecords;

  // Add a new salary record
  void generateSalary(Salary salary) {
    _salaryRecords.add(salary);
    notifyListeners();
  }


  // Generate a report for a specific month and year
  List<Salary> generateSalaryReport(String month, String year) {
    return _salaryRecords.where((salary) => salary.month == month && salary.year == year).toList();
  }

  // Get payslip for a specific salary
  Map<String, dynamic> generatePayslip(String employeeId, String month, String year) {
    Salary salary = _salaryRecords.firstWhere((s) => s.employeeId == employeeId && s.month == month && s.year == year);
    return salary.generatePayslip();
    }
}
