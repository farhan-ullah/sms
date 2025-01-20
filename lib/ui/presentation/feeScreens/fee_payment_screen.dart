import 'package:flutter/material.dart';
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
  FeeModel? paidFee; // Track which fee has been paid

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);

    // Get the mock fee data from FeeProvider
    List<FeeModel> feeData = feeProvider.mockFeeList;

    // Filter the fee data based on the search query and filters (class, fee type, and payment status)
    List<FeeModel> filteredFees = _filterFees(feeData);

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
                    items: _getClassNames(feeData).map((className) {
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
                      hintText: 'Search by Fee Name or Fee ID',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of filtered fees
          Expanded(
            child: ListView.builder(
              itemCount: filteredFees.length,
              itemBuilder: (context, index) {
                final fee = filteredFees[index];
                final student = studentProvider.mockStudentList
                    .firstWhere((student) => student.studentId == fee.feeId, orElse: () => StudentModel(
                  studentId: fee.feeId ?? '',
                  firstName: "Unknown",
                  lastName: "Student",
                  classID: fee.classID,
                ));

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
                        Expanded(flex: 1, child: Text(fee.feeId.toString())),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 2,
                          child: Text("${student.firstName} ${student.lastName}"),
                        ),
                        Expanded(flex: 1, child: Text(fee.classID ?? "")),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {
                            _payFee(fee);
                          },
                          child: Text("Pay Fee"),
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
      bottomSheet: paidFee != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            _showReceiptDialog(paidFee!);
          },
          child: Text("Print Receipt"),
        ),
      )
          : null,
    );
  }

  void _payFee(FeeModel fee) {
    final feeProvider = Provider.of<FeeProvider>(context, listen: false);

    // Mark the fee as paid and update its status
    feeProvider.markFeeAsPaid(fee.feeId.toString());

    // Set the paid fee for printing receipt
    setState(() {
      paidFee = fee; // This triggers the UI to show the print receipt button
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Fee ${fee.feeName} has been marked as paid!")),
    );
  }

  void _showReceiptDialog(FeeModel fee) {
    final student = Provider.of<StudentProvider>(context, listen: false)
        .mockStudentList
        .firstWhere((student) => student.studentId == fee.feeId, orElse: () => StudentModel(
      studentId: fee.feeId ?? '',
      firstName: "Unknown",
      lastName: "Student",
      classID: fee.classID,
    ));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Receipt"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Student: ${student.firstName} ${student.lastName}"),
            Text("Class: ${fee.classID}"),
            Text("Fee Type: ${fee.feeType}"),
            Text("Fee Name: ${fee.feeName}"),
            Text("Amount: \$${fee.generatedFeeAmount}"),
            Text("Payment Status: Paid"),
            Text("Date: ${DateTime.now().toString()}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  List<String> _getClassNames(List<FeeModel> feeData) {
    return feeData
        .map((fee) => fee.classID ?? "")
        .toSet()
        .toList();
  }

  List<FeeModel> _filterFees(List<FeeModel> feeData) {
    return feeData.where((fee) {
      if (selectedClass != null && selectedClass!.isNotEmpty) {
        if (fee.classID != selectedClass) {
          return false;
        }
      }
      if (selectedFeeType != null && selectedFeeType!.isNotEmpty) {
        if (fee.feeType != selectedFeeType) {
          return false;
        }
      }
      if (paymentStatus != null && paymentStatus!.isNotEmpty) {
        if (paymentStatus == 'Paid' && !fee.isFullyPaid!) {
          return false;
        } else if (paymentStatus == 'Pending' && fee.isFullyPaid!) {
          return false;
        }
      }
      if (searchQuery.isNotEmpty) {
        if (!fee.feeName!.toLowerCase().contains(searchQuery.toLowerCase()) &&
            !fee.feeId.toString().contains(searchQuery)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}
