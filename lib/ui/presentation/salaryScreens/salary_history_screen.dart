import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/salary_model.dart';

class SalaryHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var salaryProvider = Provider.of<SalaryProvider>(context);
    String employeeId = "1"; // Example employee ID

    List<Salary> salaryHistory = salaryProvider.getSalaryHistory(employeeId);

    return Scaffold(
        appBar: AppBar(
          title: Text("Salary History"),
        ),
        body: ListView.builder(
            itemCount: salaryHistory.length,
            itemBuilder: (context, index) {
              Salary salary = salaryHistory[index];
              return ListTile(
                title: Text(salary.month + " " + salary.year),
                subtitle: Text("Net Salary: \$${salary.netSalary}"),
                onTap: () {
                  // Navigate to Salary Details screen (optional)
                },
              );
            },
            ),
        );
    }
}
