// import 'package:hive/hive.dart';
// import 'package:school/constants/common_keys.dart';
// import 'package:intl/intl.dart'; // For formatting dates
// import '../balanceSheetModels/assetModel/assets_model.dart';
// import '../balanceSheetModels/balanceSheetModel/balance_sheet_model.dart';
// import '../balanceSheetModels/equtyModel/equity_model.dart';
// import '../balanceSheetModels/liabilitiesModel/liabilities_model.dart';
//
// @HiveType(typeId: 13)
// class BalanceSheetData {
//   void updateBalanceSheetForTransaction({
//     required DateTime transactionDate,
//     required double amount,
//     required String category,
//     required String subcategory,
//   }) {
//     // Retrieve the latest balance sheet data
//     var balanceSheet = getLatestBalanceSheet();
//
//     // Calculate the current total assets, liabilities, and equity
//     double totalAssets = balanceSheet.totalAssets;
//     double totalLiabilities = balanceSheet.totalLiabilities;
//     double totalEquity = balanceSheet.totalEquity;
//
//     // Update assets
//     if (category == 'Receivables') {
//       totalAssets += amount; // Update receivables (assets) based on the transaction amount
//     } else if (category == 'Cash') {
//       totalAssets += amount; // Update cash (assets) based on the transaction amount
//     }
//
//     // Update liabilities
//     if (category == 'Liabilities') {
//       totalLiabilities += amount; // Update liabilities based on the transaction amount
//     } else if (category == 'Salaries Payable') {
//       totalLiabilities += amount; // Update salaries payable (liabilities)
//     }
//
//     // You may adjust equity in specific cases depending on your accounting rules
//     if (category == 'Equity') {
//       totalEquity += amount; // Update equity (owner's equity, reserves, etc.)
//     }
//
//     // Recalculate balance (Assets = Liabilities + Equity)
//     double balance = totalAssets - (totalLiabilities + totalEquity);
//
//     // Save the updated balance sheet to Hive
//     saveBalanceSheetToHive(totalAssets, totalLiabilities, totalEquity, balance);
//   }
//
//   // Helper method to filter data within a specific date range
//   bool isWithinDateRange(DateTime date, DateTime startDate, DateTime endDate) {
//     return date.isAfter(startDate) && date.isBefore(endDate);
//   }
//
//   // Get total assets (current + fixed + other) for a specific date range
//   double getTotalAssets(DateTime startDate, DateTime endDate) {
//     double totalAssets = 0;
//     var assetBox = Hive.box<AssetModel>(CommonKeys.ASSET_BOX_KEY);
//
//     for (var asset in assetBox.values) {
//       if (asset.amount > 0 && isWithinDateRange(asset.acquisitionDate, startDate, endDate)) {
//         totalAssets += asset.amount;
//       }
//     }
//     return totalAssets;
//   }
//
//   // Get total liabilities (current + long-term) for a specific date range
//   double getTotalLiabilities(DateTime startDate, DateTime endDate) {
//     double totalLiabilities = 0;
//     var liabilityBox = Hive.box<LiabilityModel>(CommonKeys.LIABILITY_BOX_KEY);
//
//     for (var liability in liabilityBox.values) {
//       if (liability.amount > 0 && isWithinDateRange(liability.dateCreated, startDate, endDate)) {
//         totalLiabilities += liability.amount;
//       }
//     }
//     return totalLiabilities;
//   }
//
//   // Get total equity (owner's equity + reserves) for a specific date range
//   double getTotalEquity(DateTime startDate, DateTime endDate) {
//     double totalEquity = 0;
//     var equityBox = Hive.box<EquityModel>(CommonKeys.EQUITY_BOX_KEY);
//
//     for (var equity in equityBox.values) {
//       if (equity.amount > 0 && isWithinDateRange(equity.dateCreated, startDate, endDate)) {
//         totalEquity += equity.amount;
//       }
//     }
//     return totalEquity;
//   }
//
//   // Method to generate the balance sheet for a specific date range
//   Map<String, double> generateBalanceSheet(DateTime startDate, DateTime endDate) {
//     double totalAssets = getTotalAssets(startDate, endDate);
//     double totalLiabilities = getTotalLiabilities(startDate, endDate);
//     double totalEquity = getTotalEquity(startDate, endDate);
//
//     double balance = totalAssets - (totalLiabilities + totalEquity); // Should ideally be 0 (Assets = Liabilities + Equity)
//
//     // Save balance sheet to Hive
//     saveBalanceSheetToHive(totalAssets, totalLiabilities, totalEquity, balance);
//
//     return {
//       "Total Assets": totalAssets,
//       "Total Liabilities": totalLiabilities,
//       "Total Equity": totalEquity,
//       "Balance (Assets = Liabilities + Equity)": balance,
//     };
//   }
//
//   // Save the generated balance sheet to Hive
//   void saveBalanceSheetToHive(double totalAssets, double totalLiabilities, double totalEquity, double balance) {
//     var balanceSheetBox = Hive.box<BalanceSheetModel>(CommonKeys.BALANCE_SHEET_BOX_KEY);
//
//     var balanceSheet = BalanceSheetModel(
//       totalAssets: totalAssets,
//       totalLiabilities: totalLiabilities,
//       totalEquity: totalEquity,
//       balance: balance,
//     );
//
//     balanceSheetBox.add(balanceSheet);// Store the balance sheet in Hive
//
//   }
//
//   // Retrieve the latest balance sheet from Hive
//   BalanceSheetModel getLatestBalanceSheet() {
//     var balanceSheetBox = Hive.box<BalanceSheetModel>(CommonKeys.BALANCE_SHEET_BOX_KEY);
//     var balanceSheetList = balanceSheetBox.values.toList();
//     if (balanceSheetList.isEmpty) {
//       return BalanceSheetModel(
//         totalAssets: 0,
//         totalLiabilities: 0,
//         totalEquity: 0,
//         balance: 0,
//       ); // Return empty sheet if no data is present
//     }
//     return balanceSheetList.last; // Return the most recent balance sheet
//   }
//
//   // Clear all saved balance sheets (if needed)
//   void clearBalanceSheets() {
//     var balanceSheetBox = Hive.box<BalanceSheetModel>(CommonKeys.BALANCE_SHEET_BOX_KEY);
//     balanceSheetBox.clear();
//   }
//
//   // Method to generate balance sheet for a specific custom time range (in days, months, weeks, years)
//   Map<String, double> generateCustomBalanceSheet(int amount, String unit) {
//     DateTime endDate = DateTime.now();
//     DateTime startDate;
//
//     switch (unit.toLowerCase()) {
//       case 'days':
//         startDate = endDate.subtract(Duration(days: amount));
//         break;
//       case 'months':
//         startDate = DateTime(endDate.year, endDate.month - amount, endDate.day);
//         break;
//       case 'weeks':
//         startDate = endDate.subtract(Duration(days: 7 * amount));
//         break;
//       case 'years':
//         startDate = DateTime(endDate.year - amount, endDate.month, endDate.day);
//         break;
//       default:
//         throw ArgumentError("Invalid unit. Please use 'days', 'months', 'weeks', or 'years'.");
//     }
//
//     return generateBalanceSheet(startDate, endDate);
//   }
// }

