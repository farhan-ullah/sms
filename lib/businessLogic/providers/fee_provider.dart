// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/feeModel/fee_model.dart';
import 'package:school/data/models/student_model/student_model.dart';

class FeeProvider extends ChangeNotifier {
  List<FeeModel> mockFeeList = [
    FeeModel(
      feeId: "F001",
      feeType: "Admission Fee",
      feeName: "Monthly Tuition Fee",
      createdFeeAmount: 5000.00,
      isFullyPaid: false,
      dueDate: "2025-02-28",
      feeDescription: "Monthly tuition fee for February 2025.",
      feeMonth: "February 2025",
      feeArrears: 1000.00,
      dateOfTransaction: "2025-01-01",
      isPartiallyPaid: true,
      feeConcessionInPKR: 500.00,
      classID: "C101",
      generatedFeeAmount: 4500.00,  // After concession
      feeConcessionInPercent: 10.0,  // 10% discount
    ),
    FeeModel(
      feeId: "F002",
      feeType: "Tuition Fee",
      feeName: "Monthly Tuition Fee",
      createdFeeAmount: 6000.00,
      isFullyPaid: true,
      dueDate: "2025-03-31",
      feeDescription: "Monthly tuition fee for March 2025.",
      feeMonth: "March 2025",
      feeArrears: 0.00,
      dateOfTransaction: "2025-02-15",
      isPartiallyPaid: false,
      feeConcessionInPKR: 0.00,
      classID: "C102",
      generatedFeeAmount: 6000.00,  // No concession
      feeConcessionInPercent: 0.0,
    ),
    FeeModel(
      feeId: "F003",
      feeType: "Lab Fee",
      feeName: "Annual Activity Fee",
      createdFeeAmount: 1500.00,
      isFullyPaid: false,
      dueDate: "2025-04-15",
      feeDescription: "Annual fee for extracurricular activities.",
      feeMonth: "April 2025",
      feeArrears: 500.00,
      dateOfTransaction: "2025-03-01",
      isPartiallyPaid: true,
      feeConcessionInPKR: 100.00,
      classID: "C101",
      generatedFeeAmount: 1400.00,  // After concession
      feeConcessionInPercent: 6.67,  // 6.67% discount
    ),
    FeeModel(
      feeId: "F004",
      feeType: "Lab Fee",
      feeName: "Science Lab Fee",
      createdFeeAmount: 2000.00,
      isFullyPaid: false,
      dueDate: "2025-05-30",
      feeDescription: "Fee for Science lab experiments and resources.",
      feeMonth: "May 2025",
      feeArrears: 200.00,
      dateOfTransaction: "2025-04-10",
      isPartiallyPaid: true,
      feeConcessionInPKR: 200.00,
      classID: "C103",
      generatedFeeAmount: 1800.00,  // After concession
      feeConcessionInPercent: 10.0,  // 10% discount
    ),
    FeeModel(
      feeId: "F005",
      feeType: "Tuition Fee",
      feeName: "Monthly Tuition Fee",
      createdFeeAmount: 4500.00,
      isFullyPaid: true,
      dueDate: "2025-02-28",
      feeDescription: "Monthly tuition fee for February 2025.",
      feeMonth: "February 2025",
      feeArrears: 0.00,
      dateOfTransaction: "2025-01-20",
      isPartiallyPaid: false,
      feeConcessionInPKR: 0.00,
      classID: "C104",
      generatedFeeAmount: 4500.00,  // No concession
      feeConcessionInPercent: 0.0,
    ),
  ];

  // Assuming you have a method to get fee amount by class and fee type



  // Placeholder for fee amount retrieval by class and fee type
  double getFeeByClass(String classId, String feeType) {
    // Example fee amount logic (replace with actual logic as needed)
    return 1000.0; // Example value, replace with actual fee retrieval
  }
  bool _isConcessionInRupees = true; // Default to Rupees

  // Getter for the concession type
  bool get isConcessionInRupees => _isConcessionInRupees;


  // Get the list of all fees (you can filter these based on your requirements)
  List<FeeModel> get allFees => mockFeeList;

