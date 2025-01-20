import 'package:flutter/cupertino.dart';
import 'package:school/businessLogic/providers/parent_provider.dart';
import 'package:school/data/models/parentModel/parent_model.dart';
import 'package:school/data/models/student_model/student_model.dart';
import '../../data/models/feeModel/fee_model.dart';

class StudentProvider extends ChangeNotifier {


  bool _registerParent = true;
  get parentOption => _registerParent;
  bool _giveDiscount = false;
  bool get giveDiscount =>_giveDiscount;

  List<StudentModel> mockStudentList = [
    StudentModel(
      firstName: 'John',
      lastName: 'Doe',
      gender: 'Male',
      dateOfBirth: '2008-05-12',
      placeOfBirth: 'New York, USA',
      dateOfAdmission: '2023-08-15',
      photoLink: 'http://example.com/photos/johndoe.jpg',
      otherPhoneNo: '+1 234 567 890',
      emergencyContactNo: '+1 234 567 891',
      completeAddress: '123 Main St, New York, NY',
      studentId: 'S1001',
      rollNo: '01',
      classID: 'C1',
      section: 'A',
      previousSchoolName: 'ABC International School',
      reasonOfLeaving: 'Relocation',
      reference: 'Mr. Smith',
      parentId: 'P1',
      studentAllFeeTypes: {
        'Tuition Fee': FeeModel(
          feeId: 'F1',
          feeType: 'Tuition Fee',
          feeName: 'Annual Tuition Fee',
          createdFeeAmount: 5000.00,
          isFullyPaid: false,
          dueDate: '2025-06-30',
          feeDescription: 'Annual tuition fee for the academic year',
          feeMonth: 'June',
          feeArrears: 200.00,
          dateOfTransaction: '2025-05-20',
          isPartiallyPaid: true,
          feeConcessionInPKR: 500.00,
          classID: 'C1',
          generatedFeeAmount: 4500.00, // After discount
          feeConcessionInPercent: 10.0,
        ),
        'Sports Fee': FeeModel(
          feeId: 'F2',
          feeType: 'Sports Fee',
          feeName: 'Sports and Activity Fee',
          createdFeeAmount: 200.00,
          isFullyPaid: true,
          dueDate: '2025-06-30',
          feeDescription: 'Fee for sports and extracurricular activities',
          feeMonth: 'June',
          feeArrears: 0.0,
          dateOfTransaction: '2025-05-10',
          isPartiallyPaid: false,
          feeConcessionInPKR: 0.0,
          classID: 'C1',
          generatedFeeAmount: 200.00,
          feeConcessionInPercent: 0.0,
        ),
      },
      concessionInPercent: 10.0,
      concessionInPKR: 1000.0,
    ),
    StudentModel(
      firstName: 'Emma',
      lastName: 'Stone',
      gender: 'Female',
      dateOfBirth: '2007-11-22',
      placeOfBirth: 'Los Angeles, USA',
      dateOfAdmission: '2022-07-10',
      photoLink: 'http://example.com/photos/emmastone.jpg',
      otherPhoneNo: '+1 234 567 892',
      emergencyContactNo: '+1 234 567 893',
      completeAddress: '456 Elm St, Los Angeles, CA',
      studentId: 'S1002',
      rollNo: '02',
      classID: 'C1',
      section: 'B',
      previousSchoolName: 'XYZ High School',
      reasonOfLeaving: 'Graduation',
      reference: 'Mrs. Lee',
      parentId: 'P2',
      studentAllFeeTypes: {
        'Tuition Fee': FeeModel(
          feeId: 'F3',
          feeType: 'Tuition Fee',
          feeName: 'Annual Tuition Fee',
          createdFeeAmount: 6000.00,
          isFullyPaid: true,
          dueDate: '2025-06-30',
          feeDescription: 'Annual tuition fee for the academic year',
          feeMonth: 'June',
          feeArrears: 0.0,
          dateOfTransaction: '2025-05-15',
          isPartiallyPaid: false,
          feeConcessionInPKR: 0.0,
          classID: 'C1',
          generatedFeeAmount: 6000.00, // No concession
          feeConcessionInPercent: 0.0,
        ),
        'Library Fee': FeeModel(
          feeId: 'F4',
          feeType: 'Library Fee',
          feeName: 'Library Subscription Fee',
          createdFeeAmount: 50.00,
          isFullyPaid: false,
          dueDate: '2025-06-15',
          feeDescription: 'Fee for library subscription and services',
          feeMonth: 'June',
          feeArrears: 10.00,
          dateOfTransaction: '2025-05-15',
          isPartiallyPaid: true,
          feeConcessionInPKR: 5.00,
          classID: 'C1',
          generatedFeeAmount: 45.00, // After discount
          feeConcessionInPercent: 10.0,
        ),
      },
      concessionInPercent: 15.0,
      concessionInPKR: 900.0,
    ),
    StudentModel(
      firstName: 'Liam',
      lastName: 'Smith',
      gender: 'Male',
      dateOfBirth: '2009-03-25',
      placeOfBirth: 'Chicago, USA',
      dateOfAdmission: '2024-01-10',
      photoLink: 'http://example.com/photos/liamsmith.jpg',
      otherPhoneNo: '+1 234 567 894',
      emergencyContactNo: '+1 234 567 895',
      completeAddress: '789 Oak St, Chicago, IL',
      studentId: 'S1003',
      rollNo: '03',
      classID: 'C2',
      section: 'A',
      previousSchoolName: 'LMN Academy',
      reasonOfLeaving: 'Transfer to new school',
      reference: 'Mr. Johnson',
      parentId: 'P3',
      studentAllFeeTypes: {
        'Tuition Fee': FeeModel(
          feeId: 'F5',
          feeType: 'Tuition Fee',
          feeName: 'Annual Tuition Fee',
          createdFeeAmount: 4500.00,
          isFullyPaid: false,
          dueDate: '2025-06-30',
          feeDescription: 'Annual tuition fee for the academic year',
          feeMonth: 'June',
          feeArrears: 200.00,
          dateOfTransaction: '2025-06-01',
          isPartiallyPaid: true,
          feeConcessionInPKR: 0.0,
          classID: 'C2',
          generatedFeeAmount: 4300.00, // After discount
          feeConcessionInPercent: 4.4,
        ),
        'Laboratory Fee': FeeModel(
          feeId: 'F6',
          feeType: 'Laboratory Fee',
          feeName: 'Science Lab Fee',
          createdFeeAmount: 75.00,
          isFullyPaid: false,
          dueDate: '2025-06-30',
          feeDescription: 'Fee for laboratory experiments and materials',
          feeMonth: 'June',
          feeArrears: 25.00,
          dateOfTransaction: '2025-06-01',
          isPartiallyPaid: true,
          feeConcessionInPKR: 10.00,
          classID: 'C2',
          generatedFeeAmount: 65.00, // After discount
          feeConcessionInPercent: 13.33,
        ),
      },
      concessionInPercent: 5.0,
      concessionInPKR: 500.0,
    ),
    StudentModel(
      firstName: 'Olivia',
      lastName: 'Johnson',
      gender: 'Female',
      dateOfBirth: '2008-09-30',
      placeOfBirth: 'San Francisco, USA',
      dateOfAdmission: '2021-05-20',
      photoLink: 'http://example.com/photos/oliviajohnson.jpg',
      otherPhoneNo: '+1 234 567 896',
      emergencyContactNo: '+1 234 567 897',
      completeAddress: '321 Pine St, San Francisco, CA',
      studentId: 'S1004',
      rollNo: '04',
      classID: 'C2',
      section: 'B',
      previousSchoolName: 'Sunshine School',
      reasonOfLeaving: 'N/A',
      reference: 'Mrs. Green',
      parentId: 'P4',
      studentAllFeeTypes: {
        'Tuition Fee': FeeModel(
          feeId: 'F7',
          feeType: 'Tuition Fee',
          feeName: 'Annual Tuition Fee',
          createdFeeAmount: 5500.00,
          isFullyPaid: false,
          dueDate: '2025-06-30',
          feeDescription: 'Annual tuition fee for the academic year',
          feeMonth: 'June',
          feeArrears: 100.00,
          dateOfTransaction: '2025-05-25',
          isPartiallyPaid: true,
          feeConcessionInPKR: 0.0,
          classID: 'C2',
          generatedFeeAmount: 5400.00, // After discount
          feeConcessionInPercent: 5.0,
        ),
        'Miscellaneous Fee': FeeModel(
          feeId: 'F8',
          feeType: 'Miscellaneous Fee',
          feeName: 'Miscellaneous Charges',
          createdFeeAmount: 150.00,
          isFullyPaid: true,
          dueDate: '2025-06-30',
          feeDescription: 'Miscellaneous charges for additional services',
          feeMonth: 'June',
          feeArrears: 0.0,
          dateOfTransaction: '2025-05-25',
          isPartiallyPaid: false,
          feeConcessionInPKR: 0.0,
          classID: 'C2',
          generatedFeeAmount: 150.00,
          feeConcessionInPercent: 0.0,
        ),
      },
      concessionInPercent: 8.0,
      concessionInPKR: 800.0,
    ),
  ];

