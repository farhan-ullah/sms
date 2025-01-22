import 'package:flutter/cupertino.dart';
import 'package:school/data/models/transactionModel/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  // List to hold all transactions
  List<Transaction> _transactions = [];

  // Getter for transactions
  List<Transaction> get transactions => _transactions;

  List<Transaction> mockTransactions = [
    // Revenue Transactions (Payments)
    Transaction(
      isExpense: false,
      isRevenue: true,
      id: 'TX1001',
      description: 'Payment for Tuition Fees for September 2025',
      debitAccount: 'Student Fees',
      creditAccount: 'Bank Account',
      debitAmount: 1500.0,
      creditAmount: 1500.0,
      date: DateTime(2025, 9, 1),
      category: 'Revenue',
      subCategory: 'Tuition',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1002',
      description: 'Payment for Library Fee for September 2025',
      debitAccount: 'Library Fees',
      creditAccount: 'Bank Account',
      debitAmount: 50.0,
      creditAmount: 50.0,
      date: DateTime(2025, 9, 2),
      category: 'Revenue',
      subCategory: 'Library Fee',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1003',
      description: 'Payment for Sports Fee for September 2025',
      debitAccount: 'Sports Fees',
      creditAccount: 'Bank Account',
      debitAmount: 100.0,
      creditAmount: 100.0,
      date: DateTime(2025, 9, 3),
      category: 'Revenue',
      subCategory: 'Sports Fee',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1006',
      description: 'Payment for Extra Course Materials Fee',
      debitAccount: 'Course Materials Fees',
      creditAccount: 'Bank Account',
      debitAmount: 120.0,
      creditAmount: 120.0,
      date: DateTime(2025, 9, 6),
      category: 'Revenue',
      subCategory: 'Other',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1007',
      description: 'Payment for Miscellaneous Charges',
      debitAccount: 'Miscellaneous Fees',
      creditAccount: 'Bank Account',
      debitAmount: 25.0,
      creditAmount: 25.0,
      date: DateTime(2025, 9, 7),
      category: 'Revenue',
      subCategory: 'Other',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1011',
      description: 'Payment for Annual School Event Participation',
      debitAccount: 'Event Fees',
      creditAccount: 'Bank Account',
      debitAmount: 150.0,
      creditAmount: 150.0,
      date: DateTime(2025, 9, 11),
      category: 'Revenue',
      subCategory: 'Event',
    ),
    Transaction(
      isExpense: false,
      isRevenue: true,
      id: 'TX1001',
      description: 'Payment for Tuition Fees for September 2025',
      debitAccount: 'Student Fees',
      creditAccount: 'Bank Account',
      debitAmount: 1500.0,
      creditAmount: 1500.0,
      date: DateTime(2025, 9, 1),
      category: 'Revenue',
      subCategory: 'Tuition',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1002',
      description: 'Payment for Library Fee for September 2025',
      debitAccount: 'Library Fees',
      creditAccount: 'Bank Account',
      debitAmount: 50.0,
      creditAmount: 50.0,
      date: DateTime(2025, 9, 2),
      category: 'Revenue',
      subCategory: 'Library Fee',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1003',
      description: 'Payment for Sports Fee for September 2025',
      debitAccount: 'Sports Fees',
      creditAccount: 'Bank Account',
      debitAmount: 100.0,
      creditAmount: 100.0,
      date: DateTime(2025, 9, 3),
      category: 'Revenue',
      subCategory: 'Sports Fee',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1006',
      description: 'Payment for Extra Course Materials Fee',
      debitAccount: 'Course Materials Fees',
      creditAccount: 'Bank Account',
      debitAmount: 120.0,
      creditAmount: 120.0,
      date: DateTime(2025, 9, 6),
      category: 'Revenue',
      subCategory: 'Other',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1007',
      description: 'Payment for Miscellaneous Charges',
      debitAccount: 'Miscellaneous Fees',
      creditAccount: 'Bank Account',
      debitAmount: 25.0,
      creditAmount: 25.0,
      date: DateTime(2025, 9, 7),
      category: 'Revenue',
      subCategory: 'Other',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1011',
      description: 'Payment for Annual School Event Participation',
      debitAccount: 'Event Fees',
      creditAccount: 'Bank Account',
      debitAmount: 150.0,
      creditAmount: 150.0,
      date: DateTime(2025, 9, 11),
      category: 'Revenue',
      subCategory: 'Event',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1014',
      description: 'Payment for Special Workshop Fees',
      debitAccount: 'Workshop Fees',
      creditAccount: 'Bank Account',
      debitAmount: 200.0,
      creditAmount: 200.0,
      date: DateTime(2025, 1, 14),
      category: 'Revenue',
      subCategory: 'Workshop',
    ),

    // Expense Transactions
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1017',
      description: 'Payment for Teacher Salary - September 2025',
      debitAccount: 'Salaries Expense',
      creditAccount: 'Bank Account',
      debitAmount: 5000.0,
      creditAmount: 5000.0,
      date: DateTime(2024, 12, 20),
      category: 'Expense',
      subCategory: 'Salary',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1018',
      description: 'Payment for School Utilities (Electricity)',
      debitAccount: 'Utilities Expense',
      creditAccount: 'Bank Account',
      debitAmount: 400.0,
      creditAmount: 400.0,
      date: DateTime(2025, 01, 22),
      category: 'Expense',
      subCategory: 'Utilities',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1019',
      description: 'Payment for School Supplies (Stationery)',
      debitAccount: 'Supplies Expense',
      creditAccount: 'Bank Account',
      debitAmount: 300.0,
      creditAmount: 300.0,
      date: DateTime(2025, 01, 20),
      category: 'Expense',
      subCategory: 'Stationery',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1020',
      description: 'Payment for School Transport (Fuel)',
      debitAccount: 'Transport Expense',
      creditAccount: 'Bank Account',
      debitAmount: 600.0,
      creditAmount: 600.0,
      date: DateTime(2025, 9, 10),
      category: 'Expense',
      subCategory: 'Transport',
    ),

    // Refund Transactions
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1004',
      description: 'Refund for overpayment in Tuition Fees',
      debitAccount: 'Bank Account',
      creditAccount: 'Student Fees',
      debitAmount: 200.0,
      creditAmount: 200.0,
      date: DateTime(2025, 9, 4),
      category: 'Refund',
      subCategory: 'Tuition',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1008',
      description: 'Refund for unused sports fee (Student withdrew from program)',
      debitAccount: 'Bank Account',
      creditAccount: 'Sports Fees',
      debitAmount: 50.0,
      creditAmount: 50.0,
      date: DateTime(2025, 01, 22),
      category: 'Refund',
      subCategory: 'Sports Fee',
    ),
    Transaction(

      isExpense: false,
      isRevenue: true,
      id: 'TX1012',
      description: 'Refund for Event Fee due to Cancellation',
      debitAccount: 'Bank Account',
      creditAccount: 'Event Fees',
      debitAmount: 1500.0,
      creditAmount: 1500.0,
      date: DateTime(2025, 01, 22),
      category: 'Refund',
      subCategory: 'Event',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1013',
      description: 'Refund for duplicate payment of Tuition Fees',
      debitAccount: 'Bank Account',
      creditAccount: 'Student Fees',
      debitAmount: 1500.0,
      creditAmount: 1500.0,
      date: DateTime(2025, 9, 13),
      category: 'Refund',
      subCategory: 'Tuition',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1016',
      description: 'Refund for course drop (tuition)',
      debitAccount: 'Bank Account',
      creditAccount: 'Student Fees',
      debitAmount: 500.0,
      creditAmount: 500.0,
      date: DateTime(2025, 9, 16),
      category: 'Refund',
      subCategory: 'Tuition',
    ),

    // Adjustment Transactions
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1005',
      description: 'Adjustment for incorrect Library Fee charge',
      debitAccount: 'Library Fees',
      creditAccount: 'Student Fees',
      debitAmount: 10.0,
      creditAmount: 10.0,
      date: DateTime(2025, 9, 5),
      category: 'Adjustment',
      subCategory: 'Library Fee',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1010',
      description: 'Adjustment for incorrect Tuition Fee amount charged',
      debitAccount: 'Student Fees',
      creditAccount: 'Bank Account',
      debitAmount: 300.0,
      creditAmount: 300.0,
      date: DateTime(2025, 9, 10),
      category: 'Adjustment',
      subCategory: 'Tuition',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1015',
      description: 'Adjustment for special fee correction (Overcharge)',
      debitAccount: 'Workshop Fees',
      creditAccount: 'Student Fees',
      debitAmount: 50.0,
      creditAmount: 50.0,
      date: DateTime(2025, 9, 15),
      category: 'Adjustment',
      subCategory: 'Workshop',
    ),

    // Internal Transfers
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1009',
      description: 'Internal transfer from Bank to Student Fees Account',
      debitAccount: 'Bank Account',
      creditAccount: 'Student Fees',
      debitAmount: 2000.0,
      creditAmount: 2000.0,
      date: DateTime(2025, 9, 9),
      category: 'Transfer',
      subCategory: 'Other',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1021',
      description: 'Internal transfer from Bank to Transport Fees Account',
      debitAccount: 'Bank Account',
      creditAccount: 'Transport Fees',
      debitAmount: 800.0,
      creditAmount: 800.0,
      date: DateTime(2025, 9, 20),
      category: 'Transfer',
      subCategory: 'Transport',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1022',
      description: 'Internal transfer from Bank to Event Fees Account',
      debitAccount: 'Bank Account',
      creditAccount: 'Event Fees',
      debitAmount: 500.0,
      creditAmount: 500.0,
      date: DateTime(2025, 9, 21),
      category: 'Transfer',
      subCategory: 'Event',
    ),
    Transaction(

      isExpense: true,
      isRevenue: false,
      id: 'TX1023',
      description: 'Internal transfer from Bank to Miscellaneous Fees Account',
      debitAccount: 'Bank Account',
      creditAccount: 'Miscellaneous Fees',
      debitAmount: 1000.0,
      creditAmount: 1000.0,
      date: DateTime(2025, 9, 22),
      category: 'Transfer',
      subCategory: 'Miscellaneous',
    ),
  ];

    // Print out all the transactions for review




  // Method to create a new transaction and add it to the list
  void createTransaction(
      String id,
      String description,
      String debitAccount,
      String creditAccount,
      double debitAmount,
      double creditAmount,
      DateTime date,
      String category,
      bool isRevenue,
      bool isExpense
      ) {
    final transactionData = Transaction(
      isExpense: isExpense,isRevenue: isRevenue,
      id: id,
      description: description,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      debitAmount: debitAmount,
      creditAmount: creditAmount,
      date: date,
      category: category
    );

    // Add the transaction to the list
    _transactions.add(transactionData);
    notifyListeners(); // Notify listeners after adding the transaction
  }

  // Method to filter transactions based on various filters
  List<Transaction> filterTransactions({
    String? category,
    String? subcategory,
    String? transactionType,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    List<Transaction> filteredTransactions = _transactions;

    // Filter by category (revenue or expense)
    if (category != null && category.isNotEmpty) {
      filteredTransactions = filteredTransactions.where((transaction) {
        return (category == "Revenue" && transaction.debitAccount.contains("Revenue")) ||
            (category == "Expense" && transaction.creditAccount.contains("Expense"));
      }).toList();
    }

    // Filter by date range
    if (startDate != null) {
      filteredTransactions = filteredTransactions.where((transaction) {
        return transaction.date.isAfter(startDate) ||
            transaction.date.isAtSameMomentAs(startDate);
      }).toList();
    }

    if (endDate != null) {
      filteredTransactions = filteredTransactions.where((transaction) {
        return transaction.date.isBefore(endDate) ||
            transaction.date.isAtSameMomentAs(endDate);
      }).toList();
    }

    return filteredTransactions;
  }
}
