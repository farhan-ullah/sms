// // // Enum for Asset Category
// // enum AssetCategory {
// //   currentAssets,
// //   fixedAssets,
// //   otherAssets
// // }
// //
// // // Enum for subcategories under Current Assets
// // enum CurrentAssetSubcategory {
// //   cash,
// //   accountsReceivable,
// //   prepaidExpenses,
// //   inventory,
// //   shortTermInvestments
// // }
// //
// // // Enum for subcategories under Fixed Assets
// // enum FixedAssetSubcategory {
// //   land,
// //   buildings,
// //   furnitureAndEquipment,
// //   vehicles,
// //   intangibleAssets
// // }
// //
// // // Enum for subcategories under Other Assets
// // enum OtherAssetSubcategory {
// //   longTermInvestments,
// //   deposits,
// //   endowments
// // }
// //
// // // String constants for Asset Categories
// // class AssetCategories {
// //   static const String currentAssets = "Current Assets";
// //   static const String fixedAssets = "Fixed Assets";
// //   static const String otherAssets = "Other Assets";
// // }
// //
// // // String constants for Current Asset Subcategories
// // class CurrentAssetSubcategories {
// //   static const String cash = "Cash";
// //   static const String accountsReceivable = "Accounts Receivable";
// //   static const String prepaidExpenses = "Prepaid Expenses";
// //   static const String inventory = "Inventory";
// //   static const String shortTermInvestments = "Short-term Investments";
// // }
// //
// // // String constants for Fixed Asset Subcategories
// // class FixedAssetSubcategories {
// //   static const String land = "Land";
// //   static const String buildings = "Buildings";
// //   static const String furnitureAndEquipment = "Furniture & Equipment";
// //   static const String vehicles = "Vehicles";
// //   static const String intangibleAssets = "Intangible Assets";
// // }
// //
// // // String constants for Other Asset Subcategories
// // class OtherAssetSubcategories {
// //   static const String longTermInvestments = "Long-term Investments";
// //   static const String deposits = "Deposits";
// //   static const String endowments = "Endowments";
// // }
// // String constants for Asset Categories
// class AssetCategories {
//   static const String currentAssets = "Current Assets";
//   static const String fixedAssets = "Fixed Assets";
//   static const String otherAssets = "Other Assets";
// }
//
// // String constants for Current Asset Subcategories
// class CurrentAssetSubcategories {
//   static const String cash = "Cash";
//   static const String accountsReceivable = "Accounts Receivable";
//   static const String prepaidExpenses = "Prepaid Expenses";
//   static const String inventory = "Inventory";
//   static const String shortTermInvestments = "Short-term Investments";
// }
//
// // String constants for Fixed Asset Subcategories
// class FixedAssetSubcategories {
//   static const String land = "Land";
//   static const String buildings = "Buildings";
//   static const String furnitureAndEquipment = "Furniture & Equipment";
//   static const String vehicles = "Vehicles";
//   static const String intangibleAssets = "Intangible Assets";
// }
//
// // String constants for Other Asset Subcategories
// class OtherAssetSubcategories {
//   static const String longTermInvestments = "Long-term Investments";
//   static const String deposits = "Deposits";
//   static const String endowments = "Endowments";
// }
class AssetCategories {
  // You can define common behavior or properties for all asset categories here
  static const String CURRENT_ASSET_CATEGORY = 'cash';
  static const String FIXED_ASSETS_CATEGORY = 'cash';
  static const String OTHER_CATEGORY = 'cash';

}

// CurrentAssets class with static constants for subcategories
class CurrentAssets extends AssetCategories {
  static const String CASH_CATEGORY = 'cash';
  static const String ACCOUNT_RECIEVABLE = 'accountsReceivable';
  static const String PREPAID_EXPENSE = 'prepaidExpenses';
  static const String INVENTORY = 'inventory';
  static const String SHORT_TERM_INVESTEMENT = 'shortTermInvestments';
}

// FixedAssets class with static constants for subcategories
class FixedAssets extends AssetCategories {
  static const String LAND = 'land';
  static const String BUILDINGS = 'buildings';
  static const String FURNITURE_AND_EQUIPMENT = 'furnitureAndEquipment';
  static const String VEHICLES = 'vehicles';
  static const String INTANGIBLE_ASSETS = 'intangibleAssets';
}

// OtherAssets class with static constants for subcategories
class OtherAssets extends AssetCategories {
  static const String LONG_TERM_INVESTMENTS = 'longTermInvestments';
  static const String DEPOSITS = 'deposits';
  static const String ENDOWMENTS = 'endowments';
}