import 'package:school/data/models/feeModel/fee_model.dart';
import 'package:school/data/models/student_model/student_model.dart';

class RouteModel {
  String routeID;
  String routeName;
  String driverName;
  String driverNumber;
  String vehicleNumber;
  String staffID;
  FeeModel routeFee;
  List<String> routeStudentIDs;

  RouteModel({
    required this.driverName,
    required this.driverNumber,
    required this.routeFee,
    required this.routeID,
    required this.routeName,
    required this.routeStudentIDs,
    required this.staffID,
    required this.vehicleNumber,
  });
}
