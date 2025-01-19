// // String constants for Equity Categories
// class EquityCategories {
//   static const String ownersEquity = "Owner's Equity";
//   static const String reserveFunds = "Reserve Funds";
// }
//
// // String constants for Owners Equity Subcategories
// class OwnersEquitySubcategories {
//   static const String donationsAndGrants = "Donations & Grants";
//   static const String retainedEarnings = "Retained Earnings";
//   static const String investedCapital = "Invested Capital";
// }
//
// // String constants for Reserve Fund Subcategories
// class ReserveFundSubcategories {
//   static const String operatingReserve = "Operating Reserve";
//   static const String endowmentFunds = "Endowment Funds";
// }
// Constants for Equity Categories
class EquityConstants {
  static const String OWNER_EQUITY_CATEGORY = "ownersEquity";
  static const String RESERVED_FUNDS_CATEGORY = "reserveFunds";
}

// Subclass for Owners Equity Category
class OwnerEquityCategory extends EquityConstants {
  static const String DONATIONS_AND_GRANTS = "donationsAndGrants";
  static const String RETAINED_EARNINGS = "retainedEarnings";
  static const String INVESTED_CAPITAL = "investedCapital";
}

// Subclass for Reserve Funds Category
class ReserveFundsCategory extends EquityConstants {
  static const String OPERATING_RESERVE = "operatingReserve";
  static const String ENDOWMENT_FUNDS = "endowmentFunds";
}