  // Mark a fee as paid
  void markFeeAsPaid(String studentId) {
    // Find the fee that needs to be updated by studentId
    var feeToUpdate = mockFeeList.firstWhere((fee) => fee.feeId == studentId, orElse:  null);

    feeToUpdate.isFullyPaid = true; // Mark fee as fully paid
    feeToUpdate.isPartiallyPaid = false; // Ensure it's not partially paid anymore
    feeToUpdate.feeArrears = 0.0; // Set arrears to zero

    // Update the fee record in Hive
    notifyListeners(); // Notify listeners to refresh any dependent UI
    }



  // Method to toggle concession type (Rupees vs Percentage)
  void toggleConcessionType(bool isRupees) {
    _isConcessionInRupees = isRupees;
    notifyListeners(); // Notifies listeners to update the UI
  }

  createFeeType(String feeType,String dateOfTransaction ,[double feeAmount = 0,bool isPartiallyPaid=false,]) {
    final feeTypeData = FeeModel(
      isPartiallyPaid: isPartiallyPaid,
      dateOfTransaction: dateOfTransaction,


      createdFeeAmount: feeAmount,
      feeId: "1",
      feeName: "2",
      feeType: feeType,
      isFullyPaid: false,
      dueDate: "1",
      feeDescription: "1",
      feeMonth: "1",
    );
    notifyListeners();
  }

  void changeFeeType(int index, String newType, [double? newFee]) {
    // Retrieve the FeeModel objects from the box
    List<FeeModel> data =mockFeeList;

    // Update the fee type
    data[index].feeType = newType;

    // Check if newFee is not null and not empty before updating the fee amount
    if (newFee != null) {
      data[index].createdFeeAmount = newFee;
    }

    // Save the changes to the data

    // Notify listeners about the change
    notifyListeners();
  }

  deleteFeeType(int index) {
    List<FeeModel> data = mockFeeList;
    notifyListeners();
  }

  createNewFee(
FeeModel feeModel


  ) {

    print("osho");
    notifyListeners();
  }







  ///
  ///

  Future<void> payFeeForStudent(String studentId, int year, int month, double amountPaid, StudentProvider studentProvider) async {
    // Validate the month and year
    if (month < 1 || month > 12) {
      throw 'Invalid month. Please provide a valid month between 01 and 12.';
    }

    // Format the month and year to 'yyyy-MM' format
    String formattedMonth = DateFormat('yyyy-MM').format(DateTime(year, month));

    // Open the student box

    // Find the student by ID
    StudentModel? student = studentProvider.mockStudentList.firstWhere(
          (student) => student.studentId == studentId,
      orElse:  null,
    );

    // If the student is not found, throw an exception
    if (student == null) {
      throw 'Student with ID $studentId not found';
    }

    // Check if the student has fee data for the specified month and fee type "tuitionFee"
    if (student.studentAllFeeTypes != null) {
      bool feePaid = false;

      // Iterate through the fee types for this student
      student.studentAllFeeTypes!.forEach((feeType, feeModel) {
        // Process only "tuitionFee"
        if (feeType == 'tuitionFee') {
          // Check if the fee for the specified month exists
          if (feeModel.feeMonth == formattedMonth) {
            // Check if the fee has been generated
            if (feeModel.generatedFeeAmount != null && feeModel.generatedFeeAmount! > 0) {

              // Calculate if the fee is fully paid or partially paid
              double amountRemaining = feeModel.generatedFeeAmount! - (feeModel.isFullyPaid == true ? feeModel.generatedFeeAmount! : 0);

              if (amountRemaining > 0) {
                // If the amount remaining is greater than 0, check if it's a full or partial payment
                if (amountPaid >= amountRemaining) {
                  feeModel.isFullyPaid = true; // Mark as fully paid
                  feeModel.isPartiallyPaid = false; // Reset partial payment
                } else {
                  feeModel.isPartiallyPaid = true; // Mark as partially paid
                  feeModel.isFullyPaid = false; // Reset full payment status
                }

                // Update the fee details
                feeModel.generatedFeeAmount = feeModel.generatedFeeAmount! - amountPaid;
                feeModel.dateOfTransaction = DateTime.now().toString(); // Store the payment date

                feePaid = true;
              } else {
                throw 'The fee has already been fully paid for $formattedMonth';
              }
            }
          }
        }
      });

      if (feePaid) {
        // Save the updated student data back to the box
        print('Fee paid successfully for student $studentId');
      } else {
        throw 'No fee generated for the specified month, or fee is already paid.';
      }
    } else {
      throw 'No fee data available for this student';
    }
  }




