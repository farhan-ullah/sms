// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import '../../../data/models/transaction_model.dart';
// final List<Transaction> dummyTransactions = [
//   // Revenue Transactions
//   Transaction(
//     id: "1",
//     description: "Tuition Fee for 1st Semester",
//     amount: 5000.00,
//     category: "Revenue",
//     subcategory: "Tuition Fees",
//     date: DateTime(2025, 01, 10),
//   ),
//   Transaction(
//     id: "2",
//     description: "Admission Fees for New Students",
//     amount: 2000.00,
//     category: "Revenue",
//     subcategory: "Admission Fees",
//     date: DateTime(2025, 01, 15),
//   ),
//   Transaction(
//     id: "3",
//     description: "Donation from Parent-Teacher Association",
//     amount: 1500.00,
//     category: "Revenue",
//     subcategory: "Donations",
//     date: DateTime(2025, 01, 12),
//   ),
//
//   // Expense Transactions
//   Transaction(
//     id: "4",
//     description: "Teacher Salaries for January",
//     amount: 15000.00,
//     category: "Expense",
//     subcategory: "Salaries",
//     date: DateTime(2025, 01, 10),
//   ),
//   Transaction(
//     id: "5",
//     description: "Utility Bills for January",
//     amount: 1200.00,
//     category: "Expense",
//     subcategory: "Utilities",
//     date: DateTime(2025, 01, 11),
//   ),
//   Transaction(
//     id: "6",
//     description: "Office Supplies Purchase",
//     amount: 800.00,
//     category: "Expense",
//     subcategory: "Office Supplies",
//     date: DateTime(2025, 01, 14),
//   ),
//   Transaction(
//     id: "7",
//     description: "Canteen Supplies",
//     amount: 600.00,
//     category: "Expense",
//     subcategory: "Canteen Supplies",
//     date: DateTime(2025, 01, 13),
//   ),
// ];
//
// class ReportScreen extends StatelessWidget {
//   final List<Transaction> transactions;
//
//   ReportScreen({required this.transactions});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Generate Report')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _generatePDF(context);
//           },
//           child: Text('Generate PDF Report'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _generatePDF(BuildContext context) async {
//     final pdf = pw.Document();
//
//     // Adding a title to the report
//     pdf.addPage(pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("School Revenue and Expense Report", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 20),
//             pw.Text("Report generated on: ${DateTime.now().toLocal()}"),
//             pw.SizedBox(height: 10),
//             pw.Text("Transactions:"),
//             pw.SizedBox(height: 10),
//             pw.Table.fromTextArray(
//               context: context,
//               data: [
//                 ['Description', 'Category', 'Subcategory', 'Amount', 'Date'],
//                 ...dummyTransactions.map((txn) => [
//                   txn.description,
//                   txn.category,
//                   txn.subcategory,
//                   '\$${txn.amount}',
//                   txn.date.toString().split(' ')[0]
//                 ]),
//               ],
//             ),
//           ],
//         );
//       },
//     ));
//
//     // Save the PDF file and open it
//     await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
//     }
// }
