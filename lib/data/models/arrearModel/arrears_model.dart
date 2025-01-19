import 'package:hive/hive.dart';



class ArrearsModel  {

  String nameOfArrears;


  int amountOfArrears;

  String description;

  String feeId;

  List<Map<String, String>> totalArrearsDetails;

  int sumOfArrears;

  ArrearsModel({
    required this.totalArrearsDetails,
    required this.sumOfArrears,
    required this.feeId,
    required this.amountOfArrears,
    required this.description,
    required this.nameOfArrears,
  });
}
