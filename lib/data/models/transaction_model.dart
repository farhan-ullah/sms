// transaction_model.dart

class Transaction {
  final String id;
  final String description;
  final String debitAccount;
  final String creditAccount;
  final double debitAmount;
  final double creditAmount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.debitAccount,
    required this.creditAccount,
    required this.debitAmount,
    required this.creditAmount,
    required this.date,
  });
}
