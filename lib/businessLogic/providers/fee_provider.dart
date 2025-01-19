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
      feeType: "Tuition",
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
      feeType: "Tuition",
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
      feeType: "Activity Fee",
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
      feeType: "Tuition",
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


  // Function to get students with ungenerated fees
  Future<List<StudentModel>> getStudentsWithUnGeneratedFee(
      List<StudentModel> studentProvider, String feeType) async {
    List<StudentModel> unGeneratedStudents = [];

    for (var student in studentProvider) {
      // Check if the student has the fee type in their studentAllFeeTypes map
      if (student.studentAllFeeTypes != null &&
          !student.studentAllFeeTypes!.containsKey(feeType)) {
        // If the fee type does not exist in studentAllFeeTypes, add this student to the list
        unGeneratedStudents.add(student);
      }
    }

    return unGeneratedStudents;
  }

  // Function to generate fee for a single student
  void generateFeeForSingleStudent(
      String studentId, String feeType, double amount, String month) {
    // Find the student by ID
    StudentModel student = mockStudentList.firstWhere((s) => s.studentId == studentId);

    // If the student doesn't already have the fee type in their studentAllFeeTypes, add it
    if (student.studentAllFeeTypes == null) {
      student.studentAllFeeTypes = {};
    }

    // Add a new FeeModel to the student's studentAllFeeTypes map
    student.studentAllFeeTypes![feeType] = FeeModel(
      generatedFeeAmount: amount,
      feeType: feeType,
      feeMonth: month,
    );

    // Notify listeners that the fees have been updated
    notifyListeners();
  }

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
  Future<void> generateTuitionFeeForStudent(
      String studentID,
      int year,
      int month,
      StudentProvider studentProvider
      ) async {
    // Validate the month and year
    if (month < 1 || month > 12) {
      throw 'Invalid month. Please provide a valid month between 01 and 12.';
    }

    // Format the month and year to 'yyyy-MM' format
    String formattedMonth = DateFormat('yyyy-MM').format(DateTime(year, month));

    // Open the Hive box for students

    // Find the student by their ID
    StudentModel? student = studentProvider.mockStudentList.firstWhere(
          (student) => student.studentId == studentID,
      orElse: null,
    );

    if (student == null) {
      throw 'Student with ID $studentID not found.';
    }

    // Check if the student has fee data and the specified fee type
    if (student.studentAllFeeTypes != null) {
      var feeModel = student.studentAllFeeTypes!['tuitionFee'];

      if (feeModel != null) {
        // Check if the fee for the specified month and year is already generated
        if (feeModel.feeMonth == formattedMonth && feeModel.generatedFeeAmount != null) {
          throw 'The tuition fee for the specified month and year has already been generated.';
        }

        // Generate the fee amount (this is just an example, you can implement the actual fee calculation logic)
        double generatedFeeAmount = calculateTuitionFeeAmount(student);

        // Update the fee model with the generated fee
        feeModel.generatedFeeAmount = generatedFeeAmount;
        feeModel.feeMonth = formattedMonth;

        // Save the updated student data back to the Hive box

        print('Tuition fee for student $studentID has been generated for $formattedMonth.');
      } else {
        throw 'No tuition fee type found for student $studentID.';
      }
    } else {
      throw 'No fee data found for student $studentID.';
    }
  }

  double calculateTuitionFeeAmount(StudentModel student) {
    // Implement your logic here to calculate the tuition fee amount
    // For example, let's assume a fixed fee amount for the demonstration
    return 1000.0; // You can replace this with your actual fee calculation logic
  }


