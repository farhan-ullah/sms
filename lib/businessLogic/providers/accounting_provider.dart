import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class AccountingProvider extends ChangeNotifier {
  // List to keep track of all the transactions
  List<Transaction> _transactions = [];

  // Getter to retrieve all transactions
  List<Transaction> get transactions => _transactions;
  // Method to fetch all sales (can be filtered if needed)
  List<Transaction> getAllSales() {
    return _transactions.where((transaction) {
      return transaction.description.toLowerCase().contains('sale');
    }).toList(); // Filter only sales-related transactions
  }
  // Function to record stock transactions
  void recordStockTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }
  // Method to record a new transaction (this is where backend developers can integrate API calls)
  void recordTransaction(Transaction transaction) {
    // Add the transaction to the list
    _transactions.add(transaction);
    // For now, you can print the transaction to the console for demo purposes
    print('Transaction Recorded:');
    print('ID: ${transaction.id}');
    print('Description: ${transaction.description}');
    print('Debit Account: ${transaction.debitAccount}');
    print('Credit Account: ${transaction.creditAccount}');
    print('Debit Amount: ${transaction.debitAmount}');
    print('Credit Amount: ${transaction.creditAmount}');
    print('Date: ${transaction.date}');

    // Notify listeners in case any UI needs to react to changes (this can trigger UI updates)
    notifyListeners();
  }

  // You can also add methods for removing transactions, or viewing reports if necessary
  void removeTransaction(String transactionId) {
    _transactions.removeWhere((transaction) => transaction.id == transactionId);
    notifyListeners();
  }
}
