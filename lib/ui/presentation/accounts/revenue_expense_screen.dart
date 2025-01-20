import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../businessLogic/providers/transaction_provider.dart';
import '../../../data/models/transactionModel/transaction_model.dart';

class RevenueExpenseScreen extends StatefulWidget {
  @override
  _RevenueExpenseScreenState createState() => _RevenueExpenseScreenState();
}

class _RevenueExpenseScreenState extends State<RevenueExpenseScreen> {
  String? _categoryFilter;
  String? _subcategoryFilter;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    // Adding some dummy transactions on initialization
    Future.delayed(Duration.zero, () {
      final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
      transactionProvider.createTransaction(
        "1", "Tuition Fee for 1st Semester", "Accounts Receivable", "Revenue - Tuition Fees", 5000.00, 5000.00, DateTime(2025, 01, 10),
      );
      transactionProvider.createTransaction(
        "2", "Teacher Salaries for January", "Expense - Salaries", "Cash", 15000.00, 15000.00, DateTime(2025, 01, 15),
      );
      transactionProvider.createTransaction(
        "3", "Utility Bills for January", "Expense - Utilities", "Accounts Payable", 1200.00, 1200.00, DateTime(2025, 01, 20),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);

    // Filtered transactions based on the selected filters
    var filteredTransactions = transactionProvider.filterTransactions(
      category: _categoryFilter,
      startDate: _startDate,
      endDate: _endDate,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Revenue and Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Category Filter
            DropdownButton<String>(
              value: _categoryFilter,
              hint: Text("Select Category"),
              onChanged: (newValue) {
                setState(() {
                  _categoryFilter = newValue;
                  _subcategoryFilter = null; // Reset subcategory when category changes
                });
              },
              items: ["Revenue", "Expense"].map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
            ),
            SizedBox(height: 10),

            // Date Range Filter
            Row(
              children: [
                Text("From: "),
                TextButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _startDate = selectedDate;
                      });
                    }
                  },
                  child: Text(_startDate == null ? "Select Date" : _startDate!.toString().split(' ')[0]),
                ),
                Text("To: "),
                TextButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _endDate = selectedDate;
                      });
                    }
                  },
                  child: Text(_endDate == null ? "Select Date" : _endDate!.toString().split(' ')[0]),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Transactions List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return Card(
                    child: ListTile(
                      title: Text(transaction.description),
                      subtitle: Text("${transaction.debitAccount} - ${transaction.creditAccount}"),
                      trailing: Text("\$${transaction.debitAmount}"),
                      leading: Icon(transaction.debitAccount.contains("Revenue") ? Icons.arrow_upward : Icons.arrow_downward),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
