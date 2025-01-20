import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/id_provider.dart';
import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/salary_model.dart';

class SalaryTierScreen extends StatelessWidget {
  const SalaryTierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salaryProvider = Provider.of<SalaryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Salary Tiers"),
      ),
      body: ListView.builder(
        itemCount: salaryProvider.dummySalaryTiers.length,
        itemBuilder: (context, index) {
          final salaryTier = salaryProvider.dummySalaryTiers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                salaryTier.role,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Salary: PKR ${salaryTier.salary.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(
                Icons.money,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => SalaryDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SalaryDialog extends StatefulWidget {
  const SalaryDialog({super.key});

  @override
  _SalaryDialogState createState() => _SalaryDialogState();
}

class _SalaryDialogState extends State<SalaryDialog> {
  TextEditingController salaryNameController = TextEditingController();
  TextEditingController salaryAmountController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController allowancesController = TextEditingController();
  TextEditingController deductionsController = TextEditingController();
  bool isBonusEnabled = false;
  DateTime? selectedBonusDate;
  int selectedBonusDay = 15; // Default bonus day
  String employeeId = "1"; // Example employee ID
  String employeeName = "John Doe"; // Example employee name
  String generatedSalaryId = ""; // Store the generated Salary ID

  @override
  void initState() {
    super.initState();
    generatedSalaryId = IdProvider().generateSalaryID().toString(); // Generate the ID when dialog opens
  }

  @override
  Widget build(BuildContext context) {
    final salaryProvider = Provider.of<SalaryProvider>(context);

    // List of roles from the staff data (manually extracted here from the provided data)
    final roles = [
      'Teacher',
      'Accountant',
      'Librarian',
      'Canteen Manager',
      'HR Manager',
      'Security Officer',
      'IT Specialist',
      'Cleaner',
      'Receptionist',
      'Maintenance Technician',
      'Marketing Manager',
      "Driver",
    ];

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Add Salary Tier"),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the generated Salary ID here
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Salary ID: $generatedSalaryId",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              _buildTextField("Salary Name", salaryNameController),
              _buildDropdownButton("Role", roles),
              _buildTextField("Basic Salary", salaryAmountController, isNumeric: true),
              _buildTextField("Allowances", allowancesController, isNumeric: true),
              _buildTextField("Deductions", deductionsController, isNumeric: true),
              const SizedBox(height: 16),
              _buildBonusToggle(),
              if (isBonusEnabled) _buildBonusDatePicker(),
              const SizedBox(height: 20),
              _buildAddButton(salaryProvider),
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
          suffixIcon: isNumeric ? Text("PKR") : null,
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Padding _buildDropdownButton(String label, List<String> items) {
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
            value: roleController.text.isEmpty ? null : roleController.text,
            items: items.map<DropdownMenuItem<String>>((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                roleController.text = value ?? '';
              });
            },
          ),
        ),
      ),
    );
  }

  Padding _buildBonusToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Enable Bonus", style: TextStyle(fontSize: 16)),
          Switch(
            value: isBonusEnabled,
            onChanged: (value) {
              setState(() {
                isBonusEnabled = value;
                selectedBonusDate = null; // Reset selected date when toggling
              });
            },
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Padding _buildBonusDatePicker() {
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
              selectedBonusDate = DateTime(
                selectedMonth.year,
                selectedMonth.month,
                selectedBonusDay, // Set day of the month
              );
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Bonus Date",
              labelStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: selectedBonusDate != null
                  ? "${selectedBonusDate!.toLocal()}".split(' ')[0]
                  : "Select Bonus Date",
              suffixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(SalaryProvider salaryProvider) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _handleAddSalary(salaryProvider);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("Add Salary", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _handleAddSalary(SalaryProvider salaryProvider) {
    if (salaryNameController.text.isEmpty ||
        salaryAmountController.text.isEmpty ||
        roleController.text.isEmpty ||
        allowancesController.text.isEmpty ||
        deductionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    double basicSalary = double.tryParse(salaryAmountController.text) ?? 0;
    double allowances = double.tryParse(allowancesController.text) ?? 0;
    double deductions = double.tryParse(deductionsController.text) ?? 0;
    double netSalary = basicSalary + allowances - deductions;

    final salaryModel = Salary(
      id: generatedSalaryId,  // Using the generated Salary ID
      employeeId: employeeId,
      employeeName: employeeName,
      basicSalary: basicSalary,
      allowances: allowances,
      deductions: deductions,
      netSalary: netSalary,
      month: DateTime.now().month.toString(),
      year: DateTime.now().year.toString(),
      generatedAt: DateTime.now(),
    );

    salaryProvider.createNewSalary(salaryModel); // Assuming a method to create salary in the provider
    Navigator.of(context).pop(); // Close the dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Salary added successfully")),
    );
  }
}
