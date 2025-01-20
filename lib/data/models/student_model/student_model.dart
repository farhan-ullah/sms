import '../feeModel/fee_model.dart';


class StudentModel {
  String? firstName;

  String? lastName;

  String? gender;

  String? dateOfBirth;

  String? placeOfBirth;

  String? dateOfAdmission;

  String? photoLink;

  String? otherPhoneNo;

  String? emergencyContactNo;

  String? completeAddress;

  String? studentId;

  String? rollNo;

  String? classID;

  String? section;

  String? previousSchoolName;

  String? reasonOfLeaving;

  String? reference;

  Map<String, FeeModel>? studentAllFeeTypes;

  String? parentId;

  double? concessionInPercent;

  double? concessionInPKR;

  String? routeID;

  StudentModel({
    this.routeID,
    this.concessionInPercent,
    this.concessionInPKR,
    this.parentId,
    this.firstName,
    this.studentAllFeeTypes,
    this.lastName = "",
    this.classID = "",
    this.studentId = "",
    this.gender = "",
    this.dateOfAdmission = "",
    this.dateOfBirth = "",
    this.placeOfBirth = "",
    this.photoLink = "",
    this.previousSchoolName = "",
    this.rollNo = "",
    this.section = "",
    this.reference = "",
    this.completeAddress = "",
    this.emergencyContactNo = "",
    this.otherPhoneNo = "",
    this.reasonOfLeaving = "",
  });

  // Factory method to create an instance from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      firstName: json['firstName'],
      lastName: json['lastName'] ?? "",
      gender: json['gender'] ?? "",
      dateOfBirth: json['dateOfBirth'] ?? "",
      placeOfBirth: json['placeOfBirth'] ?? "",
      dateOfAdmission: json['dateOfAdmission'] ?? "",
      photoLink: json['photoLink'] ?? "",
      otherPhoneNo: json['otherPhoneNo'] ?? "",
      emergencyContactNo: json['emergencyContactNo'] ?? "",
      completeAddress: json['completeAddress'] ?? "",
      studentId: json['studentId'] ?? "",
      rollNo: json['rollNo'] ?? "",
      classID: json['className'] ?? "",
      section: json['section'] ?? "",
      previousSchoolName: json['previousSchoolName'] ?? "",
      reasonOfLeaving: json['reasonOfLeaving'] ?? "",
      reference: json['reference'] ?? "",
      parentId: json['parentId'],
      studentAllFeeTypes: json['studentAllFeeTypes'] != null
          ? Map<String, FeeModel>.from(json['studentAllFeeTypes']
          .map((k, v) => MapEntry(k, FeeModel.fromJson(v))))
          : null,
      concessionInPercent: json['concessionInPercent']?.toDouble(),
      concessionInPKR: json['concessionInPKR']?.toDouble(),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'placeOfBirth': placeOfBirth,
      'dateOfAdmission': dateOfAdmission,
      'photoLink': photoLink,
      'otherPhoneNo': otherPhoneNo,
      'emergencyContactNo': emergencyContactNo,
      'completeAddress': completeAddress,
      'studentId': studentId,
      'rollNo': rollNo,
      'className': classID,
      'section': section,
      'previousSchoolName': previousSchoolName,
      'reasonOfLeaving': reasonOfLeaving,
      'reference': reference,
      'parentId': parentId,
      'studentAllFeeTypes': studentAllFeeTypes?.map((k, v) => MapEntry(k, v.toJson())),
      'concessionInPercent': concessionInPercent,
      'concessionInPKR': concessionInPKR,
    };
  }
}
