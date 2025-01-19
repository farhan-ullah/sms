import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:school/businessLogic/providers/teacher_provider.dart';
import 'package:school/data/models/subjectModel/subject_model.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import 'package:school/utils/custom_toast.dart';

class SubjectProvider extends ChangeNotifier {
  // Mock Data List for SubjectModel
  List<SubjectModel> mockSubjectList = [
    SubjectModel(
      subjectID: 'SUB101',
      subjectName: 'Mathematics',
      teacherID: 'T1',
      teacherName: 'Mr. John Doe',
      classID: 'C5A',
      className: 'Class 5 - Section A',
    ),
    SubjectModel(
      subjectID: 'SUB102',
      subjectName: 'English',
      teacherID: 'T2',
      teacherName: 'Ms. Jane Smith',
      classID: 'C5B',
      className: 'Class 5 - Section B',
    ),
    SubjectModel(
      subjectID: 'SUB103',
      subjectName: 'Science',
      teacherID: 'T3',
      teacherName: 'Mr. Michael Brown',
      classID: 'C5C',
      className: 'Class 5 - Section C',
    ),
    SubjectModel(
      subjectID: 'SUB104',
      subjectName: 'History',
      teacherID: 'T4',
      teacherName: 'Ms. Emily White',
      classID: 'C5D',
      className: 'Class 5 - Section D',
    ),
    SubjectModel(
      subjectID: 'SUB105',
      subjectName: 'Geography',
      teacherID: 'T5',
      teacherName: 'Mr. David Green',
      classID: 'C5E',
      className: 'Class 5 - Section E',
    ),
  ];

  // Function to check if subject name is unique within the class
  bool isSubjectNameUnique(String subjectName, String classID) {
    return mockSubjectList.every((subject) =>
    subject.subjectName != subjectName || subject.classID != classID);
  }

  // Function to add a new subject
  void addSubject(
      String subjectName, String classID, String teacherID, BuildContext context) {
    // Validate if the subject name is unique within the class
    if (!isSubjectNameUnique(subjectName, classID)) {
      MyToast().showToast("Subject already exists in this class!", context);
      return;
    }

    // Create new subject
    String newSubjectID = 'SUB${mockSubjectList.length + 1}';
    String newClassName = 'Class ${classID.split("")[0]} - Section ${classID.split("")[1]}';

    SubjectModel newSubject = SubjectModel(
      subjectID: newSubjectID,
      subjectName: subjectName,
      teacherID: teacherID,
      teacherName: 'Not Assigned',
      classID: classID,
      className: newClassName,
    );

    // Add the new subject to the list
    mockSubjectList.add(newSubject);
    notifyListeners();
    MyToast().showToast("New subject added successfully!", context);
    print("Added new subject: $newSubjectID - $subjectName to class: $classID");
  }

  // Function to change teacher for a subject
  void changeTeacherForSubject(
      String subjectID, String newTeacherID, BuildContext context, TeacherProvider teacherProvider) {

    try {
      // Safely retrieve the subject by subjectID
      SubjectModel? subject = mockSubjectList.firstWhere(
            (subject) => subject.subjectID == subjectID,
        orElse: () => SubjectModel(), // Return null if no subject is found
      );

      // Handle case when subject isn't found
      if (subject == null) {
        MyToast().showToast("Subject not found.", context);
        return;
      }

      // Safely retrieve the teacher by teacherID
      var newTeacher = teacherProvider.mockTeacherList.firstWhere(
            (teacher) => teacher.teacherId == newTeacherID,
        orElse: () => TeacherModel(), // Return null if no teacher is found
      );

      // Handle case when teacher isn't found
      if (newTeacher == null) {
        MyToast().showToast("Teacher not found.", context);
        return;
      }

      // Update teacher for the subject
      subject.teacherID = newTeacherID;
      subject.teacherName = "${newTeacher.teacherFirstName} ${newTeacher.teacherLastName}";

      print("Updated Subject Teacher to: ${subject.teacherName}");
      MyToast().showToast("Teacher for ${subject.subjectName} has been updated.", context);
      notifyListeners(); // Refresh UI
    } catch (e) {
      // Handle any unexpected error
      MyToast().showToast("An error occurred while updating the teacher.", context);
      print(e);
    }
  }

  // Function to remove a subject from the list
  void removeSubject(String subjectID, BuildContext context) {
    try {
      var subjectToRemove = mockSubjectList.firstWhere(
            (subject) => subject.subjectID == subjectID,
        orElse: () => SubjectModel(), // Return null if no subject is found
      );

      if (subjectToRemove == null) {
        MyToast().showToast("Subject not found.", context);
        return;
      }

      mockSubjectList.remove(subjectToRemove);
      notifyListeners(); // Update listeners/UI
      MyToast().showToast("Subject removed successfully!", context);
      print("Removed subject: $subjectID");
    } catch (e) {
      // Handle any error
      MyToast().showToast("An error occurred while removing the subject.", context);
      print(e);
    }
  }
}
