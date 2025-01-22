import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/transaction_provider.dart';
import 'package:school/data/models/transactionModel/transaction_model.dart';

class RevenueExpenseScreen extends StatefulWidget {
  const RevenueExpenseScreen({super.key});

  @override
  State<RevenueExpenseScreen> createState() => _RevenueExpenseScreenState();
}

class _RevenueExpenseScreenState extends State<RevenueExpenseScreen> {
  // Variables for filtering and searching
  String searchQuery = '';
  String selectedFilter = 'All';
  DateTime? startDate;
  DateTime? endDate;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterByDateRange('Today');
  }
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.mockTransactions;

    // Filter the transactions based on search query and filters
    List<Transaction> filteredTransactions = transactions.where((transaction) {
      // Filter by search query
      bool matchesSearch = transaction.description.toLowerCase().contains(searchQuery.toLowerCase());

      // Filter by selected transaction type (Revenue/Expense)
      bool matchesType = (selectedFilter == 'All' ||
          (selectedFilter == 'Revenue' && transaction.isRevenue) ||
          (selectedFilter == 'Expense' && transaction.isExpense));

      // Filter by date range
      bool matchesDateRange = true;
      if (startDate != null && endDate != null) {
        DateTime transactionDate = transaction.date;
        matchesDateRange = transactionDate.isAfter(startDate!) && transactionDate.isBefore(endDate!);
      }

      return matchesSearch && matchesType && matchesDateRange;
    }).toList();

    double totalCredits = 0;
    double totalDebits = 0;

    // Calculate total credits (revenues) and total debits (expenses)
    for (var transaction in filteredTransactions) {
      if (transaction.isRevenue) {
        totalCredits += transaction.creditAmount; // Add credits (revenue)
      } else if (transaction.isExpense) {
        totalDebits += transaction.debitAmount; // Add debits (expense)
      }
    }

    // The net amount is the difference between total credits and total debits
    double netAmount = totalCredits - totalDebits;

    // Format the net amount for display (with 2 decimal places)
    String formattedNetAmount = "₨${netAmount.toStringAsFixed(2)}"; // Showing PKR currency

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue & Expenses', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Bar Section (Search, Filter, Date)
            _buildFilterBar(),
            const SizedBox(height: 16),

            // Reset Button
            ElevatedButton.icon(
              onPressed: _resetFilters,
              icon: Icon(Icons.refresh),
              label: Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Red color to indicate reset action
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 6,
              ),
            ),
            const SizedBox(height: 16),

            // List of all filtered transactions
            Expanded(
              child: filteredTransactions.isEmpty
                  ? const Center(child: Text('No transactions found.'))
                  : ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  bool isRevenue = transaction.isRevenue; // Check if it's a revenue (credit)
                  bool isExpense = transaction.isExpense; // Check if it's an expense (debit)

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: isRevenue
                        ? Colors.green[50]
                        : (isExpense ? Colors.red[50] : Colors.grey[200]),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      title: Text(
                        transaction.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isRevenue
                              ? Colors.green[800]
                              : (isExpense ? Colors.red[800] : Colors.grey[700]),
                        ),
                      ),
                      subtitle: Text(
                        'Amount: ₨${isRevenue ? transaction.creditAmount : (isExpense ? transaction.debitAmount : 0)}  •  ${transaction.date.toString().substring(0, 10)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      leading: Icon(
                        isRevenue
                            ? Icons.arrow_upward
                            : (isExpense ? Icons.arrow_downward : Icons.swap_horiz),
                        color: isRevenue
                            ? Colors.green
                            : (isExpense ? Colors.red : Colors.grey),
                        size: 28,
                      ),
                      onTap: () {
                        // Show dialog with transaction details
                        _showTransactionDetails(context, transaction);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Net total of all filtered transactions
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    netAmount >= 0 ? Colors.greenAccent : Colors.redAccent,
                    netAmount >= 0 ? Colors.green[200]! : Colors.red[200]!
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Total',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Text(
                    formattedNetAmount, // Display formatted amount with PKR
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: netAmount >= 0 ? Colors.green[800] : Colors.red[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Build the filter bar UI
  Widget _buildFilterBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
            decoration: InputDecoration(
              labelText: 'Search transactions',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Filter dropdown for Revenue/Expense
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: selectedFilter,
            items: ['All', 'Revenue', 'Expense']
                .map((filter) => DropdownMenuItem<String>(
              value: filter,
              child: Text(
                filter,
                style: TextStyle(color: Colors.white),
              ),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedFilter = value!;
              });
            },
            underline: SizedBox(),
          ),
        ),
        SizedBox(width: 16),
        // Date range filter button with new options
        PopupMenuButton<String>(
          icon: Icon(Icons.calendar_today, color: Colors.blueAccent),
          onSelected: (selectedDateRange) {
            _filterByDateRange(selectedDateRange);
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'Today', child: Text('Today')),
            PopupMenuItem(value: 'Last 7 Days', child: Text('Last 7 Days')),
            PopupMenuItem(value: 'Last 30 Days', child: Text('Last 30 Days')),
            PopupMenuItem(value: 'Last 365 Days', child: Text('Last 365 Days')),
            PopupMenuItem(value: 'Last Year', child: Text('Last Year')),
            PopupMenuItem(value: 'Custom Range', child: Text('Custom Range')),
          ],
        ),
      ],
    );
  }

  // Handle the date range filtering
  void _filterByDateRange(String selectedDateRange) {
    setState(() {
      switch (selectedDateRange) {
        case 'Today':
        // Set the start of the day (midnight) and the end of the day (just before midnight of the next day)
          startDate = DateTime.now().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second, milliseconds: DateTime.now().millisecond));
          endDate = startDate!.add(Duration(days: 1)).subtract(Duration(milliseconds: 1)); // Just before midnight of the next day
          break;
          case 'Last 7 Days':
          startDate = DateTime.now().subtract(Duration(days: 7));
          endDate = DateTime.now();
          break;
        case 'Last 30 Days':
          startDate = DateTime.now().subtract(Duration(days: 30));
          endDate = DateTime.now();
          break;
        case 'Last 365 Days':
          startDate = DateTime.now().subtract(Duration(days: 365));
          endDate = DateTime.now();
          break;
        case 'Last Year':
          startDate = DateTime(DateTime.now().year - 1, 1, 1);
          endDate = DateTime(DateTime.now().year - 1, 12, 31);
          break;
        case 'Custom Range':
          _selectDateRange(context);
          break;
      }
    });
  }

  // Show dialog for transaction details
  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Transaction Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Description: ${transaction.description}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Amount: ₨${transaction.isRevenue ? transaction.creditAmount : transaction.debitAmount}',
                  style: TextStyle(
                    fontSize: 16,
                    color: transaction.isRevenue ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${transaction.date.toString().substring(0, 10)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Category: ${transaction.isRevenue ? 'Revenue' : 'Expense'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: transaction.isRevenue ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Date range picker to select start and end date for filtering
  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: DateTimeRange(
        start: startDate ?? DateTime.now(),
        end: endDate ?? DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(primaryColor: Colors.blueAccent),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      setState(() {
        startDate = pickedDateRange.start;
        endDate = pickedDateRange.end;
      });
    }
  }

  // Reset filters
  void _resetFilters() {
    setState(() {
      searchQuery = '';
      selectedFilter = 'All';
      startDate = null;
      endDate = null;
    });
  }
}
