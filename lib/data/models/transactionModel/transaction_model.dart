// transaction_model.dart

class Transaction {
  final String id;
  final String description;
  final String debitAccount;
  final String creditAccount;
  final double debitAmount;
  final double creditAmount;
  final DateTime date;
  final String category;
  final String? subCategory;
  final bool isRevenue;
  final bool isExpense;

  Transaction({
    required this.isExpense,
    required this.isRevenue,
    required this.id,
    required this.description,
    required this.debitAccount,
    required this.creditAccount,
    required this.debitAmount,
    required this.creditAmount,
    required this.date,
    required this.category,
    this.subCategory
  });
}

