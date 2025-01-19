import 'dart:math';

import 'package:hive/hive.dart';
import 'package:school/constants/common_keys.dart';
import 'package:school/constants/string_resources.dart';
import '../ledgerModels/ledgerModel/ledger_model.dart';

class LedgerData {

  // Helper method to filter data within a specific date range
  bool isWithinDateRange(DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  // Add a new transaction to the ledger (for any category: Asset, Liability, Equity)
  void addTransactionToLedger({
    required String transactionId,
    required DateTime transactionDate,
    required double amount,
    required String description,
    required String category,
    required String subcategory,
    required String entryType,
  }) {
    var expenseBox = Hive.box<LedgerModel>(CommonKeys.EXPENSE_BOX_KEY);
    var revenueBox = Hive.box<LedgerModel>(CommonKeys.REVENUE_BOX_KEY);

    // Validate entry type
    if (entryType != StringResources.CREDIT_LABEL && entryType != StringResources.DEBIT_LABEL) {
      throw Exception('Invalid entry type: $entryType. Must be either CREDIT or DEBIT.');
    }

    // Ensure amount is non-negative if necessary
    if (amount <= 0) {
      throw Exception('Amount must be greater than zero.');
    }

    var transaction = LedgerModel(
      entryType: entryType,
      transactionId: transactionId,
      transactionDate: transactionDate,
      amount: amount,
      description: description,
      category: category,
      subcategory: subcategory,
    );

    // Add transaction to the correct box based on entry type
    if (entryType == StringResources.CREDIT_LABEL) {
      expenseBox.add(transaction);  // Assuming this is adding expense transactions
    } else if (entryType == StringResources.DEBIT_LABEL) {
      revenueBox.add(transaction);  // Assuming this is adding revenue transactions
    }

    // Optional: Call save() instead of add() if you want to ensure persistence
    // transaction.save();
  }


  // Retrieve and print the ledger (optional sorting by date)
  List<LedgerModel> generateLedger() {
    var ledgerBox = Hive.box<LedgerModel>(CommonKeys.LEDGER_BOX_KEY);
    List<LedgerModel> transactions = ledgerBox.values.toList();

    // Optionally, you can sort the transactions by transaction date or other criteria
    transactions.sort((a, b) => b.transactionDate.compareTo(a.transactionDate)); // Sort by date descending

    return transactions;
  }

  // Filter transactions by a specific category (e.g., Assets, Liabilities, Equity)
  List<LedgerModel> filterTransactionsByCategory(String category) {
    var ledgerBox = Hive.box<LedgerModel>(CommonKeys.LEDGER_BOX_KEY);
    return ledgerBox.values
        .where((transaction) => transaction.category == category)
        .toList();
  }

  // Generate a report for all transactions under a specific category
  void printLedgerReport(String category) {
    List<LedgerModel> transactions = filterTransactionsByCategory(category);

    for (var transaction in transactions) {
      print('Transaction ID: ${transaction.transactionId}');
      print('Date: ${transaction.transactionDate}');
      print('Amount: ${transaction.amount}');
      print('Description: ${transaction.description}');
      print('Category: ${transaction.category}');
      print('Subcategory: ${transaction.subcategory}');
      print('----------------------------');
    }
  }

  // Calculate total transactions in the ledger for a given category
  double calculateTotalTransactionsForCategory(String category) {
    double total = 0;
    List<LedgerModel> transactions = filterTransactionsByCategory(category);

    for (var transaction in transactions) {
      total += transaction.amount;
    }

    return total;
  }

  // Retrieve the latest transaction from the ledger
  LedgerModel? getLatestTransaction() {
    var ledgerBox = Hive.box<LedgerModel>(CommonKeys.LEDGER_BOX_KEY);
    var ledgerList = ledgerBox.values.toList();
    if (ledgerList.isEmpty) {
      return null; // No transactions available
    }
    return ledgerList.last; // Return the most recent transaction
  }

  // Clear all ledger entries (if necessary)
  void clearLedger() {
    var ledgerBox = Hive.box<LedgerModel>(CommonKeys.LEDGER_BOX_KEY);
    ledgerBox.clear();
  }

  // Filter transactions by a specific date range (startDate and endDate)
  List<LedgerModel> filterTransactionsByDateRange(DateTime startDate, DateTime endDate) {
    var ledgerBox = Hive.box<LedgerModel>(CommonKeys.LEDGER_BOX_KEY);
    List<LedgerModel> transactions = ledgerBox.values.toList();

    // Filter transactions that are within the date range
    return transactions.where((transaction) => isWithinDateRange(transaction.transactionDate, startDate, endDate)).toList();
  }

  // Generate a ledger report for a specific date range
  void printLedgerReportByDateRange(DateTime startDate, DateTime endDate) {
    List<LedgerModel> transactions = filterTransactionsByDateRange(startDate, endDate);

    for (var transaction in transactions) {
      print('Transaction ID: ${transaction.transactionId}');
      print('Date: ${transaction.transactionDate}');
      print('Amount: ${transaction.amount}');
      print('Description: ${transaction.description}');
      print('Category: ${transaction.category}');
      print('Subcategory: ${transaction.subcategory}');
      print('----------------------------');
    }
  }

  // Calculate total transactions for a specific date range
  double calculateTotalTransactionsForDateRange(DateTime startDate, DateTime endDate) {
    double total = 0;
    List<LedgerModel> transactions = filterTransactionsByDateRange(startDate, endDate);

    for (var transaction in transactions) {
      total += transaction.amount;
    }

    return total;
  }

  // Generate a ledger for a custom time period (e.g., last X days, weeks, months, years)
  List<LedgerModel> generateLedgerForCustomPeriod(int amount, String unit) {
    DateTime endDate = DateTime.now();
    DateTime startDate;

    switch (unit.toLowerCase()) {
      case 'days':
        startDate = endDate.subtract(Duration(days: amount));
        break;
      case 'months':
        startDate = DateTime(endDate.year, endDate.month - amount, endDate.day);
        break;
      case 'weeks':
        startDate = endDate.subtract(Duration(days: 7 * amount));
        break;
      case 'years':
        startDate = DateTime(endDate.year - amount, endDate.month, endDate.day);
        break;
      default:
        throw ArgumentError("Invalid unit. Please use 'days', 'months', 'weeks', or 'years'.");
    }

    return filterTransactionsByDateRange(startDate, endDate);
  }
}
