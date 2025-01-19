import 'package:hive/hive.dart';

import '../../../../../constants/financialConstants/revenue_constants.dart';
import '../../../../enums/revenue_enum.dart';

part 'revenue_model.g.dart'; // Generated file

@HiveType(typeId: 11)
class RevenueModel {
  @HiveField(0)
  final String? revenueCategory; // Enum for revenue category

  @HiveField(1)
  final String? revenueSubcategory; // Enum for subcategory (varies based on category)

  @HiveField(2)
  final double amount; // Amount for the revenue

  @HiveField(3)
  final DateTime date; // Date of the revenue

  @HiveField(4)
  final String transactionId;

  @HiveField(5)
  final String serialNumber;

  @HiveField(6)
  final String revenueDescription;


  RevenueModel({required this.serialNumber,required this.transactionId,required this.revenueDescription,
    required this.revenueCategory,
    required this.revenueSubcategory,
    required this.amount,
    required this.date,
  });
}
