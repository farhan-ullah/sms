import 'package:hive/hive.dart';

import '../../../../../constants/financialConstants/expense_constants.dart';
import '../../../../enums/expense_enum.dart';

part 'expense_model.g.dart'; // Generated file


@HiveType(typeId: 10)
class ExpenseModel {
  @HiveField(0)
  final String? expenseMainCategory; // Enum for category

  @HiveField(1)
  final String? expenseSubcategory; // Enum for subcategory (varies based on category)

  @HiveField(2)
  final double? expenseAmount; // Amount for the expense

  @HiveField(3)
  final DateTime date; // Date of the expense

  @HiveField(4)
  final String transactionId;

  @HiveField(5)
  final String serialNumber;

  @HiveField(6)
  final String expenseDescription;



  ExpenseModel({required this.transactionId,required this.serialNumber,required this.expenseDescription,
    required this.expenseMainCategory,
    required this.expenseSubcategory,
    required this.expenseAmount,
    required this.date,
  });
}
