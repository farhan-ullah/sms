import 'package:flutter/material.dart';

import '../../data/models/salary_model.dart';
import '../../data/models/staff_model.dart';
import '../../data/models/teacherModel/teacher_model.dart';

class StaffProvider extends ChangeNotifier {
  final List<StaffModel> _staffMembers = [
    StaffModel(
      id: '1',
      name: 'John Doe',
      role: 'Accountant',
      contactNumber: '123-456-7890',
      email: 'johndoe@email.com',
      salaryTier: 40000.0,
      department: 'Accounting',
      status: 'Active',
      hireDate: '2022-01-10',
      nic: '123456789V',
      salaries: {
        'January': Salary(
          id: 'S1',
          employeeId: '1',
          employeeName: 'John Doe',
          basicSalary: 40000.0,
          allowances: 5000.0,
          deductions: 1000.0,
          netSalary: 44000.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S2',
          employeeId: '1',
          employeeName: 'John Doe',
          basicSalary: 40000.0,
          allowances: 5000.0,
          deductions: 1000.0,
          netSalary: 44000.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    StaffModel(
      id: '2',
      name: 'Jane Smith',
      role: 'Librarian',
      contactNumber: '123-456-7891',
      email: 'janesmith@email.com',
      salaryTier: 35000.0,
      department: 'Library',
      status: 'Active',
      hireDate: '2021-11-20',
      nic: '987654321V',
      salaries: {
        'January': Salary(
          id: 'S3',
          employeeId: '2',
          employeeName: 'Jane Smith',
          basicSalary: 35000.0,
          allowances: 4000.0,
          deductions: 800.0,
          netSalary: 33600.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S4',
          employeeId: '2',
          employeeName: 'Jane Smith',
          basicSalary: 35000.0,
          allowances: 4000.0,
          deductions: 800.0,
          netSalary: 33600.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    StaffModel(
      id: '3',
      name: 'Michael Johnson',
      role: 'Canteen Manager',
      contactNumber: '123-456-7892',
      email: 'michaeljohnson@email.com',
      salaryTier: 30000.0,
      department: 'Canteen',
      status: 'Inactive',
      hireDate: '2019-05-15',
      nic: '112233445V',
      salaries: {
        'January': Salary(
          id: 'S5',
          employeeId: '3',
          employeeName: 'Michael Johnson',
          basicSalary: 30000.0,
          allowances: 3000.0,
          deductions: 1200.0,
          netSalary: 28200.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S6',
          employeeId: '3',
          employeeName: 'Michael Johnson',
          basicSalary: 30000.0,
          allowances: 3000.0,
          deductions: 1200.0,
          netSalary: 28200.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    StaffModel(
      id: '4',
      name: 'Emily Williams',
      role: 'HR Manager',
      contactNumber: '123-456-7893',
      email: 'emilywilliams@email.com',
      salaryTier: 50000.0,
      department: 'Human Resources',
      status: 'Active',
      hireDate: '2020-03-01',
      nic: '223344556V',
      salaries: {
        'January': Salary(
          id: 'S7',
          employeeId: '4',
          employeeName: 'Emily Williams',
          basicSalary: 50000.0,
          allowances: 6000.0,
          deductions: 1500.0,
          netSalary: 54500.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S8',
          employeeId: '4',
          employeeName: 'Emily Williams',
          basicSalary: 50000.0,
          allowances: 6000.0,
          deductions: 1500.0,
          netSalary: 54500.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    // Add more staff as needed
  ];

// Teacher data with salaries
  List<TeacherModel> mockTeacherListWithSalaries = [
    TeacherModel(
      teacherId: 'T1',
      teacherFirstName: 'John',
      teacherLastName: 'Doe',
      qualification: 'M.Sc Physics',
      teacherSubjectIDs: ['S1', 'S2'],
      dateOfJoining: '2015-06-01',
      teacherAddress: '123, Elm Street, Springfield',
      teacherPhoneNumber: '123-456-7890',
      teacherEmail: 'johndoe@example.com',
      salaryTier: 'Tier 3',
      teacherNic: '12345-67890',
      salaries: {
        'January': Salary(
          id: 'S1',
          employeeId: 'T1',
          employeeName: 'John Doe',
          basicSalary: 30000.0,
          allowances: 5000.0,
          deductions: 1000.0,
          netSalary: 34000.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S2',
          employeeId: 'T1',
          employeeName: 'John Doe',
          basicSalary: 30000.0,
          allowances: 5000.0,
          deductions: 1000.0,
          netSalary: 34000.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    TeacherModel(
      teacherId: 'T2',
      teacherFirstName: 'Jane',
      teacherLastName: 'Smith',
      qualification: 'M.A English Literature',
      teacherSubjectIDs: ['S3', 'S4'],
      dateOfJoining: '2016-09-15',
      teacherAddress: '456, Oak Avenue, Springfield',
      teacherPhoneNumber: '234-567-8901',
      teacherEmail: 'janesmith@example.com',
      salaryTier: 'Tier 2',
      teacherNic: '23456-78901',
      salaries: {
        'January': Salary(
          id: 'S3',
          employeeId: 'T2',
          employeeName: 'Jane Smith',
          basicSalary: 27000.0,
          allowances: 4000.0,
          deductions: 1200.0,
          netSalary: 29600.0,
          month: 'January',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
        'February': Salary(
          id: 'S4',
          employeeId: 'T2',
          employeeName: 'Jane Smith',
          basicSalary: 27000.0,
          allowances: 4000.0,
          deductions: 1200.0,
          netSalary: 29600.0,
          month: 'February',
          year: '2025',
          generatedAt: DateTime.now(),
        ),
      },
    ),
    // Add more teachers as needed
  ];


  List<StaffModel> get staffMembers => _staffMembers;

  // Add new staff
  void addStaff(StaffModel staff) {
    _staffMembers.add(staff);
    notifyListeners();
  }

  // Edit existing staff
  void editStaff(String id, StaffModel updatedStaff) {
    int index = _staffMembers.indexWhere((staff) => staff.id == id);
    if (index != -1) {
      _staffMembers[index] = updatedStaff;
      notifyListeners();
    }
  }

  // Delete staff
  void deleteStaff(String id) {
    _staffMembers.removeWhere((staff) => staff.id == id);
    notifyListeners();
  }

  // Filter active/inactive staff
  List<StaffModel> filterByStatus(String status) {
    return _staffMembers.where((staff) => staff.status == status).toList();
    }
}
