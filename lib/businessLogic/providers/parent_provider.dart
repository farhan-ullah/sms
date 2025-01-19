import 'package:flutter/material.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import '../../data/models/parentModel/parent_model.dart';
import '../../data/models/student_model/student_model.dart';

class ParentProvider extends ChangeNotifier {
  ParentModel? selectedParent;
  List<ParentModel> mockParentList = [
    ParentModel(
      parentId: 'P1',
      firstName: 'Michael',
      lastName: 'Doe',
      nic: '12345-6789012-3',
      email: 'michael.doe@email.com',
      phoneNumber: '+1 234 567 890',
      childrenIDs: ['S1001'], // Linking to John Doe
      completeAddress: '123 Main Street, Springfield, IL, USA',
    ),
    ParentModel(
      parentId: 'P2',
      firstName: 'Rachel',
      lastName: 'Stone',
      nic: '98765-4321098-7',
      email: 'rachel.stone@email.com',
      phoneNumber: '+1 234 567 892',
      childrenIDs: ['S1002'], // Linking to Emma Stone
      completeAddress: '456 Oak Avenue, Riverdale, NY, USA',
    ),
    ParentModel(
      parentId: 'P3',
      firstName: 'David',
      lastName: 'Smith',
      nic: '45678-1234567-0',
      email: 'david.smith@email.com',
      phoneNumber: '+1 234 567 894',
      childrenIDs: ['S1003'], // Linking to Liam Smith
      completeAddress: '789 Pine Road, Lakeside, FL, USA',
    ),
    ParentModel(
      parentId: 'P4',
      firstName: 'Sarah',
      lastName: 'Johnson',
      nic: '78901-2345678-9',
      email: 'sarah.johnson@email.com',
      phoneNumber: '+1 234 567 896',
      childrenIDs: ['S1004'], // Linking to Olivia Johnson
      completeAddress: '321 Birch Lane, Midtown, CA, USA',
    ),
  ];
  // Method to filter parents based on a search query