import 'package:hive/hive.dart';
import 'package:school/constants/common_keys.dart';
import 'package:school/data/models/chartOfAccountsModels/balanceSheetModels/assetModel/assets_model.dart';
import 'package:school/data/models/chartOfAccountsModels/balanceSheetModels/equtyModel/equity_model.dart';
import 'package:school/data/models/chartOfAccountsModels/balanceSheetModels/liabilitiesModel/liabilities_model.dart';



class BalanceSheetData {
  addTransactionsToBalanceSheet(
    String serialNumber,
    String transactionId,


    DateTime acquisitionDate,

      [
        String? assetCategory,
        double? assetAmount,

        String? assetDescription,

        String? assetSubcategory,

        String? liabilityCategory="",

        double? liabilityAmount,
        double? equityAmount,
        String? liabilitySubcategory,
      String? equitySubcategory,

    String? liabilityDescription,
    String? equityDescription,
        String? equityCategory,]
  ) {
    final assetBox = Hive.box<AssetModel>(CommonKeys.ASSET_BOX_KEY);
    final liabilityBox = Hive.box<LiabilityModel>(CommonKeys.LIABILITY_BOX_KEY);
    final equityBox = Hive.box<EquityModel>(CommonKeys.EQUITY_BOX_KEY);

    final assetData = AssetModel(
      assetMainCategory: assetCategory,
      serialNumber: serialNumber,
      transactionId: transactionId,
      assetDescription: assetDescription,
      assetSubcategory: assetSubcategory,
      amount: assetAmount,
      acquisitionDate: acquisitionDate,
    );
    final liabilityData = LiabilityModel(
      serialNumber: serialNumber,
      transactionId: transactionId,
      liabilityDescription: liabilityDescription??"",
      liabilityMainCategory: liabilityCategory,
      liabilitySubcategory: liabilitySubcategory,
      amount: liabilityAmount??0,
      dateCreated: acquisitionDate,
    );
    final equityData = EquityModel(
      equityDescription: equityDescription??"",
      equityMainCategory: equityCategory,
      equitySubcategory: equitySubcategory,
      amount: equityAmount??0,
      dateCreated: acquisitionDate,
      transactionId: transactionId,
      serialNumber: serialNumber,
    );
    if (assetAmount != (liabilityAmount! + equityAmount!)) {
      throw Exception('Transaction does not balance.');
    }

    try {
      if (assetData.amount! > 0) {
        assetBox.add(assetData);
      }
      if (liabilityData.amount > 0) {
        liabilityBox.add(liabilityData);
      }
      if (equityData.amount > 0) {
        equityBox.add(equityData);
      }
    } catch (e) {
      // handle rollback or logging here
    }

  }
}