// Function to get students whose tuition fee for a specified year and month hasn't been generated
  Future<List<StudentModel>> getStudentsWithUnGeneratedFeeForYearAndMonth(
      int year, String monthName, StudentProvider studentProvider) async {
    // Validate the month name (ensure it's a valid month)
    List<String> validMonths = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];
    if (!validMonths.contains(monthName)) {
      throw 'Invalid month. Please provide a valid month like January, February, etc.';
    }

    // Get the numeric value of the month (1 for January, 2 for February, etc.)
    int month = validMonths.indexOf(monthName) + 1;

    // Format the month and year to 'yyyy-MM' format
    String formattedMonth = DateFormat('yyyy-MM').format(DateTime(year, month));

    // Get the box for the students (this assumes you're storing StudentModel instances in a Hive box)
    // List to store the students whose fee is not generated for the provided year and month
    List<StudentModel> studentsWithUnpaidFee = [];

    // Iterate through the students in the Hive box
    for (var student in studentProvider.mockStudentList) {
      print('Student found: ${student.firstName} ${student.lastName}, ID: ${student.studentId}'); // Debug: Print student

      bool feeForSpecifiedMonthGenerated = false;

      // Check if the student has fee data
      if (student.studentAllFeeTypes != null && student.studentAllFeeTypes!.isNotEmpty) {
        print('Fee types for student ${student.firstName} ${student.lastName}: ${student.studentAllFeeTypes!.keys.join(', ')}');  // Debug: Print fee types

        // Iterate through the fee types for this student, process only "tuitionFee"
        for (var feeType in student.studentAllFeeTypes!.keys) {
          if (feeType == 'tuitionFee') {
            var feeModel = student.studentAllFeeTypes![feeType];

            // Check if the feeModel and its properties are not null
            if (feeModel != null) {
              print('Comparing fee month: ${feeModel?.feeMonth} with formatted month: $formattedMonth');  // Debugging line

              // Check if the fee type's feeMonth matches the specified month and year (formatted as 'yyyy-MM')
              if (feeModel.feeMonth == formattedMonth) {
                if (feeModel.generatedFeeAmount == null) {
                  // If the fee has not been generated
                  feeForSpecifiedMonthGenerated = false;
                } else {
                  feeForSpecifiedMonthGenerated = true;
                  break;  // Exit the loop if the fee is already generated
                }
              }
            }
          }
        }
      }

      // If the fee for the specified month and year is not generated, add the student to the list
      if (!feeForSpecifiedMonthGenerated) {
        studentsWithUnpaidFee.add(student);
      }
    }

    // Return the list of students with unpaid fee for the specified month
    return studentsWithUnpaidFee;
  }

  Future<List<StudentModel>> getStudentsWithUnGeneratedAdmissionFee(StudentProvider studentProvider) async {
    // Get the box for the students (this assumes you're storing StudentModel instances in a Hive box)

    // List to store the students whose admission fee is not generated
    List<StudentModel> studentsWithUnpaidAdmissionFee = [];

    print('Total students in box: ${studentProvider.mockStudentList.length}'); // Debug: Print the number of students in the box

    // Iterate through the students in the Hive box
    for (var student in studentProvider.mockStudentList) {
      print('Student found: ${student.firstName} ${student.lastName}, ID: ${student.studentId}'); // Debug: Print student

      bool admissionFeeGenerated = false;

      // Check if the student has fee data
      if (student.studentAllFeeTypes != null && student.studentAllFeeTypes!.isNotEmpty) {
        print('Fee types for student ${student.firstName} ${student.lastName}: ${student.studentAllFeeTypes!.keys.join(', ')}');  // Debug: Print fee types

        // Iterate through the fee types for this student, process only "Admission Fee"
        for (var feeType in student.studentAllFeeTypes!.keys) {
          print('Checking fee type: $feeType');  // Debug: Print the current fee type being checked

          if (feeType == 'Admission Fee') {
            var feeModel = student.studentAllFeeTypes![feeType];

            if (feeModel == null) {
              print('FeeModel for Admission Fee is null for student ${student.firstName} ${student.lastName}'); // Debug: Check if feeModel is null
            } else {
              print('FeeModel for Admission Fee found for student ${student.firstName} ${student.lastName}'); // Debug: FeeModel found
            }

            // Check if the feeModel and its properties are not null
            if (feeModel != null) {
              // Check if the admission fee has been generated (generatedFeeAmount is not null)
              if (feeModel.generatedFeeAmount != null) {
                print('Admission fee has been generated for student ${student.firstName} ${student.lastName}, Amount: ${feeModel.generatedFeeAmount}');  // Debug: Fee amount found
                admissionFeeGenerated = true;
                break;  // Exit the loop if the admission fee is already generated
              } else {
                print('Admission fee has NOT been generated for student ${student.firstName} ${student.lastName}, Amount is null');  // Debug: Fee amount is null
              }
            }
          }
        }
      } else {
        print('No fee types available for student ${student.firstName} ${student.lastName}');  // Debug: No fee data available for student
      }

      // If the admission fee has not been generated, add the student to the list
      if (!admissionFeeGenerated) {
        print('Student ${student.firstName} ${student.lastName} has not paid admission fee, adding to the list');  // Debug: Student not paying fee
        studentsWithUnpaidAdmissionFee.add(student);
      } else {
        print('Student ${student.firstName} ${student.lastName} has paid admission fee, skipping');  // Debug: Fee already generated
      }
    }

    // Return the list of students with unpaid admission fee
    print('Total students with unpaid admission fee: ${studentsWithUnpaidAdmissionFee.length}');  // Debug: Print final count of students with unpaid fee
    return studentsWithUnpaidAdmissionFee;
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


  editFeeIDNameAmountDueDateDescription(
    String feeId,
    int index,
    String feeName,
    String feeType,
    double feeAmount, [
    String feeMonth = "",
    String feeDescription = "",
    String dueDate = "",
  ]) {
    List<FeeModel> changeFeeData = mockFeeList;
    changeFeeData[index].feeId=feeId;
    changeFeeData[index].feeName=feeName;
    changeFeeData[index].feeDescription=feeDescription;
    changeFeeData[index].createdFeeAmount=feeAmount;
    changeFeeData[index].feeMonth=feeMonth;
    changeFeeData[index].dueDate=dueDate;
    notifyListeners();
  }


  deleteFeesID(int index){
    List<FeeModel> feeIdData= mockFeeList;
    notifyListeners();
  }

  double getAdmissionFeeByClass(String classID) {


    // Filter fees by className and feeType ('Admission Fee')
    List<FeeModel> admissionFees = mockFeeList
        .where((fee) => fee.classID == classID && fee.feeType == 'Admission Fee')
        .toList();

    // If no admission fees exist, return 0
    if (admissionFees.isEmpty) {
      return 0;
    }

    // Return the feeAmount of the first Admission Fee
    return admissionFees[0].createdFeeAmount ?? 0;
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
  // void generateFeeForSingleStudent(String studentId, String feeType, int feeAmount, String feeMonth) {
  //   // Step 1: Create the FeeModel object for the new fee
  //   final fee = FeeModel(
  //     isFullyPaid: false,
  //     isPartiallyPaid: false,
  //     feeType: feeType,
  //     feeName: feeType,
  //     feeAmount: feeAmount,
  //     feeMonth: feeMonth,
  //   );
  //
  //   // Step 2: Get the list of students from the Hive database
  //   List<StudentModel> studentDataInList = Boxes.getStudents().values.toList().cast<StudentModel>();
  //
  //   try {
  //     // Step 3: Find the student with the matching ID
  //     final student = studentDataInList.firstWhere(
  //           (student) => student.studentId == studentId,
  //       orElse: () => throw Exception("Student with ID $studentId not found."),
  //     );
  //
  //     // Step 4: Retrieve the student's fee map or initialize it if it's null
  //     Map<String, FeeModel> oneFee = student.studentAllFeeTypes ?? {};
  //
  //     // Step 5: Check if the fee already exists for the given month and year
  //     if (oneFee.containsKey(feeType) && oneFee[feeType]?.feeMonth == feeMonth) {
  //       print("Fee for $feeType in month $feeMonth has already been generated for student ID: $studentId.");
  //       return; // Prevent duplicate fee generation
  //     }
  //
  //     // Step 6: Handle the "Admission Fee" separately to allow it only once
  //     if (feeType == "Admission Fee" && oneFee.containsKey(feeType)) {
  //       print("Admission Fee has already been generated for student ID: $studentId.");
  //       return; // Prevent generating Admission Fee more than once
  //     }
  //
  //     // Step 7: Update the map with the new fee
  //     oneFee[feeType] = fee;
  //
  //     // Step 8: Update the student's fee map in the student model
  //     student.studentAllFeeTypes = oneFee;
  //
  //     // Step 9: Save the updated student model back to the Hive database
  //     student.save();
  //
  //     // Debug print: You can check the fee in the map using the feeType as the key
  //     print("Fee for $feeType updated: ${oneFee[feeType]?.feeAmount} for student ID: $studentId (${student.className})");
  //
  //   } catch (e) {
  //     // If no student is found with the provided ID, print an error message
  //     print("Error: Student with ID $studentId not found.");
  //   }
  // }
  Future<void> generateAdmissionFeeForStudents(StudentProvider studentProvider) async {
    // Get the box for the students (this assumes you're storing StudentModel instances in a Hive box)

    // Iterate through all students
    for (var student in studentProvider.mockStudentList) {
      print('Processing student: ${student.firstName} ${student.lastName}, ID: ${student.studentId}'); // Debug: Print student

      // Check if the student already has an admission fee generated
      if (student.studentAllFeeTypes != null && student.studentAllFeeTypes!.containsKey('Admission Fee')) {
        var admissionFee = student.studentAllFeeTypes!['Admission Fee'];

        // If the admission fee hasn't been generated yet (generatedFeeAmount is null)
        if (admissionFee?.generatedFeeAmount == null) {
          print('Generating admission fee for student: ${student.firstName} ${student.lastName}'); // Debug: Fee generation

          // Create a new FeeModel for the admission fee
          FeeModel admissionFeeModel = FeeModel(
            feeId: 'admission_fee_${student.studentId}',  // A unique ID for the fee
            feeType: 'Admission Fee',
            feeName: 'Admission Fee for ${student.firstName} ${student.lastName}',
            createdFeeAmount: 5000.0, // Example fee amount, replace with your logic for the fee amount
            generatedFeeAmount: 5000.0,  // Mark the fee as generated with the amount
            isFullyPaid: false,  // Default to false, assuming the fee is not paid immediately
            feeDescription: 'One-time admission fee',
            dueDate: '2025-01-01',  // Example due date, modify as needed
            dateOfTransaction: DateTime.now().toString(),
            isPartiallyPaid: false,
            feeConcessionInPKR: 0.0,
            feeMonth: null,  // No month for a one-time fee
            feeArrears: 0.0,
            classID: student.classID,  // Use the student's class ID
          );

          // Add the generated fee to the student's fee types
          student.studentAllFeeTypes!['Admission Fee'] = admissionFeeModel;

          // Update the student's data in the Hive box
          print('Admission fee generated for student: ${student.firstName} ${student.lastName}');
        } else {
          print('Admission fee already generated for student: ${student.firstName} ${student.lastName}');
        }
      } else {
        print('No fee types found for student: ${student.firstName} ${student.lastName}');
      }
    }
  }

  void generateAdmissionFeeForSingleStudent(double feeAmount,int index, String feeDescription, StudentProvider studentProvider){

    // Assuming studentDataInList is a list of StudentModel objects
    var student = studentProvider.mockStudentList[index];

// Create the FeeModel for "Admission Fee"
    FeeModel admissionFeeModel = FeeModel(
      feeType: "Admission Fee",
      feeName: "Admission Fee",
      isFullyPaid: false,
      isPartiallyPaid: false,
      generatedFeeAmount: feeAmount,
      createdFeeAmount: feeAmount,
      feeDescription: feeDescription,
    );

// Check if the student's fee types map is null, if so, initialize it
    student.studentAllFeeTypes ??= {};

// Add the Admission Fee model to the student's fee types map
    student.studentAllFeeTypes!["Admission Fee"] = admissionFeeModel;

// Save the updated student model back to Hive


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


  // generateFee(int index, String className) {
  //   // Retrieve the list of students from the box
  //   List<StudentModel> studentDataInList = Boxes.getStudents().values.toList().cast<StudentModel>();
  //
  //   // Access the student based on the index
  //   StudentModel student = studentDataInList[index];
  //
  //   // Retrieve the studentAllFeeTypes map
  //   Map<String, FeeModel> studentFee = student.studentAllFeeTypes ?? {};
  //
  //   // Define the specific fee type you want to update or generate
  //   String feeTypeToGenerate = "Admission Fee"; // For example, "Tuition Fee"
  //
  //   // If the fee type doesn't exist, create a new FeeModel
  //
  //     // If the fee type exists, update the fee
  //     FeeModel fee = studentFee[feeTypeToGenerate]!;
  //
  //     // Modify the fee amount (if needed)
  //     fee.feeAmount = getFeeByClass(className); // Example: Set new fee amount
  //
  //     // Optionally, update other properties if needed (e.g., due date)
  //     fee.dueDate = DateTime.now().add(Duration(days: 30)).toString(); // Example: Update the due date
  //
  //     // Save the updated fee model back to the map
  //     studentFee[feeTypeToGenerate] = fee;
  //
  //
  //   // Recalculate the total fee for the student (if needed)
  //   double totalFee = 0;
  //   studentFee.forEach((key, fee) {
  //     totalFee += fee.feeAmount!.toDouble();
  //   });
  //   print("Total Fee for ${student.firstName} ${student.lastName}: $totalFee");
  //
  //   // Save the updated student object back to the Hive box
  //   student.save(); // Saving the student back to Hive
  // }

  payFullFee(){

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

  void changeSelectedFeeTypeInGenerateFeeScreen(String newSelectedValue){
    _selectedFeeTypeInGenerateFeeScreen =newSelectedValue;
    notifyListeners();
  }





}
