// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../businessLogic/providers/accounting_provider.dart';
// import '../../../data/models/transaction_model.dart';
//
// class RevenueExpenseScreen extends StatefulWidget {
//   @override
//   _RevenueExpenseScreenState createState() => _RevenueExpenseScreenState();
// }
//
// class _RevenueExpenseScreenState extends State<RevenueExpenseScreen> {
//   String? _categoryFilter;
//   String? _subcategoryFilter;
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   // Initialize the dummy data once
//   final List<Transaction> dummyTransactions = [
//     // Revenue Transactions
//     Transaction(
//       id: "1",
//       description: "Tuition Fee for 1st Semester",
//       amount: 5000.00,
//       category: "Revenue",
//       subcategory: "Tuition Fees",
//       date: DateTime(2025, 01, 10),
//     ),
//     Transaction(
//       id: "2",
//       description: "Admission Fees for New Students",
//       amount: 2000.00,
//       category: "Revenue",
//       subcategory: "Admission Fees",
//       date: DateTime(2025, 01, 15),
//     ),
//     Transaction(
//       id: "3",
//       description: "Donation from Parent-Teacher Association",
//       amount: 1500.00,
//       category: "Revenue",
//       subcategory: "Donations",
//       date: DateTime(2025, 01, 12),
//     ),
//
//     // Expense Transactions
//     Transaction(
//       id: "4",
//       description: "Teacher Salaries for January",
//       amount: 15000.00,
//       category: "Expense",
//       subcategory: "Salaries",
//       date: DateTime(2025, 01, 10),
//     ),
//     Transaction(
//       id: "5",
//       description: "Utility Bills for January",
//       amount: 1200.00,
//       category: "Expense",
//       subcategory: "Utilities",
//       date: DateTime(2025, 01, 11),
//     ),
//     Transaction(
//       id: "6",
//       description: "Office Supplies Purchase",
//       amount: 800.00,
//       category: "Expense",
//       subcategory: "Office Supplies",
//       date: DateTime(2025, 01, 14),
//     ),
//     Transaction(
//       id: "7",
//       description: "Canteen Supplies",
//       amount: 600.00,
//       category: "Expense",
//       subcategory: "Canteen Supplies",
//       date: DateTime(2025, 01, 13),
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     // Add the list of dummy transactions to the provider
//     Provider.of<TransactionProvider>(context, listen: false).addTransaction(dummyTransactions[0]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var transactionProvider = Provider.of<TransactionProvider>(context);
//
//     var filteredTransactions = transactionProvider.filterTransactions(
//       category: _categoryFilter,
//       subcategory: _subcategoryFilter,
//       startDate: _startDate,
//       endDate: _endDate,
//     );
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Revenue and Expenses")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Filters Section
//             Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//
//             // Category Filter
//             DropdownButton<String>(
//               value: _categoryFilter,
//               hint: Text("Select Category"),
//               onChanged: (newValue) {
//                 setState(() {
//                   _categoryFilter = newValue;
//                   _subcategoryFilter = null; // Reset subcategory when category changes
//                 });
//               },
//               items: ["Revenue", "Expense"].map((category) {
//                 return DropdownMenuItem(value: category, child: Text(category));
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//
//             // Subcategory Filter
//             DropdownButton<String>(
//               value: _subcategoryFilter,
//               hint: Text("Select Subcategory"),
//               onChanged: (newValue) {
//                 setState(() {
//                   _subcategoryFilter = newValue;
//                 });
//               },
//               items: (_categoryFilter == "Revenue"
//                   ? ["Tuition Fees", "Admission Fees", "Donations"]
//                   : ["Salaries", "Utilities", "Office Supplies", "Canteen Supplies"]).
//               map((subcategory) {
//                 return DropdownMenuItem(value: subcategory, child: Text(subcategory));
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//
//             // Date Range Filter
//             Row(
//               children: [
//                 Text("From: "),
//                 TextButton(
//                   onPressed: () async {
//                     DateTime? selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: _startDate ?? DateTime.now(),
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime(2025),
//                     );
//                     if (selectedDate != null) {
//                       setState(() {
//                         _startDate = selectedDate;
//                       });
//                     }
//                   },
//                   child: Text(_startDate == null ? "Select Date" : _startDate!.toString().split(' ')[0]),
//                 ),
//                 Text("To: "),
//                 TextButton(
//                   onPressed: () async {
//                     DateTime? selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: _endDate ?? DateTime.now(),
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime(2025),
//                     );
//                     if (selectedDate != null) {
//                       setState(() {
//                         _endDate = selectedDate;
//                       });
//                     }
//                   },
//                   child: Text(_endDate == null ? "Select Date" : _endDate!.toString().split(' ')[0]),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             // Transactions List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredTransactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = filteredTransactions[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(transaction.description),
//                       subtitle: Text("${transaction.category} - ${transaction.subcategory}"),
//                       trailing: Text("\$${transaction.amount}"),
//                       leading: Icon(transaction.category == "Revenue" ? Icons.arrow_upward : Icons.arrow_downward),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