  deleteFeesID(int index){
    List<FeeModel> feeIdData= mockFeeList;
    notifyListeners();
  }


  double getAdmissionFeeByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> admissionFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Admission Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (admissionFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return admissionFees[0].createdFeeAmount ?? 0;
  }
  double getLabFeeByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> labFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Lab Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (labFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return labFees[0].createdFeeAmount ?? 0;
  }
  double getSportsFeeByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> sportsFee = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Sports Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (sportsFee.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return sportsFee[0].createdFeeAmount ?? 0;
  }

  double getFineByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> fine = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Fine')
        .toList();

    // If no tuition fees exist, return 0
    if (fine.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return fine[0].createdFeeAmount ?? 0;
  }
  double getOtherFeeByClass(String classID) {

    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> otherFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Other Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (otherFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return otherFees[0].createdFeeAmount ?? 0;
  }


  double getTransportFeeByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> transportFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Transport Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (transportFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return transportFees[0].createdFeeAmount ?? 0;
  }


  double getTuitionFeeByClass(String classID) {


    // Filter fees by className and feeType ('Tuition Fee')
    List<FeeModel> tuitionFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Tuition Fee')
        .toList();

    // If no tuition fees exist, return 0
    if (tuitionFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Tuition Fee
    return tuitionFees[0].createdFeeAmount ?? 0;
  }




  void generateFee(List<String> studentIds, String feeType, double feeAmount, String feeMonth,StudentProvider studentProvider) {
    // Step 1: Create the FeeModel object for the new fee
    final fee = FeeModel(
      isFullyPaid: false,
      isPartiallyPaid: false,
      feeType: feeType,
      feeName: feeType,
      createdFeeAmount: feeAmount,
      feeMonth: feeMonth,
    );

    // Step 2: Get the list of students from the Hive database

    List<StudentModel> studentDataInList = studentProvider.mockStudentList;

    // Step 3: Loop through the list of student IDs to generate the fee for each student
    for (String studentId in studentIds) {
      try {
        // Find the student with the matching ID, throw an exception if not found
        final student = studentDataInList.firstWhere(
              (student) => student.studentId == studentId,
        );

        // Step 4: Retrieve the student's fee map or initialize it if it's null
        Map<String, FeeModel> oneFee = student.studentAllFeeTypes ?? {};

        // Step 5: Check if the fee already exists for the given month and year
        if (oneFee.containsKey(feeType) && oneFee[feeType]?.feeMonth == feeMonth) {
          print("Fee for $feeType in month $feeMonth has already been generated for student ID: $studentId.");
          return; // Prevent duplicate fee generation
        }

        // Step 6: Handle the "Admission Fee" separately to allow it only once
        if (feeType == "Admission Fee" && oneFee.containsKey(feeType)) {
          print("Admission Fee has already been generated for student ID: $studentId.");
          return; // Prevent generating Admission Fee more than once
        }

        // Step 7: Update the map with the new fee
        oneFee[feeType] = fee;

        // Step 8: Update the student's fee map in the student model
        student.studentAllFeeTypes = oneFee;

        // Step 9: Save the updated student model back to the Hive database

        // Debug print: You can check the fee in the map using the feeType as the key
        print("Fee for $feeType updated: ${oneFee[feeType]?.createdFeeAmount} for student ID: $studentId (${student.classID})");

      } catch (e) {
        // If no student is found with the provided ID, print an error message
        print("Error: Student with ID $studentId not found.");
      }
    }
  }







///UI Setting
String _selectedFeeType = 'Not Specified';
 String get selectedFeeType =>_selectedFeeType;


  String _selectedFeeTypeInGenerateFeeScreen = 'Not Specified';
  String get selectedFeeTypeInGenerateFeeScreen =>_selectedFeeTypeInGenerateFeeScreen;


  void changeSelectedFeeType(String newSelectedValue){
    _selectedFeeType =newSelectedValue;
    notifyListeners();
  }






}
