import 'package:hive/hive.dart';


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

   String? salaryTier;

   String? teacherNic;

  TeacherModel({
    this.teacherNic="",
    this.dateOfJoining="",
    this.qualification="",
    this.salaryTier="",
    this.teacherSubjectIDs =const [],
    this.teacherAddress="",
    this.teacherEmail="",
    this.teacherFirstName="",
    this.teacherId="",
    this.teacherLastName="",
    this.teacherPhoneNumber="",
  });
}
