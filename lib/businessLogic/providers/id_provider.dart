import 'package:flutter/material.dart';
import 'package:school/constants/common_keys.dart';

import '../../services/id_service/id_service.dart';

class IdProvider with ChangeNotifier {
  String _studentId = "";
  String _parentId = "";
  String _feeId ="";
  String _teacherId="";
  String _classId='';
  String _subjectId="";


  String get studentId => _studentId;
  String get parentId => _parentId;
  String get feeId=>_feeId;
  String get teacherId=>_teacherId;
  String get classId=>_classId;
  String get subjectId=>_subjectId;


  Future<void> generateSubjectID() async {
    _subjectId = await IDService.generateUniqueID(CommonKeys.SUBJECT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }

  Future<void> getSubjectID() async {
    _subjectId = await IDService.getLatestID(CommonKeys.SUBJECT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }





  Future<void> generateStudentID() async {
    _studentId = await IDService.generateUniqueID(CommonKeys.STUDENT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }

  Future<void> getStudentID() async {
    _studentId = await IDService.getLatestID(CommonKeys.STUDENT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }


  Future<void> generateClassID() async {
    _classId = await IDService.generateUniqueID(CommonKeys.CLASS_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }
  Future<void> getClassID() async {
    _classId = await IDService.getLatestID(CommonKeys.CLASS_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }

  Future<void> generateParentID() async {
    _parentId = await IDService.generateUniqueID(CommonKeys.PARENT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }
  Future<void> getParentID() async {
    _parentId = await IDService.getLatestID(CommonKeys.PARENT_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }

  Future<void> generateFeeID() async {
    _feeId = await IDService.generateUniqueID(CommonKeys.FEE_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }
  Future<void> getFeeID() async {
    _feeId = await IDService.getLatestID(CommonKeys.FEE_ID_KEY);
    notifyListeners();  // Notify listeners to update UI
  }

  Future<void> generateTeacherID() async {
    _teacherId = await IDService.generateUniqueID(CommonKeys.TEACHER_BOX_KEY);
    notifyListeners();  // Notify listeners to update UI
  }
  Future<void> getTeacherID() async {
    _teacherId = await IDService.getLatestID(CommonKeys.TEACHER_BOX_KEY);
    notifyListeners();  // Notify listeners to update UI
  }



}
