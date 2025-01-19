import 'package:hive/hive.dart';


class ParentModel {
  String? parentId;

  String? firstName;

  String? lastName;

  String? nic;

  String? email;

  String? phoneNumber;

  List<String>? childrenIDs;

  String? completeAddress;


  ParentModel({
    this.completeAddress,
    this.childrenIDs,
    required this.parentId,
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required this.email,
    required this.nic,
  });
}
