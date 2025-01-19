// import 'package:flutter/cupertino.dart';
// import 'package:school/data/boxes.dart';
// import 'package:school/data/models/transactionModel/transaction_model.dart';
//
// class TransactionProvider extends ChangeNotifier{
//   // final _transactionBox= Boxes.getTransactions();
//   // get transactionBox => _transactionBox;
//   //
//   // void createTransaction(String transactionId ,String transactionType, double amount,
//   //     DateTime transactionDate, String transactionDescription,String studentOrTeacherId, String status ){
//   //   final transactionData= TransactionModel(
//   //       transactionId: transactionId,
//   //       transactionType: transactionType,
//   //       amount: amount,
//   //       transactionDate: transactionDate,
//   //       transactionDescription: transactionDescription,
//   //       studentOrTeacherId: studentOrTeacherId,
//   //       status: status);
//   //   _transactionBox.add(transactionData);
//   //
//   //   notifyListeners();
//   // }
//
//   TransactionModel getTransactionById(String transactionId) {
//     // Use `firstWhere`, and if no match is found, throw an exception
//     final transaction = _transactionBox.values.firstWhere(
//           (txn) => txn.transactionId == transactionId,
//       orElse: () => throw Exception("Transaction not found with ID: $transactionId"), // Throw an exception
//     );
//     return transaction;
//
//   }
//
//   List<TransactionModel> getTransactionsByDateRange(DateTime startDate, DateTime endDate) {
//     final transactions = _transactionBox.values.where(
//           (txn) => txn.transactionDate.isAfter(startDate) && txn.transactionDate.isBefore(endDate),
//     ).toList();
//     return transactions;
//   }
//
//   List<TransactionModel> getTransactionsByStatus(String status) {
//     final transactions = _transactionBox.values.where(
//           (txn) => txn.status == status,
//     ).toList();
//     return transactions;
//   }
//   List<TransactionModel> getTransactionsByStudentOrTeacherId(String studentOrTeacherId) {
//     final transactions = _transactionBox.values.where(
//           (txn) => txn.studentOrTeacherId == studentOrTeacherId,
//     ).toList();
//     return transactions;
//   }
//
//   List<TransactionModel> getAllTransactions() {
//     final allTransactions = _transactionBox.values.toList();
//     return allTransactions;
//   }
//   List<TransactionModel> getTransactionsSortedByDate() {
//     final transactions = _transactionBox.values.toList()
//       ..sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
//     return transactions;
//   }
//   List<TransactionModel> getTransactionsByDescription(String description) {
//     final transactions = _transactionBox.values.where(
//           (txn) => txn.transactionDescription.contains(description),
//     ).toList();
//     return transactions;
//   }
//
//   void updateTransaction(String transactionId, {
//     String? transactionType,
//     double? amount,
//     DateTime? transactionDate,
//     String? transactionDescription,
//     String? studentOrTeacherId,
//     String? status,
//   }) {
//     final transaction = getTransactionById(transactionId);
//     if (transaction != null) {
//       transaction.transactionType = transactionType ?? transaction.transactionType;
//       transaction.amount = amount ?? transaction.amount;
//       transaction.transactionDate = transactionDate ?? transaction.transactionDate;
//       transaction.transactionDescription = transactionDescription ?? transaction.transactionDescription;
//       transaction.studentOrTeacherId = studentOrTeacherId ?? transaction.studentOrTeacherId;
//       transaction.status = status ?? transaction.status;
//     }
//   }
//   int getTransactionCount() {
//     return _transactionBox.length;
//   }
//   void clearAllTransactions() {
//     _transactionBox.clear();
//   }
//   List<TransactionModel> getTransactionsByType(String type) {
//     final transactions = _transactionBox.values.where(
//           (txn) => txn.transactionType == type,
//     ).toList();
//     return transactions;
//   }
//   // List<TransactionModel> creditTransactions = getTransactionsByType("Credit");
//   // List<TransactionModel> debitTransactions = getTransactionsByType("Debit");
//   int countTransactionsByTypeInDateRange(String type, DateTime startDate, DateTime endDate) {
//     final count = _transactionBox.values.where(
//           (txn) =>
//       txn.transactionType == type &&
//           txn.transactionDate.isAfter(startDate) &&
//           txn.transactionDate.isBefore(endDate),
//     ).length;
//     return count;
//   }
//   // DateTime startDate = DateTime(2024, 1, 1);
//   // DateTime endDate = DateTime(2024, 12, 31);
//   // int creditCount = countTransactionsByTypeInDateRange("Credit", startDate, endDate);
//   // print("Number of credit transactions in 2024: $creditCount");
//   double sumTransactionAmountsByTypeInDateRange(String type, DateTime startDate, DateTime endDate) {
//     double totalAmount = _transactionBox.values
//         .where(
//           (txn) =>
//       txn.transactionType == type &&
//           txn.transactionDate.isAfter(startDate) &&
//           txn.transactionDate.isBefore(endDate),
//     )
//         .fold(0.0, (sum, txn) => sum + txn.amount);
//     return totalAmount;
//   }
//   // double totalCreditAmount = sumTransactionAmountsByTypeInDateRange("Credit", startDate, endDate);
//   // print("Total credit amount in 2024: \$${totalCreditAmount}");
//   // double totalDebitAmount = sumTransactionAmountsByTypeInDateRange("Debit", startDate, endDate);
//   // print("Total debit amount in 2024: \$${totalDebitAmount}");
//
//   double calculateNetAmountInDateRange(DateTime startDate, DateTime endDate) {
//     // Get all credit transactions in the date range
//     double totalCreditAmount = _transactionBox.values
//         .where(
//           (txn) =>
//       txn.transactionType == "Credit" &&
//           txn.transactionDate.isAfter(startDate) &&
//           txn.transactionDate.isBefore(endDate),
//     )
//         .fold(0.0, (sum, txn) => sum + txn.amount);
//
//     // Get all debit transactions in the date range
//     double totalDebitAmount = _transactionBox.values
//         .where(
//           (txn) =>
//       txn.transactionType == "Debit" &&
//           txn.transactionDate.isAfter(startDate) &&
//           txn.transactionDate.isBefore(endDate),
//     )
//         .fold(0.0, (sum, txn) => sum + txn.amount);
//
//     // Calculate net difference (Credit - Debit)
//     double netAmount = totalCreditAmount - totalDebitAmount;
//     return netAmount;
//   }
//   // DateTime startDate = DateTime(2024, 12, 25, 0, 0, 0);  // Start of the day
//   // DateTime endDate = DateTime(2024, 12, 25, 23, 59, 59);  // End of the day
//   //
//   // double netAmountForDay = calculateNetAmountInDateRange(startDate, endDate);
//   // print("Net amount for 25th December 2024: \$${netAmountForDay}");
//
//
//
//
//
// }