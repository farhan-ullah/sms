import 'package:flutter/cupertino.dart';
import 'package:school/data/models/transactionModel/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  // List to hold all transactions
  List<Transaction> _transactions = [];

  // Getter for transactions
  List<Transaction> get transactions => _transactions;

  // Method to create a new transaction and add it to the list
  void createTransaction(
      String id,
      String description,
      String debitAccount,
      String creditAccount,
      double debitAmount,
      double creditAmount,
      DateTime date,
      ) {
    final transactionData = Transaction(
      id: id,
      description: description,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      debitAmount: debitAmount,
      creditAmount: creditAmount,
      date: date,
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
