import 'package:school/data/models/salary_model.dart';

class StaffModel {
  String id;
  String name;
  String role;
  String contactNumber;
  String email;
  double salaryTier;
  Map<String, Salary>? salaries;
  String department;
  String status;
  String hireDate;
  String nic;

  StaffModel({
    this.salaries,
    required this.nic,
  required this.id,
  required this.name,
  required this.role,
  required this.contactNumber,
  required this.email,
  required this.salaryTier,
  required this.department,
  required this.status,
  required this.hireDate,
  });
}
