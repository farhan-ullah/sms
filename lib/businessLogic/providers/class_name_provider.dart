import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';
import 'package:school/data/models/classNameModel/class_name_model.dart';
import 'package:school/utils/custom_toast.dart';

class ClassNameProvider extends ChangeNotifier{
  List<ClassNameModel> mockClassList = [
    ClassNameModel(
      classID: 'C1',
      className: 'Math 101',
      classFeesID: 'F1',
      classStudentIDs: ['S1', 'S2', 'S3', 'S4'],
      section: 'A',
      subjectIDs: ['T1', 'T2'], // Teacher IDs for the subject
      subjects: ['Mathematics', 'Algebra'], // Just for illustration
    ),
    ClassNameModel(
      classID: 'C2',
      className: 'Science 102',
      classFeesID: 'F2',
      classStudentIDs: ['S5', 'S6', 'S7', 'S8'],
      section: 'B',
      subjectIDs: ['T3', 'T4'],
      subjects: ['Physics', 'Chemistry'],
    ),
    ClassNameModel(
      classID: 'C3',
      className: 'History 103',
      classFeesID: 'F3',
      classStudentIDs: ['S9', 'S10'],
      section: 'C',
      subjectIDs: ['T5'],
      subjects: ['World History'],
    ),
    ClassNameModel(
      classID: 'C4',
      className: 'English 104',
      classFeesID: 'F4',
      classStudentIDs: ['S11', 'S12', 'S13'],
      section: 'A',
      subjectIDs: ['T6'],
      subjects: ['English Language and Literature'],
    ),
    ClassNameModel(
      classID: 'C5',
      className: 'Biology 105',
      classFeesID: 'F5',
      classStudentIDs: ['S14', 'S15', 'S16', 'S17'],
      section: 'B',
      subjectIDs: ['T7', 'T8'],
      subjects: ['Biology', 'Botany'],
    ),
  ];


  // void promoteStudents(String className, String nextClassName) {
  //   // Find the class by className
  //   var classData = classNameBox.firstWhere((classItem) => classItem.className == className, orElse: () => null);
  //   if (classData != null) {
  //     var studentsToPromote = List<Student>.from(classData.listOfStudentsInClass);
  //     for (var student in studentsToPromote) {
  //       // Logic to promote student, e.g., move to the next section or next class
  //       student.promoteToNextClassOrSection(nextClassName);  // Assuming you have a promote method in the Student class
  //     }
  //     classData.save();
  //     notifyListeners();
  //   } else {
  //     print("Class '$className' not found.");
  //   }
  // }





