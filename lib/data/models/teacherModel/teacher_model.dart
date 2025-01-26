import 'package:hive/hive.dart';
import 'package:school/data/models/salary_model.dart';

class TeacherModel {
  String? teacherId;

  String? teacherFirstName;

  String? teacherLastName;

  String? qualification;

  List<String>? teacherSubjectIDs;

  String? dateOfJoining;

  String? teacherAddress;

  String? teacherPhoneNumber;

  String? teacherEmail;
  String? subject;
  String? salaryTier;

  Map<String, Salary>? salaries;

  String? teacherNic;

  TeacherModel({
    this.salaries,
    this.teacherNic = "",
    this.dateOfJoining = "",
    this.qualification = "",
    this.salaryTier = "",
    this.teacherSubjectIDs = const [],
    this.teacherAddress = "",
    this.teacherEmail = "",
    this.teacherFirstName = "",
    this.teacherId = "",
    this.subject="",
    this.teacherLastName = "",
    this.teacherPhoneNumber = "",
  });
}
