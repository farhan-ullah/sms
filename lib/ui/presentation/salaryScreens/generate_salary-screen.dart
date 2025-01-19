import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/salary_model.dart';

class GenerateSalaryScreen extends StatefulWidget {
  @override
  _GenerateSalaryScreenState createState() => _GenerateSalaryScreenState();
}

class _GenerateSalaryScreenState extends State<GenerateSalaryScreen> {
  final TextEditingController basicSalaryController = TextEditingController();
  final TextEditingController allowancesController = TextEditingController();
  final TextEditingController deductionsController = TextEditingController();
  String employeeId = "1"; // Example employee ID
  String employeeName = "John Doe"; // Example employee name
  String month = "January"; // Default month
  String year = "2025"; // Default year

  @override
  Widget build(BuildContext context) {
    var salaryProvider = Provider.of<SalaryProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Generate Salary"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: basicSalaryController,
                  decoration: InputDecoration(labelText: "Basic Salary"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: allowancesController,
                  decoration: InputDecoration(labelText: "Allowances"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: deductionsController,
                  decoration: InputDecoration(labelText: "Deductions"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    double basicSalary = double.parse(basicSalaryController.text);
                    double allowances = double.parse(allowancesController.text);
                    double deductions = double.parse(deductionsController.text);
                    double netSalary = basicSalary + allowances - deductions;

                    Salary newSalary = Salary(
                      id: DateTime.now().toString(),
                      employeeId: employeeId,
                      employeeName: employeeName,
                      basicSalary: basicSalary,
                      allowances: allowances,
                      deductions: deductions,
                      netSalary: netSalary,
                      month: month,
                      year: year,
                      generatedAt: DateTime.now(),
                    );

                    salaryProvider.generateSalary(newSalary);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Salary generated successfully')));
                  },
                  child: Text("Generate Salary"),
                ),
              ],
            ),
            ),
        );
    }
}
