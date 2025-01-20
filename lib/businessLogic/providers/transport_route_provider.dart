import 'package:flutter/cupertino.dart';
import 'package:school/data/models/feeModel/fee_model.dart';

import '../../data/models/route_model.dart';
import '../../data/models/student_model/student_model.dart';

class TransportRouteProvider extends ChangeNotifier {
   List<StudentModel> getStudents() {
    return [
      StudentModel(
        firstName: 'Alice',
        lastName: 'Johnson',
        gender: 'Female',
        dateOfBirth: '2007-05-21',
        placeOfBirth: 'New York',
        dateOfAdmission: '2022-09-01',
        photoLink: 'https://example.com/photos/alice.jpg',
        otherPhoneNo: '123-456-7890',
        emergencyContactNo: '987-654-3210',
        completeAddress: '123 Main St, New York, NY',
        studentId: 'S001',
        rollNo: '1',
        classID: '10A',
        section: 'A',
        previousSchoolName: 'Greenwood High School',
        reasonOfLeaving: '',
        reference: 'Mr. Smith',
        studentAllFeeTypes: {
        },
        parentId: 'P001',
        concessionInPercent: 10.0,
        concessionInPKR: 500.0,
      ),
      StudentModel(
        firstName: 'Bob',
        lastName: 'Brown',
        gender: 'Male',
        dateOfBirth: '2006-07-11',
        placeOfBirth: 'Los Angeles',
        dateOfAdmission: '2021-10-12',
        photoLink: 'https://example.com/photos/bob.jpg',
        otherPhoneNo: '234-567-8901',
        emergencyContactNo: '876-543-2109',
        completeAddress: '456 Oak St, Los Angeles, CA',
        studentId: 'S002',
        rollNo: '2',
        classID: '10B',
        section: 'B',
        previousSchoolName: 'Sunset Academy',
        reasonOfLeaving: '',
        reference: 'Mr. Lee',
        studentAllFeeTypes: {
         },
        parentId: 'P002',
        concessionInPercent: 5.0,
        concessionInPKR: 250.0,
      ),
      // More students can be added similarly
    ];
  }

  // Generate mock data for RouteModel
   List<RouteModel> getRoutes() {
    return [
      RouteModel(
        routeID: 'R001',
        routeName: 'Route A - Main Street',
        driverName: 'John Doe',
        driverNumber: '123-456-7890',
        vehicleNumber: 'XYZ-1234',
        staffID: 'S001',
        routeFee: FeeModel(
          feeType: "Transport Fee"
           ,createdFeeAmount: 400,
          isFullyPaid: false,

        ),
        routeStudentIDs: ['S001', 'S002'],
      ),
      RouteModel(
        routeID: 'R002',
        routeName: 'Route B - Oak Avenue',
        driverName: 'Jane Smith',
        driverNumber: '987-654-3210',
        vehicleNumber: 'ABC-9876',
        staffID: 'S002',
        routeFee: FeeModel(
          feeType: "Transport Fee"
          ,createdFeeAmount: 400,
          isFullyPaid: false,

        ),
        routeStudentIDs: ['S003', 'S004'],
      ),
      RouteModel(
        routeID: 'R003',
        routeName: 'Route C - Pine Road',
        driverName: 'Bob Johnson',
        driverNumber: '555-123-4567',
        vehicleNumber: 'LMN-1234',
        staffID: 'S003',
        routeFee: FeeModel(
          feeType: "Transport Fee"
          ,createdFeeAmount: 400,
          isFullyPaid: false,

        ),
        routeStudentIDs: ['S005', 'S006'],
      ),
      RouteModel(
        routeID: 'R004',
        routeName: 'Route D - Maple Boulevard',
        driverName: 'Emily Williams',
        driverNumber: '444-555-6666',
        vehicleNumber: 'DEF-4321',
        staffID: 'S004',
        routeFee: FeeModel(
          feeType: "Transport Fee"
          ,createdFeeAmount: 400,
          isFullyPaid: false,

        ),
        routeStudentIDs: ['S007', 'S008'],
      ),
      RouteModel(
        routeID: 'R005',
        routeName: 'Route E - Birch Lane',
        driverName: 'Michael Brown',
        driverNumber: '333-444-5555',
        vehicleNumber: 'GHI-5678',
        staffID: 'S005',
        routeFee: FeeModel(
          feeType: "Transport Fee"
          ,createdFeeAmount: 400,
          isFullyPaid: false,

        ),
        routeStudentIDs: ['S009', 'S010'],
      ),
      // More routes can be added similarly
    ];
  }
}
