import 'package:hive/hive.dart';

import '../../../../../constants/financialConstants/asset_constants.dart';

class AssetModel  extends HiveObject{

  final String? assetMainCategory;


  final String? assetSubcategory;


  final double? amount; // Amount for the asset


  final DateTime acquisitionDate; // Acquisition date for the asset


  final String transactionId;


  final String serialNumber;

  final String? assetDescription;

  AssetModel({
    this.assetMainCategory,
    required this.serialNumber, required this.transactionId,  this.assetDescription,
    this.assetSubcategory,
    this.amount,
    required this.acquisitionDate,
  });
}
