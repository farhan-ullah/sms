import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/salary_model.dart';


class SalaryReportScreen extends StatefulWidget {
  @override
  _SalaryReportScreenState createState() => _SalaryReportScreenState();
}

class _SalaryReportScreenState extends State<SalaryReportScreen> {
  String selectedMonth = "January";
  String selectedYear = "2025";

  @override
  Widget build(BuildContext context) {
    var salaryProvider = Provider.of<SalaryProvider>(context);
    List<Salary> salaryReport = salaryProvider.generateSalaryReport(selectedMonth, selectedYear);

    return Scaffold(
        appBar: AppBar(
          title: Text("Salary Report"),
        ),
        body: Column(
            children: [
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
              Expanded(
                child: ListView.builder(
                  itemCount: salaryReport.length,
                  itemBuilder: (context, index) {
                    Salary salary = salaryReport[index];
                    return ListTile(
                      title: Text("${salary.employeeName} - ${salary.month} ${salary.year}"),
                      subtitle: Text("Net Salary: \$${salary.netSalary}"),
                    );
                  },
                ),
              ),
            ],
            ),
        );
    }
}
