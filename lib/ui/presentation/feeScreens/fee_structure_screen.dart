import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../businessLogic/providers/class_name_provider.dart';
import '../../../businessLogic/providers/fee_provider.dart';
import '../../../businessLogic/providers/id_provider.dart';
import '../../../data/models/feeModel/fee_model.dart';

class FeeDialog extends StatefulWidget {
  @override
  _FeeDialogState createState() => _FeeDialogState();
}

class _FeeDialogState extends State<FeeDialog> {
  TextEditingController feeNameController = TextEditingController();
  TextEditingController feeAmountController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  bool isDueDateEnabled = false;
  DateTime? selectedDueDate;
  int selectedDueDay = 15; // Default due day

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final classProvider = Provider.of<ClassNameProvider>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Add Fee Structure"),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Fee Name", feeNameController),
              _buildDropdownButton("Fee Type", feeProvider),
              _buildTextField("Fee Amount", feeAmountController, isNumeric: true),
              _buildClassDropdownButton(classProvider),
              const SizedBox(height: 16),
              _buildDueDateToggle(),
              if (isDueDateEnabled) _buildDueDatePicker(),
              const SizedBox(height: 20),
              _buildAddButton(feeProvider),
            ],
          ),
        ),
      ),
    );
  }

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
          suffixIcon: isNumeric
              ? Text("PKR")
              : null,
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Padding _buildDropdownButton(String label, FeeProvider feeProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            value: feeProvider.selectedFeeType,
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
              feeProvider.changeSelectedFeeType(value!);
            },
          ),
        ),
      ),
    );
  }

  Padding _buildClassDropdownButton(ClassNameProvider classProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Class Name",
              border: OutlineInputBorder(),
            ),
            value: classNameController.text.isEmpty ? null : classNameController.text,
            items: classProvider.mockClassList
                .map<DropdownMenuItem<String>>((classItem) {
              return DropdownMenuItem<String>(
                value: classItem.classID,
                child: Text(classItem.classID ?? "Unknown Class"),
              );
            }).toList(),
            onChanged: (value) {
              classNameController.text = value ?? '';
            },
          ),
        ),
      ),
    );
  }

  Padding _buildDueDateToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Enable Due Date", style: TextStyle(fontSize: 16)),
          Switch(
            value: isDueDateEnabled,
            onChanged: (value) {
              setState(() {
                isDueDateEnabled = value;
                selectedDueDate = null; // Reset selected date when toggling
              });
            },
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Padding _buildDueDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () async {
          DateTime? selectedMonth = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (selectedMonth != null) {
            setState(() {
              selectedDueDate = DateTime(
                selectedMonth.year,
                selectedMonth.month,
                selectedDueDay, // Set day of the month
              );
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Due Date",
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: selectedDueDate != null
                  ? "${selectedDueDate!.toLocal()}".split(' ')[0]
                  : "Select Due Date",
              suffixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(FeeProvider feeProvider) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _handleAddFee(feeProvider);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("Add Fee", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _handleAddFee(FeeProvider feeProvider) {
    if (feeNameController.text.isEmpty ||
        feeAmountController.text.isEmpty ||
        classNameController.text.isEmpty ||
        feeProvider.selectedFeeType == 'Not Specified') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final feeModel = FeeModel(
      classID: classNameController.text,
      dueDate: isDueDateEnabled ? selectedDueDate?.toString() : null,
      feeMonth: "",
      // Add logic to set the month if needed
      feeArrears: 0,
      feeConcessionInPKR: 0,
      feeConcessionInPercent: 0,
      feeDescription: "",
      dateOfTransaction: "",
      createdFeeAmount: double.tryParse(feeAmountController.text),
      feeId: IdProvider().generateFeeID().toString(),
      feeName: feeNameController.text,
      feeType: feeProvider.selectedFeeType,
      isPartiallyPaid: false,
      isFullyPaid: false,
    );

    feeProvider.createNewFee(feeModel);
    Navigator.of(context).pop(); // Close the dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fee added successfully")),
    );
  }}