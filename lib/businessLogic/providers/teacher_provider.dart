import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:school/constants/common_keys.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import '../../utils/custom_toast.dart';

class TeacherProvider extends ChangeNotifier {
  List<TeacherModel> mockTeacherList = [
    TeacherModel(
      teacherId: 'T1',
      teacherFirstName: 'John',
      teacherLastName: 'Doe',
      qualification: 'M.Sc Physics',
      teacherSubjectIDs: ['S1', 'S2'], // Subjects IDs this teacher teaches
      dateOfJoining: '2015-06-01',
      teacherAddress: '123, Elm Street, Springfield',
      teacherPhoneNumber: '123-456-7890',
      teacherEmail: 'johndoe@example.com',
      salaryTier: 'Tier 3',
      teacherNic: '12345-67890',
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
    ),
    TeacherModel(
      teacherId: 'T3',
      teacherFirstName: 'Robert',
      teacherLastName: 'Brown',
      qualification: 'Ph.D Computer Science',
      teacherSubjectIDs: ['S5', 'S6'],
      dateOfJoining: '2018-02-20',
      teacherAddress: '789, Pine Road, Springfield',
      teacherPhoneNumber: '345-678-9012',
      teacherEmail: 'robertbrown@example.com',
      salaryTier: 'Tier 1',
      teacherNic: '34567-89012',
    ),
    TeacherModel(
      teacherId: 'T4',
      teacherFirstName: 'Emily',
      teacherLastName: 'Davis',
      qualification: 'B.Ed',
      teacherSubjectIDs: ['S7', 'S8'],
      dateOfJoining: '2017-08-30',
      teacherAddress: '101, Maple Lane, Springfield',
      teacherPhoneNumber: '456-789-0123',
      teacherEmail: 'emilydavis@example.com',
      salaryTier: 'Tier 2',
      teacherNic: '45678-90123',
    ),
    TeacherModel(
      teacherId: 'T5',
      teacherFirstName: 'Michael',
      teacherLastName: 'Wilson',
      qualification: 'M.A History',
      teacherSubjectIDs: ['S9', 'S10'],
      dateOfJoining: '2020-01-10',
      teacherAddress: '202, Birch Street, Springfield',
      teacherPhoneNumber: '567-890-1234',
      teacherEmail: 'michaelwilson@example.com',
      salaryTier: 'Tier 3',
      teacherNic: '56789-01234',
    ),
  ];




  void enrollTeacher(
      TeacherModel teacherModel

  ) {
    final teacherData = teacherModel;
     notifyListeners();
  }
  void editTeacher(
      TeacherModel teacherModel

      ) {
    final teacherData = teacherModel;
     notifyListeners();
  }
  Future<List<TeacherModel>> getAllTeachers() async {
    return mockTeacherList;
  }

  void addSubjectToTeacher(String teacherID, String subjectID, BuildContext context) {
    // Step 1: Retrieve the teacher data from the Box
    var teacherData = Hive.box<TeacherModel>(CommonKeys.TEACHER_BOX_KEY).values.firstWhere(
            (teacher) => teacher.teacherId == teacherID,
        orElse: () => TeacherModel()  // Return a dummy TeacherModel if not found
    );

    // Step 2: Check if the teacher was found
    if (teacherData.teacherId == null || teacherData.teacherId == '') {
      // If the teacher is not found (dummy instance), show an error message
      print("Teacher with ID '$teacherID' not found.");
      MyToast().showToast("Teacher not found. Please try again.", context);
    } else {
      print("Found teacher with ID: ${teacherData.teacherId} and name: ${teacherData.teacherFirstName} ${teacherData.teacherLastName}");

      // Step 3: Check if teacher's subject list is initialized
      if (teacherData.teacherSubjectIDs == null) {
        teacherData.teacherSubjectIDs = [];
      }

      // Step 4: Add subjectID to teacher's subject list
      teacherData.teacherSubjectIDs!.add(subjectID);

      // Save the updated teacher data to the box
       print("Teacher data saved after adding new subject.");

      // Step 5: Notify listeners to refresh the UI
      notifyListeners();

      // Optional: Show a toast message
      MyToast().showToast("Subject added to teacher '${teacherData.teacherFirstName} ${teacherData.teacherLastName}' successfully.", context);
    }
  }

  // Get teachers by filter
  Future<List<TeacherModel>> getTeachersByFilter({
    String? firstName,
    String? lastName,
    String? qualification,
    String? subject,
    String? salaryTier,
  }) async {
    List<TeacherModel> filteredTeachers = [];

    // Fetch all teachers first
    List<TeacherModel> allTeachers = mockTeacherList;

    // Apply filtering conditions
    for (var teacher in allTeachers) {
      bool matches = true;

      // Check each filter and apply conditions
      if (firstName != null && teacher.teacherFirstName != firstName) {
        matches = false;
      }
      if (lastName != null && teacher.teacherLastName != lastName) {
        matches = false;
      }
      if (qualification != null && teacher.qualification != qualification) {
        matches = false;
      }
      // if (subject != null && teacher.teacherSubject != subject) {
      //   matches = false;
      // }
      if (salaryTier != null && teacher.salaryTier != salaryTier) {
        matches = false;
      }

      if (matches) {
        filteredTeachers.add(teacher);
      }
    }

    return filteredTeachers;
  }

  Future<List<TeacherModel>> getTeachersById(List<String> teacherIds) async {
    List<TeacherModel> teachersById = [];

    // Fetch all teachers first
    List<TeacherModel> allTeachers = mockTeacherList;

    // Filter teachers based on the provided teacherIds
    for (var teacher in allTeachers) {
      if (teacherIds.contains(teacher.teacherId)) {
        teachersById.add(teacher);
      }
    }

    return teachersById;
  }

  List<TeacherModel> _teachers = [];

  List<TeacherModel> get teachers => _teachers;

  // Update the teacher
  // Update a teacher in Hive
  Future<void> updateTeacher(TeacherModel updatedTeacher) async {
    // Update the teacher using their teacherId
    final index = mockTeacherList.indexWhere((teacher) => teacher.teacherId == updatedTeacher.teacherId);

    if (index != -1) {

      notifyListeners();  // Notify listeners to update the UI
    } else {
      print('Teacher not found for update');
    }
  }

  String _selectedTeacher = "No Class Selected";
  String get selectedTeacher=>_selectedTeacher;

  changeTeacher(String newTeacher){
    _selectedTeacher=newTeacher;
    notifyListeners();
  }

}
