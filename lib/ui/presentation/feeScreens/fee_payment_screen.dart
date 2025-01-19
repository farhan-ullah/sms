import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/student_model/student_model.dart';
import 'package:school/data/models/feeModel/fee_model.dart';

class FeePaymentScreen extends StatefulWidget {
  const FeePaymentScreen({super.key});

  @override
  State<FeePaymentScreen> createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  String? selectedClass;
  String? selectedFeeType;
  String? paymentStatus;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);

    final studentBox = studentProvider.mockStudentList;
    List<StudentModel> studentData = studentBox.toList().cast<StudentModel>();

    List<StudentModel> filteredStudents = _filterStudents(studentData);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fee Payments"),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedClass = null;
                selectedFeeType = null;
                paymentStatus = null;
                searchQuery = "";
              });
            },
            child: Text("Reset Filters"),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Class'),
                    value: selectedClass,
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                    items: _getClassNames(studentData).map((className) {
                      return DropdownMenuItem<String>(
                        value: className,
                        child: Text(className),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Fee Type'),
                    value: selectedFeeType,
                    onChanged: (value) {
                      setState(() {
                        selectedFeeType = value;
                      });
                    },
                    items: ['Admission Fee', 'Tuition Fee', 'Lab Fee', 'Sports Fee', 'Transport Fee', 'Fine', 'Other'].map((feeType) {
                      return DropdownMenuItem<String>(
                        value: feeType,
                        child: Text(feeType),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Payment Status'),
                    value: paymentStatus,
                    onChanged: (value) {
                      setState(() {
                        paymentStatus = value;
                      });
                    },
                    items: ['Paid', 'Pending', 'Partially Paid', 'Overdue'].map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Name or ID',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of filtered students
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                // List<FeeModel> studentFees = _getStudentFees(student);

                return GestureDetector(
                  onTap: () {
                    // _showPaymentDialog(student, studentFees);
                  },
                  child: Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 30),
                        Expanded(flex: 1, child: Text(student.studentId.toString())),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 2,
                          child: Text("${student.firstName} ${student.lastName}"),
                        ),
                        Expanded(flex: 1, child: Text(student.classID ?? "")),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("It should remove it from generated fee list and add to paid fee list")));
                          },
                          child: Text("Pay Fee"),
                          ///It should remove this fee from generated fee list to paid fee list of the basis of student ID.
                          ///and also it should remove this amount from the fee receivable to cash.. like debit the cash and credit the amount receivable
                          ///and also the print the paid receipt.
                          ///
                          ///
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _markFeeAsPaid(StudentModel student) {
    // Mark the fee as paid for the student
    final feeProvider = Provider.of<FeeProvider>(context, listen: false);
    feeProvider.markFeeAsPaid(student.studentId ?? "");
  }

  void _showPaymentDialog(StudentModel student, List<FeeModel> fees) {
    // Show dialog to update payment status
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Payment Status for ${student.firstName} ${student.lastName}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: Text('Payment Status'),
                value: paymentStatus,
                onChanged: (value) {
                  setState(() {
                    paymentStatus = value;
                  });
                },
                items: ['Paid', 'Pending', 'Partially Paid', 'Overdue'].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  _markFeeAsPaid(student);
                  Navigator.pop(context);
                },
                child: Text("Update Payment Status"),
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> _getClassNames(List<StudentModel> students) {
    return students
        .map((student) => student.classID ?? "")
        .toSet()
        .toList();
  }

  // List<FeeModel> _getStudentFees(StudentModel student) {
  //   final feeBox = Boxes.getFees();
  //   return feeBox.values
  //       .where((fee) => fee.classID == student.classID)
  //       .toList()
  //       .cast<FeeModel>();
  // }

  List<StudentModel> _filterStudents(List<StudentModel> students) {
    return students.where((student) {
      if (selectedClass != null && selectedClass!.isNotEmpty) {
        if (student.classID != selectedClass) {
          return false;
        }
      }
      if (searchQuery.isNotEmpty) {
        if (!("${student.firstName} ${student.lastName}".toLowerCase()).contains(searchQuery.toLowerCase()) &&
            !student.studentId.toString().contains(searchQuery)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}
