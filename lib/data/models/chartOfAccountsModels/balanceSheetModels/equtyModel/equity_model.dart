import 'package:hive/hive.dart';

import '../../../../../constants/financialConstants/equity_constants.dart';
import '../../../../enums/equity_enum.dart';


class EquityModel {
  final String? equityMainCategory; // Enum for equity category

  final String? equitySubcategory; // Enum for subcategory (varies based on category)

  final double amount; // Amount for the equity

  final DateTime dateCreated; // Date when the equity was created

  final String transactionId;

  final String serialNumber;

  final String equityDescription;


  EquityModel({
    required this.equityDescription,
    this.equityMainCategory,
    required this.equitySubcategory,
    required this.amount,
    required this.dateCreated,
    required this.transactionId,required this.serialNumber
  });
}