  // Method to filter parents based on a search query
  void filterParents(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all parents
      mockParentList = [
        ParentModel(
          parentId: 'P1',
          firstName: 'Michael',
          lastName: 'Doe',
          nic: '12345-6789012-3',
          email: 'michael.doe@email.com',
          phoneNumber: '+1 234 567 890',
          childrenIDs: ['S1001'], // Linking to John Doe
          completeAddress: '123 Main Street, Springfield, IL, USA',
        ),
        ParentModel(
          parentId: 'P2',
          firstName: 'Rachel',
          lastName: 'Stone',
          nic: '98765-4321098-7',
          email: 'rachel.stone@email.com',
          phoneNumber: '+1 234 567 892',
          childrenIDs: ['S1002'], // Linking to Emma Stone
          completeAddress: '456 Oak Avenue, Riverdale, NY, USA',
        ),
        ParentModel(
          parentId: 'P3',
          firstName: 'David',
          lastName: 'Smith',
          nic: '45678-1234567-0',
          email: 'david.smith@email.com',
          phoneNumber: '+1 234 567 894',
          childrenIDs: ['S1003'], // Linking to Liam Smith
          completeAddress: '789 Pine Road, Lakeside, FL, USA',
        ),
        ParentModel(
          parentId: 'P4',
          firstName: 'Sarah',
          lastName: 'Johnson',
          nic: '78901-2345678-9',
          email: 'sarah.johnson@email.com',
          phoneNumber: '+1 234 567 896',
          childrenIDs: ['S1004'], // Linking to Olivia Johnson
          completeAddress: '321 Birch Lane, Midtown, CA, USA',
        ),
      ];
    } else {
      // Filter parents based on first name, last name, or email
      mockParentList = mockParentList.where((parent) {
        return parent.firstName!.toLowerCase().contains(query.toLowerCase()) ||
            parent.lastName!.toLowerCase().contains(query.toLowerCase()) ||
            parent.email!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Method to change selected parent
  void changeSelectedParent(ParentModel parent) {
    selectedParent = parent;
    notifyListeners(); // Notify listeners to update UI
  }

  // Method to update a parent's information
  Future<void> updateParent(ParentModel updatedParent) async {
    try {
      // Check if a parent with the same NIC or phoneNumber already exists (excluding the parent being updated)
      bool parentExists = mockParentList.any((parent) =>
      (parent.nic == updatedParent.nic || parent.phoneNumber == updatedParent.phoneNumber) &&
          parent.parentId != updatedParent.parentId);

      if (parentExists) {
        throw Exception("Parent with the same NIC or phone number already exists.");
      } else {
        // Find the index of the parent to update
        int index = mockParentList.indexWhere((parent) => parent.parentId == updatedParent.parentId);

        if (index != -1) {
          // If parent exists, update the parent's details
          mockParentList[index] = updatedParent;
          print('Parent details updated successfully!');
        } else {
          // If parent is not found, handle the case (possibly throw an error or handle it gracefully)
          throw Exception("Parent with ID ${updatedParent.parentId} not found.");
        }

        // Notify listeners to refresh the UI after the update
        notifyListeners();
      }
    } catch (e) {
      print('Error updating parent: $e');
      // Optionally, handle or display an error message
    }
  }

  // Method to enroll a new parent (already exists in your code)
  void enrollParent(ParentModel parentData) {
    // Get the existing list of parents from the mock data
    List<ParentModel> existingParents = mockParentList;

    // Check if a parent with the same NIC or phoneNumber already exists
    bool parentExists = existingParents.any((parent) =>
    parent.nic == parentData.nic || parent.phoneNumber == parentData.phoneNumber);

    if (parentExists) {
      throw Exception("Parent with the same NIC or phone number already exists.");
    } else {
      // Add the parent if no duplicates are found
      mockParentList.add(parentData);  // Adding to the list
      print("Parent added successfully.");

      // Notify listeners (if needed for UI updates)
      notifyListeners();
    }
  }

  // Method to change selected parent

  // Method to get a parent by full name
  ParentModel getParentByName(String name) {
    ParentModel? parent = mockParentList.firstWhere(
          (parent) =>
      '${parent.firstName} ${parent.lastName}'.toLowerCase() ==
          name.toLowerCase(),
      orElse: () => ParentModel(
        parentId: "defaultId",
        firstName: "Default",
        lastName: "Parent",
        phoneNumber: "0000000000",
        email: "default@example.com",
        nic: "000000000V",
      ),
    );

    print('Searching for Parent');
    print('Parent Name: $name');
    print('Found Parent: ${parent.firstName} ${parent.lastName}');

    return parent;
  }

  // Method to get parent by ID
  ParentModel getParentById(String parentId) {
    ParentModel? parent = mockParentList.firstWhere(
          (parent) => parent.parentId == parentId,
      orElse: () => ParentModel(
        parentId: "defaultId",
        firstName: "Default",
        lastName: "Parent",
        phoneNumber: "0000000000",
        email: "default@example.com",
        nic: "000000000V",
      ),
    );

    print('Searching for Parent by ID');
    print('Parent ID: $parentId');
    print('Found Parent: ${parent.firstName} ${parent.lastName}');

    return parent;
  }

  // Method to add a Child (Student) to a Parent
  void addChildToParent(String studentId, String parentID) {
    ParentModel parent = mockParentList.firstWhere(
          (parent) => parent.parentId == parentID,
      orElse: () {
        throw Exception("Parent with ID $parentID not found.");
      },
    );

    // Check if the childrenIDs list is null or not
    if (parent.childrenIDs == null) {
      parent.childrenIDs = [];
    }

    // Add the student's ID to the parent's children list
    if (!parent.childrenIDs!.contains(studentId)) {
      parent.childrenIDs?.add(studentId);
    }

    print("Student ID is $studentId and ParentID is $parentID");
    print("After adding, Children IDs: ${parent.childrenIDs}");
  }

  // Method to get students by Parent ID
  List<StudentModel> getStudentsByParentId(String parentID, StudentProvider studentProvider) {
    ParentModel parent = mockParentList.firstWhere(
          (parent) => parent.parentId == parentID,
      orElse: () {
        throw Exception("Parent with ID $parentID not found.");
      },
    );

    List<String> childrenIDs = parent.childrenIDs ?? [];
    print("Children IDs: $childrenIDs");

    // Map the student IDs to the corresponding full StudentModel objects
    List<StudentModel> students = studentProvider.mockStudentList
        .where((student) => childrenIDs.contains(student.studentId))
        .toList();

    return students;
  }

  // Pre-parent ID management (for UI handling)
  String? _preParentId;
  String? get preParentId => _preParentId;

  void setPreParentId(String preParentID) {
    _preParentId = preParentID;
    notifyListeners();
  }
}
