import 'package:hive/hive.dart';

class BalanceSheetModel {

  final double totalAssets;


  final double totalLiabilities;


  final double totalEquity;


    final double balance; // This represents the check that Assets = Liabilities + Equity

  BalanceSheetModel({
    required this.totalAssets,
    required this.totalLiabilities,
    required this.totalEquity,
    required this.balance,
  });
}
