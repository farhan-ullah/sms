import 'package:flutter/material.dart';
import '../../data/models/salary_model.dart';


class SalaryProvider extends ChangeNotifier {
  List<Salary> _salaryRecords = [];

  List<Salary> get salaryRecords => _salaryRecords;

  // Add a new salary record
  void generateSalary(Salary salary) {
    _salaryRecords.add(salary);
    notifyListeners();
  }

  // Get salary history of an employee by ID
  List<Salary> getSalaryHistory(String employeeId) {
    return _salaryRecords.where((salary) => salary.employeeId == employeeId).toList();
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
