import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../businessLogic/providers/salary_provider.dart';


class PayslipScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  PayslipScreen({required this.employeeId, required this.employeeName});

  @override
  _PayslipScreenState createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  String selectedMonth = "January";
  String selectedYear = "2025";
  Map<String, dynamic> payslipData = {};

  @override
  Widget build(BuildContext context) {
    var salaryProvider = Provider.of<SalaryProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Payslip for ${widget.employeeName}"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for selecting month
                DropdownButton<String>(
                  value: selectedMonth,
                  items: ["January", "February", "March", "April", "May"]
                      .map((month) => DropdownMenuItem(
                    value: month,
                    child: Text(month),
                  ))
                      .toList(),
                  onChanged: (newMonth) {
                    setState(() {
                      selectedMonth = newMonth!;
                    });
                  },
                ),

                // Dropdown for selecting year
                DropdownButton<String>(
                  value: selectedYear,
                  items: ["2025", "2026", "2027"]
                      .map((year) => DropdownMenuItem(
                    value: year,
                    child: Text(year),
                  ))
                      .toList(),
                  onChanged: (newYear) {
                    setState(() {
                      selectedYear = newYear!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Button to generate payslip
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      payslipData = salaryProvider.generatePayslip(
                        widget.employeeId,
                        selectedMonth,
                        selectedYear,
                      );
                    });
                  },
                  child: Text("Generate Payslip"),
                ),

                // Displaying the payslip details
                if (payslipData.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Employee Name: ${payslipData['Employee Name']}"),
                        Text("Month: ${payslipData['Month']}"),
                        Text("Year: ${payslipData['Year']}"),
                        Text("Basic Salary: \$${payslipData['Basic Salary']}"),
                        Text("Allowances: \$${payslipData['Allowances']}"),
                        Text("Deductions: \$${payslipData['Deductions']}"),
                        Text("Net Salary: \$${payslipData['Net Salary']}"),
                        Text("Generated At: ${payslipData['Generated At']}"),
                      ],
                    ),
                  ),
              ],
            ),
            ),
        );
    }
}
