import 'package:flutter/material.dart';




class TimeTableModel {

  TimeOfDay startTime;


  TimeOfDay endTime;


  String timeTableName;

  String? day;

  String? date;

  String className;

  String? teacherName;

  TimeTableModel({
    this.className=""
    ,this.date="",
    this.day="",
    this.teacherName="",
    required this.endTime,required this.startTime,required this.timeTableName
});
}