import 'package:hive/hive.dart';

class FeeModel{
  String? feeId;

  String? feeType;

  String? feeName;

  double? createdFeeAmount;

  bool? isFullyPaid;

  String? dueDate;

  String? feeDescription;

  String? feeMonth;

  double? feeArrears;

  String? dateOfTransaction;

  bool? isPartiallyPaid;

  double? feeConcessionInPKR;

  String? classID;

  double? generatedFeeAmount;

  double? feeConcessionInPercent;


  FeeModel({
    this.generatedFeeAmount,
    this.classID,
    this.feeConcessionInPercent,
    this.feeConcessionInPKR,
    this.dateOfTransaction,
    this.isPartiallyPaid,
    this.createdFeeAmount,
    this.feeId,
    this.feeArrears,
    this.dueDate,
    this.feeDescription,
    this.feeMonth,
    this.feeName,
    this.feeType,
    this.isFullyPaid,
  });

  @override
  String toString() {
    return '$feeType: \$${createdFeeAmount?.toStringAsFixed(2)} (Concession: $feeConcessionInPKR%)';
  }

  // Factory method to create an instance from JSON
  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      feeId: json['feeId'],
      feeType: json['feeType'],
      feeName: json['feeName'],
      createdFeeAmount: json['feeAmount'] != null ? json['feeAmount'].toDouble() : 0.0,
      isFullyPaid: json['isFullyPaid'],
      dueDate: json['dueDate'],
      feeDescription: json['feeDescription'],
      feeMonth: json['feeMonth'],
      feeArrears: json['feeArrears'] != null ? json['feeArrears'].toDouble() : 0.0,
      dateOfTransaction: json['dateOfTransaction'],
      isPartiallyPaid: json['isPartiallyPaid'],
      feeConcessionInPKR: json['feeConcession'] != null ? json['feeConcession'].toDouble() : 0.0,
      classID: json['className'],
      generatedFeeAmount: json['netFeeAmount'] != null ? json['netFeeAmount'].toDouble() : 0.0,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'feeId': feeId,
      'feeType': feeType,
      'feeName': feeName,
      'feeAmount': createdFeeAmount,
      'isFullyPaid': isFullyPaid,
      'dueDate': dueDate,
      'feeDescription': feeDescription,
      'feeMonth': feeMonth,
      'feeArrears': feeArrears,
      'dateOfTransaction': dateOfTransaction,
      'isPartiallyPaid': isPartiallyPaid,
      'feeConcession': feeConcessionInPKR,
      'className': classID,
      'netFeeAmount': generatedFeeAmount,
    };
  }
}

