import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/ui/presentation/salaryScreens/payslip_screeen.dart';

import '../../../businessLogic/providers/salary_provider.dart';
import '../../../data/models/salary_model.dart';

class SalaryDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adding dummy data
    var salaryProvider = Provider.of<SalaryProvider>(context, listen: false);

    salaryProvider.generateSalary(Salary(
      id: "1",
      employeeId: "1",
      employeeName: "John Doe",
      basicSalary: 3000,
      allowances: 500,
      deductions: 200,
      netSalary: 3300,
      month: "January",
      year: "2025",
      generatedAt: DateTime.now(),
    ));

    salaryProvider.generateSalary(Salary(
      id: "2",
      employeeId: "1",
      employeeName: "John Doe",
      basicSalary: 3000,
      allowances: 600,
      deductions: 150,
      netSalary: 3450,
      month: "February",
      year: "2025",
      generatedAt: DateTime.now(),
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Salary Dashboard"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayslipScreen(
                          employeeId: "1",
                          employeeName: "John Doe",
                        ),
                      ),
                    );
                  },
                  child: Text("View Payslips for John Doe"),
                ),
              ],
            ),
            ),
        );
   }
}
//import 'package:flutter/material.dart';
// import 'package:school/ui/presentation/salaryScreens/salary_history_screen.dart';
// import 'package:school/ui/presentation/salaryScreens/salary_report_screen.dart';
//
// import 'generate_salary-screen.dart';
// class SalaryDashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Salary Dashboard"),
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => GenerateSalaryScreen()),
//                     );
//                   },
//                   child: Text("Generate Salary"),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SalaryHistoryScreen()),
//                     );
//                   },
//                   child: Text("View Salary History"),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SalaryReportScreen()),
//                     );
//                   },
//                   child: Text("Generate Salary Report"),
//                 ),
//               ],
//             ),
//             ),
//         );
//
//   }
// }