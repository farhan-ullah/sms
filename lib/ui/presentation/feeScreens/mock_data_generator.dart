import 'dart:math';

import '../../../data/models/feeModel/fee_model.dart';
import '../../../data/models/student_model/student_model.dart';

class MockDataGenerator {
  // Random number generator to simulate fee and discount values
  final Random _random = Random();

  // List of student names (just for example purposes)
  List<String> studentNames = [
    "John Doe", "Jane Smith", "Alice Johnson", "Bob Brown", "Charlie Davis"
  ];

  // List of fee types
  List<String> feeTypes = [
    "Admission Fee", "Tuition Fee", "Lab Fee", "Sports Fee", "Transport Fee", "Fine", "Other"
  ];

  // Generate mock student data
  List<StudentModel> generateMockStudents(int count) {
    List<StudentModel> students = [];
    for (int i = 0; i < count; i++) {
      var student = StudentModel(
          firstName: studentNames[_random.nextInt(studentNames.length)],
          lastName: studentNames[_random.nextInt(studentNames.length)],
          studentId: "S${1000 + i}",
          classID: "Class ${_random.nextInt(12) + 1}",
          studentAllFeeTypes: generateMockFees()
      );
      students.add(student);
    }
    return students;
  }

  // Generate mock fee data for a student
  Map<String, FeeModel> generateMockFees() {
    Map<String, FeeModel> fees = {};
    for (var feeType in feeTypes) {
      fees[feeType] = FeeModel(
        feeId: _generateFeeId(),
        feeType: feeType,
        feeName: "$feeType for ${_random.nextBool() ? 'New Admission' : 'Semester'}",
        createdFeeAmount: _generateRandomFeeAmount(),
        feeArrears: _generateRandomFeeAmount(),
        feeConcessionInPKR: _generateRandomFeeConcession(),
        feeConcessionInPercent: _generateRandomFeeConcessionPercent(),
        dueDate: _generateRandomDueDate(),
        isFullyPaid: _random.nextBool(),
        isPartiallyPaid: _random.nextBool(),
        generatedFeeAmount: _generateRandomFeeAmount(),
        feeMonth: _getRandomMonth(),
        dateOfTransaction: _generateRandomDate(),
      );
    }
    return fees;
  }

  // Generate a random fee ID (for demo purposes)
  String _generateFeeId() {
    return "F${_random.nextInt(9999)}";
  }

  // Generate a random fee amount (between 1000 and 5000)
  double _generateRandomFeeAmount() {
    return (1000 + _random.nextInt(4000)).toDouble();
  }

  // Generate random fee concession in PKR (between 0 and 500)
  double _generateRandomFeeConcession() {
    return (0 + _random.nextInt(500)).toDouble();
  }

  // Generate random fee concession in percentage (between 0% and 30%)
  double _generateRandomFeeConcessionPercent() {
    return _random.nextInt(30).toDouble();
  }

  // Generate a random due date (between the current date and the next 60 days)
  String _generateRandomDueDate() {
    DateTime now = DateTime.now();
    DateTime dueDate = now.add(Duration(days: _random.nextInt(60)));
    return "${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}";
  }

  // Generate random transaction date (for simplicity, within the last year)
  String _generateRandomDate() {
    DateTime now = DateTime.now();
    DateTime randomDate = now.subtract(Duration(days: _random.nextInt(365)));
    return "${randomDate.year}-${randomDate.month.toString().padLeft(2, '0')}-${randomDate.day.toString().padLeft(2, '0')}";
  }

  // Return a random month (for simplicity, using only the first 6 months)
  String _getRandomMonth() {
    List<String> months = ["January", "February", "March", "April", "May", "June"];
    return months[_random.nextInt(months.length)];
  }
}
