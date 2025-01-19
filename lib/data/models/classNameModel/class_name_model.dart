import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:school/data/models/student_model/student_model.dart';


class ClassNameModel {
  String? className;

  String? classFeesID;

  List<String>? classStudentIDs;  // List of student IDs

  String? section;

  List<String>? subjectIDs;

  String? classID;

  List<String>? subjects;

  ClassNameModel({
    this.classID,
    this.className = "",
    this.classFeesID = "",
    this.classStudentIDs = const [],
    this.section = "A",
    this.subjectIDs = const [],
    this.subjects=const[]
  });

  // Factory method to create an instance from a map (for fromJson)
  factory ClassNameModel.fromJson(Map<String, dynamic> json) {
    return ClassNameModel(
      classID: json['classID'],
      className: json['className'] ?? "",
      classFeesID: json['classFeesID'] ?? "",
      classStudentIDs: json['listOfStudentsInClass'] != null
          ? List<String>.from(json['listOfStudentsInClass'])
          : [], // Assuming listOfStudentsInClass is a list of student IDs
      section: json['section'] ?? "", // section might not be a list but a string
      subjectIDs: json['teacherIDs'] != null
          ? List<String>.from(json['teacherIDs'])
          : [], // teacher IDs are likely just strings
    );
  }

  // Method to convert the instance to a map (for toJson)
  Map<String, dynamic> toJson() {
    return {
      'classID': classID,
      'className': className,
      'classFeesID': classFeesID,
      'listOfStudentsInClass': classStudentIDs, // Just the IDs of students
      'section': section,
      'teacherIDs': subjectIDs,
    };
  }
}
