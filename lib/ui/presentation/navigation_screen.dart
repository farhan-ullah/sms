import 'package:flutter/material.dart';
import 'package:school/ui/presentation/accounts/revenue_expense_screen.dart';
import 'package:school/ui/presentation/attendenceScreens/settings.dart';
import 'package:school/ui/presentation/attendenceScreens/take_attendance_screen.dart';
import 'package:school/ui/presentation/canteenScreens/product_list_screen.dart';
import 'package:school/ui/presentation/canteenScreens/sales_report_screen.dart';
import 'package:school/ui/presentation/canteenScreens/stock_management_screen.dart';
import 'package:school/ui/presentation/examScreeens/exam_result_screen.dart';
import 'package:school/ui/presentation/examScreeens/exam_scheduling_screen.dart';
import 'package:school/ui/presentation/examScreeens/marks_entry_screen.dart';
import 'package:school/ui/presentation/expense_screens/expense_categories_screen.dart';
import 'package:school/ui/presentation/expense_screens/expense_dashboard_screen.dart';
import 'package:school/ui/presentation/feeScreens/fee_structure_screen.dart';
import 'package:school/ui/presentation/parents/add_parent.dart';
import 'package:school/ui/presentation/parents/parents_screen.dart';
import 'package:school/ui/presentation/salaryScreens/generate_salary-screen.dart';
import 'package:school/ui/presentation/salaryScreens/payslip_screeen.dart';
import 'package:school/ui/presentation/salaryScreens/salary_payment_screen.dart';
import 'package:school/ui/presentation/salaryScreens/salary_tiers.dart';
import 'package:school/ui/presentation/salaryScreens/salary_report_screen.dart';
import 'package:school/ui/presentation/staffScreens/add_edit_staff_screen.dart';
import 'package:school/ui/presentation/staffScreens/staff_attendance_report_screen.dart';
import 'package:school/ui/presentation/staffScreens/staff_list_screen.dart';
import 'package:school/ui/presentation/students_screens/add_student_screen.dart';
import 'package:school/ui/presentation/students_screens/view_student_screen.dart';
import 'package:school/ui/presentation/subjectScreens/view_subject_screen.dart';
import 'package:school/ui/presentation/teachers_screens/add_teacher_screen.dart';
import 'package:school/ui/presentation/teachers_screens/manage_teacher_screen.dart';
import 'package:school/ui/presentation/timeTableScreens/timetable_creation_screen.dart';
import 'package:school/ui/presentation/timeTableScreens/timetable_preview_screen.dart';
import 'package:school/ui/presentation/transportScreens/routes_screen.dart';
import 'package:school/ui/presentation/user_management_screen.dart';
import 'package:school/ui/presentation/widgets/side_bar.dart';
import 'accounts/report_screen.dart';
import 'attendenceScreens/attendance_reports.dart';
import 'canteenScreens/selling_screen.dart';
import 'class_screens/manage_class_screen.dart';
import 'dashboard_screen.dart';
import 'examScreeens/exam_registration_screen.dart';
import 'expense_screens/add_new_expense_screen.dart';
import 'feeScreens/fee_generation_screen.dart';
import 'feeScreens/fee_payment_screen.dart';
import 'feeScreens/view_fee_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0; // Main section index

  // Function to update selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: Row(
        children: [
          // Sidebar
          Sidebar(
              onItemTapped: _onItemTapped),

          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _getSelectedScreen(),
            ),
          ),
        ],
      ),
    );
  }

  // Method to return the selected screen based on main index and sub-selection
  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 1: // Students section
           return AddStudentScreen();

      case 2: return ViewStudentScreen();



      case 4: // View Classes
        return const AddTeacherScreen();
      case 5: // Reports
        return const ManageTeacherScreen();
      case 6: // Reports
        return  ViewSubjectScreen();
      case 7: // Settings
        return const ManageClassScreen();
      case 8: // Settings
        return const AddParentScreen();
      case 9: // About
        return const ParentsScreen();
      case 10: // About
        return const ViewSubjectScreen();
      // case 11: // About
      //   return const AddSubjectScreen();
      case 12: // About
        return const ViewFeeScreen();
      case 13: // About
        // return const FeeStructureScreen();
      case 14: // About
        return  GenerateFeeScreen();
      case 15: // About
        return const FeePaymentScreen();
      case 16: // About
        return  TimetablePreviewScreen();

      case 17: // About
        return  TimetableCreationScreen();
      // case 18: // About
      //   return  AttendanceDashboardScreen();
      case 19: // About
        return  TakeAttendanceScreen();
      case 20: // About
        return  AttendanceReportScreen();
        case 21: // About
        return UnderDevelopmentExam();
      // return  ExamRegistrationScreen();
      case 22: // About
        return  UserManagementScreen();
      //   case 23: // About
      // return  ExamsScreen();
      case 24: // About
      return  ExamResultsScreen();
      case 25: // About
      return  ExamSchedulingScreen();
      case 26: // About
      return  AttendanceReportScreen();
      case 27: // About
        return  ExpenseDashboardScreen();
      case 28: // About
        return  AddExpenseScreen();
      case 29: // About
        return  ExpenseCategoriesScreen();
      case 30:
        return RoutesScreen();
      case 32: // About
        return  SellScreen();
      case 33: // About
        return  ProductListScreen();
      case 34: // About
        // return  StockManagementScreen();

      case 37: // About
        return  SalesReportScreen();
      case 38: // About
        return  StaffListScreen();
      case 40: // About
        return  TakeStaffAttendanceScreen();
      case 41: // About
        return  SalaryPaymentScreen();
      case 42: // About
        return  SalaryGenerationScreen();
      // case 43: // About
      //   return  SalaryReportScreen();
      case 44: // About
        return  SalaryReportScreen();
      case 45: // About
        return  SalaryTierScreen();
      case 46: // About
        return RevenueExpenseScreen();
      case 47: // About
        return  SettingsScreen();
      default: // Default to Dashboard screen
        return  DashboardScreen();
    }
  }

}