import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/data/models/feeModel/fee_model.dart';

import 'fee_structure_screen.dart';

class ViewFeeScreen extends StatefulWidget {
  const ViewFeeScreen({super.key});

  @override
  State<ViewFeeScreen> createState() => _ViewFeeScreenState();
}

class _ViewFeeScreenState extends State<ViewFeeScreen> {
  TextEditingController feeNameController = TextEditingController();
  TextEditingController feeAmountController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  DateTime? selectedDueDate;
  String selectedFeeType = 'Not Specified';

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    List<FeeModel> feeList = feeProvider.mockFeeList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("View Fee Structure"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: feeList.length,
        itemBuilder: (context, index) {
          FeeModel fee = feeList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: Icon(Icons.payment, color: Colors.blueAccent),
                title: Text(fee.feeName.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Fee Type: ${fee.feeType}"),
                    Text("Amount: ${fee.createdFeeAmount} PKR"),
                    Text("Class: ${fee.classID}"),
                    if (fee.dueDate != null)
                      Text("Due Date: ${fee.dueDate}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    _showEditFeeDialog(fee,feeProvider);
                  },
                ),
              ),
            ),
          );
        },
      ),

 floatingActionButton: FloatingActionButton(onPressed: (){
   _showFeeDialog(context);
 },child: Icon(Icons.add),),   );
  }

  // Function to show the Edit Fee Dialog
  void _showEditFeeDialog(FeeModel fee, FeeProvider feeProvider) {
    feeNameController.text = fee.feeName.toString();
    feeAmountController.text = fee.createdFeeAmount.toString();
    classNameController.text = fee.classID ?? '';
    selectedFeeType = fee.feeType.toString();
    // Parse dueDate string into DateTime (if not null)
    selectedDueDate = fee.dueDate != null && fee.dueDate!.isNotEmpty
        ? DateTime.tryParse(fee.dueDate!) // Use tryParse to avoid exceptions
        : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Fee"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Fee Name", feeNameController),
                _buildTextField("Fee Amount", feeAmountController, isNumeric: true),
                _buildFeeTypeDropdown(),
                _buildClassDropdown(),
                 _buildDueDatePicker(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _updateFee(fee,feeProvider);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // Function to build text fields for the form
  Padding _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // Function to build the dropdown for Fee Type
  Padding _buildFeeTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedFeeType,
        decoration: InputDecoration(
          labelText: "Fee Type",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: const [
          DropdownMenuItem(value: "Not Specified", child: Text("Not Specified")),
          DropdownMenuItem(value: "Admission Fee", child: Text("Admission Fee")),
          DropdownMenuItem(value: "Tuition Fee", child: Text("Tuition Fee")),
          DropdownMenuItem(value: "Lab Fee", child: Text("Lab Fee")),
          DropdownMenuItem(value: "Sports Fee", child: Text("Sports Fee")),
          DropdownMenuItem(value: "Transport Fee", child: Text("Transport Fee")),
          DropdownMenuItem(value: "Fine", child: Text("Fine")),
          DropdownMenuItem(value: "Other", child: Text("Other")),
        ],
        onChanged: (value) {
          setState(() {
            selectedFeeType = value ?? 'Not Specified';
          });
        },
      ),
    );
  }

  // Function to build the dropdown for Class Name
  Padding _buildClassDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: classNameController,
        decoration: InputDecoration(
          labelText: "Class Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  // Function to build the Due Date Picker
  Padding _buildDueDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDueDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (selectedDate != null) {
            setState(() {
              selectedDueDate = selectedDate;
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Due Date",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              // Handle null dueDate by showing placeholder text
              hintText: selectedDueDate != null ? "${selectedDueDate!.toLocal()}".split(' ')[0] : "Select Due Date",
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }

  // Function to update the fee data in the box
  void _updateFee(FeeModel fee, FeeProvider feeProvider) {
    final updatedFee = FeeModel(
      feeId: fee.feeId,
      feeName: feeNameController.text,
      feeType: selectedFeeType,
      createdFeeAmount: double.tryParse(feeAmountController.text) ?? fee.createdFeeAmount,
      classID: classNameController.text,
      // Store the Due Date as a string (yyyy-MM-dd)
      dueDate: selectedDueDate != null ? selectedDueDate!.toIso8601String() : fee.dueDate,
      feeMonth: fee.feeMonth,
      feeArrears: fee.feeArrears,
      feeConcessionInPKR: fee.feeConcessionInPKR,
      feeDescription: fee.feeDescription,
      dateOfTransaction: fee.dateOfTransaction,
      isPartiallyPaid: fee.isPartiallyPaid,
      isFullyPaid: fee.isFullyPaid,
    );

    final feeBox = feeProvider.mockFeeList;

  }
  void _showFeeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeeDialog();
      },
    );
  }
}
