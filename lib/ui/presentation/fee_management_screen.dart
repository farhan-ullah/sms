import 'package:flutter/material.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  String selectedFeeStatus = 'All'; // Fee Status filter

  // Sample list of students with their fee details
  List<StudentFee> studentFees = [
    StudentFee(id: 1, name: 'John Doe', className: '10th Grade', feeMonth: 'January', feeAmount: 1000.0, paidAmount: 200.0, arrears: 0.0, type: 'Full Fee'),
    StudentFee(id: 2, name: 'Jane Smith', className: '9th Grade', feeMonth: 'February', feeAmount: 1200.0, paidAmount: 0.0, arrears: 1200.0, type: 'Partial Fee'),
    StudentFee(id: 3, name: 'Emily Clark', className: '12th Grade', feeMonth: 'March', feeAmount: 1100.0, paidAmount: 1100.0, arrears: 0.0, type: 'Full Fee'),
    StudentFee(id: 4, name: 'Michael Brown', className: '11th Grade', feeMonth: 'April', feeAmount: 1050.0, paidAmount: 500.0, arrears: 550.0, type: 'Partial Fee'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Management'),
      ),
      body: Column(
        children: [
          // Fee Status Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedFeeStatus,
              items: const [
                DropdownMenuItem(child: Text('All'), value: 'All'),
                DropdownMenuItem(child: Text('Paid Fee'), value: 'Paid Fee'),
                DropdownMenuItem(child: Text('Unpaid Fee'), value: 'Unpaid Fee'),
                DropdownMenuItem(child: Text('Arrears'), value: 'Arrears'),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFeeStatus = value!;
                });
              },
            ),
          ),

          // Header Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded( child: Text("Student ID", textAlign: TextAlign.left)),
                  Expanded(flex: 2, child: Text("Student Name", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Class", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Fee Type", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Amount", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Paid", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Arrears", textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text("Actions", textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),

          // Student list based on the selected filter
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredStudents().length,
              itemBuilder: (context, index) {
                StudentFee studentFee = _getFilteredStudents()[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Student ID
                        Expanded( child: Text('${studentFee.id}', textAlign: TextAlign.left)),

                        // Student Name
                        Expanded(flex: 2, child: Text(studentFee.name, textAlign: TextAlign.center)),

                        // Class
                        Expanded(flex: 1, child: Text(studentFee.className, textAlign: TextAlign.center)),

                        // Fee Type
                        Expanded(flex: 1, child: Text(studentFee.type, textAlign: TextAlign.center)),

                        // Fee Amount
                        Expanded(flex: 1, child: Text('\$${studentFee.feeAmount.toStringAsFixed(2)}', textAlign: TextAlign.center)),

                        // Paid Amount
                        Expanded(flex: 1, child: Text('\$${studentFee.paidAmount.toStringAsFixed(2)}', textAlign: TextAlign.center)),

                        // Arrears
                        Expanded(flex: 1, child: Text('\$${studentFee.arrears.toStringAsFixed(2)}', textAlign: TextAlign.center)),

                        // Actions
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => _showPaymentDialog(context, studentFee, studentFee.feeAmount.toString()),
                                child: Text( 'Pay Fee'),
                              ),
                              // ElevatedButton(
                              //   onPressed: () => _showPaymentDialog(context, studentFee),
                              //   child: Text(studentFee.arrears > 0 ? 'Pay Arrears' : 'Pay Fee'),
                              // ),
                              IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () => _showMoreOptions(context, studentFee),
                              ),
                            ],
                          ),
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

  // Filter students by the selected fee status
  List<StudentFee> _getFilteredStudents() {
    if (selectedFeeStatus == 'Paid Fee') {
      return studentFees.where((fee) => fee.paidAmount == fee.feeAmount).toList();
    } else if (selectedFeeStatus == 'Unpaid Fee') {
      return studentFees.where((fee) => fee.paidAmount < fee.feeAmount && fee.paidAmount > 0).toList();
    } else if (selectedFeeStatus == 'Arrears') {
      return studentFees.where((fee) => fee.arrears > 0.0).toList();
    } else {
      return studentFees; // If 'All', return all students
    }
  }

  // Show payment dialog
  void _showPaymentDialog(BuildContext context, StudentFee studentFee, String fee) {
    TextEditingController amountController = TextEditingController();
    double amountToPay = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pay Fee for ${studentFee.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  labelText: fee,
                  hintText: 'Amount to pay',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                amountToPay = double.tryParse(amountController.text) ?? 0.0;
                if (amountToPay > 0 && amountToPay <= studentFee.arrears + (studentFee.feeAmount - studentFee.paidAmount)) {
                  setState(() {
                    studentFee.paidAmount += amountToPay;
                    studentFee.arrears = studentFee.feeAmount - studentFee.paidAmount;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment of \$${amountToPay.toStringAsFixed(2)} successful!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid amount!')),
                  );
                }
              },
              child: const Text('Pay'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show more options dialog
  void _showMoreOptions(BuildContext context, StudentFee studentFee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More Options for ${studentFee.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('View Details'),
                onTap: () {
                  // Implement view details functionality
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Send Reminder'),
                onTap: () {
                  // Implement send reminder functionality
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Model class for student fee data
class StudentFee {
  final int id;
  final String name;
  final String className; // New attribute for class
  final String feeMonth;
  final double feeAmount;
  double paidAmount;
  double arrears;
  final String type; // New attribute for fee type

  StudentFee({
    required this.id,
    required this.name,
    required this.className, // Class name in constructor
    required this.feeMonth,
    required this.feeAmount,
    required this.paidAmount,
    required this.arrears,
    required this.type, // Fee type in constructor
  });
}
