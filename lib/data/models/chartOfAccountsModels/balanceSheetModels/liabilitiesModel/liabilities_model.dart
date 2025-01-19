import 'package:hive/hive.dart';

class LiabilityModel  {
  final String? liabilityMainCategory; // Enum for liability category

  final String? liabilitySubcategory; // Enum for subcategory (varies based on category)

  final double amount; // Amount for the liability

  final DateTime dateCreated; // Date when the liability was created

  final String transactionId;

  final String serialNumber;

  final String liabilityDescription;

  LiabilityModel({
    required this.serialNumber,required this.transactionId,required this.liabilityDescription,
    this.liabilityMainCategory,
    required this.liabilitySubcategory,
    required this.amount,
    required this.dateCreated,
  });
}
