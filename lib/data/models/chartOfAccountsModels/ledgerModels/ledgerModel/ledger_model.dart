import 'package:hive/hive.dart';

part 'ledger_model.g.dart'; // Generated file

@HiveType(typeId: 17)
class LedgerModel {
  @HiveField(0)
  final String transactionId; // Unique transaction identifier

  @HiveField(1)
  final DateTime transactionDate; // Date when the transaction occurred

  @HiveField(2)
  final double amount; // Amount involved in the transaction

  @HiveField(3)
  final String description; // Description of the transaction

  @HiveField(4)
  final String category; // Asset, Liability, or Equity category

  @HiveField(5)
  final String subcategory; // Subcategory within the main category (e.g., Cash, Accounts Payable, etc.)

  @HiveField(6)
  final String entryType;



  LedgerModel({
    required this.transactionId,
    required this.transactionDate,
    required this.amount,
    required this.entryType,
    required this.description,
    required this.category,
    required this.subcategory,
  });
}
