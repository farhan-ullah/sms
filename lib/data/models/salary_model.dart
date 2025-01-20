class Salary {
  String id;
  String employeeId;
  String employeeName;
  double basicSalary;
  double allowances;
  double deductions;
  double netSalary;
  String month;
  String year;
  DateTime generatedAt;
  bool isPaid;



  Salary({this.isPaid=false,
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.basicSalary,
    required this.allowances,
    required this.deductions,
    required this.netSalary,
    required this.month,
    required this.year,
    required this.generatedAt,
  });

  // Generate a payslip
  Map<String, dynamic> generatePayslip() {
    return {
    "Employee Name": employeeName,
    "Month": month,
    "Year": year,
    "Basic Salary": basicSalary,
    "Allowances": allowances,
    "Deductions": deductions,
    "Net Salary": netSalary,
    "Generated At": generatedAt.toString(),
    };
    }
}