  // void addStudentsToClass(String className, List<Student> students, {String? section}) {
  //   // Find the class by className
  //   var classData = classNameBox.firstWhere((classItem) => classItem.className == className, orElse: () => null);
  //   if (classData != null) {
  //     // If no section is provided, assign students to a default section (e.g., "A")
  //     String sectionToAssign = section ?? "A";  // Default to section "A" if none is provided
  //
  //     // If the class already has sections, ensure the section exists
  //     if (!classData.sections.contains(sectionToAssign)) {
  //       classData.sections.add(sectionToAssign);  // Add section if it doesn't exist
  //     }
  //
  //     // Add the students to the specified section in the class's sections map
  //     // Assuming `classData.sections` is a Map<String, List<Student>> where each section has a list of students
  //     if (!classData.sectionsMap.containsKey(sectionToAssign)) {
  //       classData.sectionsMap[sectionToAssign] = [];  // Initialize the section if it doesn't exist
  //     }
  //
  //     // Add students to the appropriate section
  //     classData.sectionsMap[sectionToAssign]!.addAll(students);  // Add all students to the section
  //
  //     classData.save();
  //     notifyListeners();
  //   } else {
  //     print("Class '$className' not found.");
  //   }
  // }

// Method to remove a student from a class by class name and student name
  void removeStudentFromClass(String className, String studentName) {
    // Find the class by className
    var classData = mockClassList.firstWhere((classItem) => classItem.classID == className, orElse:  null);
    if (classData != null) {
      var student = classData.classStudentIDs?.firstWhere((student) => student == studentName, orElse:  null);
      if (student != null) {
        classData.classStudentIDs?.remove(student);  // Remove the student
        print("Removed student '$studentName' from class '$className'.");
      } else {
        print("Student '$studentName' not found in class '$className'.");
      }
    } else {
      print("Class '$className' not found.");
    }
  }

// Method to change student section
  void changeStudentSection(String className, String studentName, String newSection) {
    // Find the class by className
    var classData = mockClassList.firstWhere((classItem) => classItem.classID == className, orElse:  null);
    if (classData != null) {
      var student = classData.classStudentIDs?.firstWhere((student) => student == studentName, orElse:  null);
      if (student != null) {
        // Assuming the student has a 'section' property
        // Change the section (in real data model, you may have to update a specific student object)
        print("Changed section for student '$studentName' to '$newSection' in class '$className'.");
      } else {
        print("Student '$studentName' not found in class '$className'.");
      }
    } else {
      print("Class '$className' not found.");
    }
  }

// Method to delete a class
  void deleteClass(String classID) {
    // Find and remove the class from the classList
    var classData = mockClassList.firstWhere((classItem) => classItem.classID == classID, orElse:  null);
    if (classData != null) {
      mockClassList.remove(classData);
      print("Class '$classID' deleted.");
    } else {
      print("Class '$classID' not found.");
    }
  }

// Method to get a class by class ID
  ClassNameModel? getClassByID(String classID) {
    // Iterate through all classes and check if the classID matches
    return mockClassList.firstWhere((classData) => classData.classID == classID, orElse:  null);
  }

// Method to add or remove a teacher from a class
  void addOrRemoveTeacher(String classID, String teacherID, bool add, BuildContext context) {
    // Find the class by classID
    var classData = mockClassList.firstWhere((classItem) => classItem.classID == classID, orElse:  null);
    if (classData != null) {
      if (add) {
        // Add teacherID to subjectIDs list (teacher list for the class)
        if (!classData.subjectIDs!.contains(teacherID)) {
          classData.subjectIDs?.add(teacherID);
          print("Teacher '$teacherID' added to class '$classID'.");
        } else {
          print("Teacher '$teacherID' is already assigned to this class.");
        }
      } else {
        // Remove teacherID from subjectIDs list
        if (classData.subjectIDs!.contains(teacherID)) {
          classData.subjectIDs?.remove(teacherID);
          print("Teacher '$teacherID' removed from class '$classID'.");
        } else {
          print("Teacher '$teacherID' is not assigned to this class.");
        }
      }
    } else {
      print("Class '$classID' not found.");
    }
  }




// Method to add a student to a class
  void addStudentToAClass(String classID, String studentID) {
    var classData = mockClassList.firstWhere((classItem) => classItem.classID == classID, orElse:  null);
    if (!classData.classStudentIDs!.contains(studentID)) {
      classData.classStudentIDs?.add(studentID);
      print("Student '$studentID' added to class '$classID'.");
    } else {
      print("Student '$studentID' is already in the class.");
    }
    }

// Method to edit the class name
  void editClassName(int index, String newName) {
    if (index >= 0 && index < mockClassList.length) {
      var classToEdit = mockClassList[index];
      if (classToEdit.className != newName) {
        classToEdit.className = newName;
        print("Class name at index $index updated to: $newName.");
      } else {
        print("No change detected. The class name is already '$newName'.");
      }
    } else {
      print("Invalid index: $index.");
    }
  }

// Method to create a new class
  void createClass(String className, String classID, BuildContext context, [String? classFeesID, List<String>? teachers, String? section = "A"]) {
    // Check if class with the same name and section already exists
    bool classExists = mockClassList.any((existingClass) {
      return existingClass.classID == className && existingClass.section == section;
    });

    if (classExists) {
      print("Class with name $className and section $section already exists.");
      return; // Exit without adding the class
    }

    final createClassData = ClassNameModel(
      classID: classID,
      className: className,
      section: section ?? "A",  // Default to "A" if null
      classFeesID: classFeesID ?? "",
      classStudentIDs: [],
      subjectIDs: teachers ?? [],
    );

    mockClassList.add(createClassData);
    print("Class Added with section: ${createClassData.section}");
  }

// Method to get classes by IDs
  List<ClassNameModel> getClassesByIDs(List<String> classIDs) {
    Set<String> classIDSet = Set.from(classIDs);
    return mockClassList.where((classData) => classIDSet.contains(classData.classID)).toList();
  }


  ///UI
///
///
bool _hasAnySections = false;
get hasAnySections => _hasAnySections;
toggleSectionsOption()
{
  _hasAnySections=!_hasAnySections;
  notifyListeners();
}
String _selectedClass = "No Class Selected";
String get selectedClass=>_selectedClass;

changeCLassName(String newClass){
  _selectedClass=newClass;
  notifyListeners();
}
  void addSubjectToClass(String classID, String subjectID, BuildContext context,SubjectProvider subjectProvider) {
    // Step 1: Retrieve the class data from the mock class list
    var classData = mockClassList.firstWhere(
          (classItem) => classItem.classID == classID,
      orElse:  null,  // If not found, return null
    );

    // Step 2: Check if the class was found
    if (classData != null) {
      print("Found class with ID: ${classData.classID} and name: ${classData.className}");

      // Step 3: Retrieve the SubjectModel by subjectID from the mock subjects list
      var subjectData = subjectProvider.mockSubjectList.firstWhere(
            (subject) => subject.subjectID == subjectID,
        orElse:  null,  // Return null if not found
      );

      // Step 4: Check if the subject was found
      if (subjectData != null) {
        // Step 5: Check if the subjectID is already in the class's subject list to avoid duplicates
        if (!classData.subjectIDs!.contains(subjectID)) {
          // Add the subjectID to the class's subject list if it's not already present
          classData.subjectIDs?.add(subjectID);
          print("Subject ID '$subjectID' with name '${subjectData.subjectName}' added to class '${classData.classID}'.");

          // Step 6: Notify listeners to refresh the UI
          notifyListeners();

          // Optional: Show a toast message
          MyToast().showToast("Subject '${subjectData.subjectName}' added to class '${classData.classID}' successfully.", context);
        } else {
          // If the subject is already in the list, skip adding it
          print("Subject with ID '$subjectID' already exists in class '${classData.classID}'. Skipping.");
          MyToast().showToast("Subject '${subjectData.subjectName}' already exists in class '${classData.classID}'.", context);
        }
      } else {
        // If the subject is not found, show an error message
        print("Subject with ID '$subjectID' not found.");
        MyToast().showToast("Subject not found. Please try again.", context);
      }
    } else {
      // If the class is not found, show an error message
      print("Class with ID '$classID' not found.");
      MyToast().showToast("Class not found. Please try again.", context);
    }
  }





}