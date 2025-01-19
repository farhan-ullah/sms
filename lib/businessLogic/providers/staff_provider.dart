import 'package:flutter/material.dart';

import '../../data/models/staff_model.dart';

class StaffProvider extends ChangeNotifier {
  final List<StaffModel> _staffMembers = [
    StaffModel(
      id: '1',
      name: 'John Doe',
      role: 'Accountant',
      contactNumber: '123-456-7890',
      email: 'johndoe@email.com',
      salary: 40000.0,
      department: 'Accounting',
      status: 'Active',
      hireDate: '2022-01-10',
      nic: '123456789V',
    ),
    StaffModel(
      id: '2',
      name: 'Jane Smith',
      role: 'Librarian',
      contactNumber: '123-456-7891',
      email: 'janesmith@email.com',
      salary: 35000.0,
      department: 'Library',
      status: 'Active',
      hireDate: '2021-11-20',
      nic: '987654321V',
    ),
    StaffModel(
      id: '3',
      name: 'Michael Johnson',
      role: 'Canteen Manager',
      contactNumber: '123-456-7892',
      email: 'michaeljohnson@email.com',
      salary: 30000.0,
      department: 'Canteen',
      status: 'Inactive',
      hireDate: '2019-05-15',
      nic: '112233445V',
    ),
    StaffModel(
      id: '4',
      name: 'Emily Williams',
      role: 'HR Manager',
      contactNumber: '123-456-7893',
      email: 'emilywilliams@email.com',
      salary: 50000.0,
      department: 'Human Resources',
      status: 'Active',
      hireDate: '2020-03-01',
      nic: '223344556V',
    ),
    StaffModel(
      id: '5',
      name: 'William Brown',
      role: 'Security Officer',
      contactNumber: '123-456-7894',
      email: 'williambrown@email.com',
      salary: 28000.0,
      department: 'Security',
      status: 'Active',
      hireDate: '2018-07-22',
      nic: '334455667V',
    ),
    StaffModel(
      id: '6',
      name: 'Sophia Davis',
      role: 'IT Specialist',
      contactNumber: '123-456-7895',
      email: 'sophiadavis@email.com',
      salary: 45000.0,
      department: 'IT',
      status: 'Active',
      hireDate: '2021-06-11',
      nic: '445566778V',
    ),
    StaffModel(
      id: '7',
      name: 'Chris Martinez',
      role: 'Cleaner',
      contactNumber: '123-456-7896',
      email: 'chrismartinez@email.com',
      salary: 20000.0,
      department: 'Cleaning',
      status: 'Active',
      hireDate: '2023-01-05',
      nic: '556677889V',
    ),
    StaffModel(
      id: '8',
      name: 'Olivia Taylor',
      role: 'Receptionist',
      contactNumber: '123-456-7897',
      email: 'oliviataylor@email.com',
      salary: 32000.0,
      department: 'Front Desk',
      status: 'Active',
      hireDate: '2022-10-17',
      nic: '667788990V',
    ),
    StaffModel(
      id: '9',
      name: 'Jack Wilson',
      role: 'Maintenance Technician',
      contactNumber: '123-456-7898',
      email: 'jackwilson@email.com',
      salary: 35000.0,
      department: 'Maintenance',
      status: 'Inactive',
      hireDate: '2017-04-12',
      nic: '778899001V',
    ),
    StaffModel(
      id: '10',
      name: 'Ava Moore',
      role: 'Marketing Manager',
      contactNumber: '123-456-7899',
      email: 'avamoore@email.com',
      salary: 60000.0,
      department: 'Marketing',
      status: 'Active',
      hireDate: '2019-09-30',
      nic: '889900112V',
    ),
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