  double subtractPercentageTuitionFee(double originalValue, {double percentage=0.0}) {
    // Calculate the percentage deduction
    double deduction = originalValue * (percentage / 100);

    // Subtract the deduction from the original value
    double result = originalValue - deduction;
    notifyListeners();

    // Return the result
    return result;
  }


  double subtractPercentageAdmissionFee(double originalValue, {double percentage=0.0}) {
    // Calculate the percentage deduction
    double deduction = originalValue * (percentage / 100);

    // Subtract the deduction from the original value
    double result = originalValue - deduction;
    notifyListeners();

    // Return the result
    return result;
  }



  void enrollStudent(StudentModel studentData, ParentModel parentData, StudentProvider studentProvider) {
    // Get the list of existing students from the box
    List<StudentModel> existingStudents = studentProvider.mockStudentList;

    // Check if a student with the same firstName, lastName, and parentId already exists (case-insensitive)
    bool nameAndParentExists = existingStudents.any((student) =>
    student.firstName?.toLowerCase() == studentData.firstName?.toLowerCase() &&
        // student.lastName?.toLowerCase() == studentData.lastName?.toLowerCase() &&
        student.parentId?.toLowerCase() == studentData.parentId?.toLowerCase()
    );

    if (nameAndParentExists) {
      // If a student with the same name and parentId exists, throw an exception
      throw Exception("A student with the same name and parent ID already exists.");
    }

    // Proceed with other checks if necessary (e.g., roll number or student ID checks)

    // If no duplicates are found, add the student
    if (_registerParent) {
      ParentProvider().enrollParent(parentData);
    }



    // Notify listeners to update the UI
    notifyListeners();
  }

  Future<List<StudentModel>> getStudentsByStudentIds(List<String> studentIds,StudentProvider studentProvider) async {
    // Get the list of students from the studentBox
    List<StudentModel> allStudents = studentProvider.mockStudentList;

    // Filter students where their studentId matches any of the studentIds in the provided list
    List<StudentModel> matchingStudents = allStudents.where((student) {
      return studentIds.contains(student.studentId);
    }).toList();

    // Simulate some delay if needed (for example, for async database fetches)
    await Future.delayed(Duration(seconds: 1));

    return matchingStudents;
  }

  void changeParentSetting(){
    _registerParent=!_registerParent;
    notifyListeners();
  }

  void onOffDiscount(bool give){
    _giveDiscount=give;
    notifyListeners();
  }


}
