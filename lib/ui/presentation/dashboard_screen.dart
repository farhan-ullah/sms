import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Charting library
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For loading spinner
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/businessLogic/providers/teacher_provider.dart';
import 'package:school/data/models/classNameModel/class_name_model.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import '../../data/models/student_model/student_model.dart';
import 'new_widgets/methods/build_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool showData= false;

  // Function to update selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar('Dashboard'),
      body: Row(
        children: [
          // Sidebar on the left side

          // Main content area (Dashboard)
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


  // Method to return the selected screen
  Widget _getSelectedScreen() {
    final studentProvider= Provider.of<StudentProvider>(context);
    switch (_selectedIndex) {
      case 0:
        return _dashboardContent(studentProvider);
      default:
        return const Center(child: Text('Select an option from the sidebar'));
    }
  }

  // Dashboard Content
  Widget _dashboardContent(StudentProvider studentProvider) {

    final teacherProvider = Provider.of<TeacherProvider>(context);
    final classProvider = Provider.of<ClassNameProvider>(context);



    List<StudentModel> students= studentProvider.mockStudentList;
    List<ClassNameModel> classes= classProvider.mockClassList;
    List<TeacherModel> teachers = teacherProvider.mockTeacherList;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                setState(() {
                  showData=!showData;

                });

              }, icon: Icon(FontAwesomeIcons.solidEye)),
              SizedBox(width: 40,)
            ],
          ),
          // Row with Summary Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [      _dashboardCard('Students',showData?"***": students.length.toString(), Icons.school),

                _dashboardCard('Teachers',showData?"***": teachers.length.toString(), Icons.person),
               ],),
              Column(
                children: [
                  _dashboardCard('Classes',showData?"***": classes.length.toString(), Icons.class_),
                  _dashboardCard('Exams', '10', Icons.assignment),
                ],
              ),
              Column(children: [
                _dashboardCard('Events', '5', Icons.event),
                _dashboardCard('Assignments', '200', Icons.assignment_ind),
              ],),

           Column(
             children: [

               _dashboardCard('Departments', '8', Icons.business),
               _dashboardCard('Attendance', '95%', Icons.check_circle),
             ],
           )
            ],
          ),
          const SizedBox(height: 20),

          // Section: Performance Charts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _pieChart(),
              _barChart(),
            ],
          ),
          const SizedBox(height: 20),

          // Section: Recent Activities or Updates
          _recentActivities(),
          const SizedBox(height: 20),

          // Section: Progress Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _progressIndicator('Student Enrollment', 0.99),
              _progressIndicator('Teacher Assignments', 0.4),
            ],
          ),
          const SizedBox(height: 20),

          // Section: Notifications
          _notificationTile('New Student Added', Icons.notifications),
          _notificationTile('Teacher Assignment Pending', Icons.notifications),
          const SizedBox(height: 20),

          // Section: Data Table (e.g., Students or Teachers List)
          _dataTable(),
          const SizedBox(height: 20),

          // Section: Loading State
          _loadingIndicator(),
        ],
      ),
    );
  }

  // Function for a summary card with a title, number, and icon

  Widget _dashboardCard(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.24,
        width: MediaQuery.of(context).size.width*0.11,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // Slightly transparent background for icon
                shape: BoxShape.circle, // Circular container for the icon
              ),
              child: FaIcon(
                icon, // Font Awesome icon used here
                color: Colors.white,
                size: MediaQuery.of(context).size.width*0.024,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pie Chart (Performance Stats, e.g., students passing/failing)
  Widget _pieChart() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 7.7, color: Colors.green, title: 'Pass'),
                PieChartSectionData(value: 02.3, color: Colors.red, title: 'Fail'),
              ],
            ),
          ),
        ),

        SizedBox(width: 35,),
        SizedBox(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 2.7, color: Colors.green, title: 'Done'),
                PieChartSectionData(value: 7.3, color: Colors.red, title: 'Remaining'),
              ],
            ),
          ),
        ),
        SizedBox(width: 35,),
        SizedBox(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 5.7, color: Colors.blue, title: 'Paid'),
                PieChartSectionData(value: 4.3, color: Colors.yellowAccent, title: 'Unpaid'),
              ],
            ),
          ),
        ),


      ],
    );
  }

  // Bar Chart (e.g., Attendance or Test Scores)
  Widget _barChart() {
    return Container(
      width: 160,
      height: 160,
      child: BarChart(

        BarChartData(
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(show: true),
          gridData: FlGridData(show: true),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(fromY: 8, color: Colors.blue, toY: 1)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(fromY: 6, color: Colors.blue, toY: 13)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(fromY: 5, color: Colors.blue, toY: 7)]),
          ],
        ),
      ),
    );
  }

  // Recent Activities List (e.g., recent students enrolled, reports generated)
  Widget _recentActivities() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _activityTile('Student Enrollment: 10 new students', Icons.person_add),
          _activityTile('Teacher Report Generated', Icons.print),
          _activityTile('New Class Created', Icons.add_box),
        ],
      ),
    );
  }

  // Individual Activity Tile (For Recent Activities)
  Widget _activityTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
    );
  }

  // Circular Progress Indicator (e.g., Progress of an activity)
  Widget _progressIndicator(String title, double progress) {
    return Column(
      children: [
        Text(title),
        CircularPercentIndicator(
          radius: 100,
          lineWidth: 12,
          percent: progress,
          center: Text('${(progress * 100).toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold)),
          progressColor: Colors.green,
        ),
      ],
    );
  }

  // Notification Tile (e.g., Important updates or reminders)
  Widget _notificationTile(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: const Text('Click to view details'),
        onTap: () {},
      ),
    );
  }

  // Data Table (Display a list of students or teachers)
  Widget _dataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Class')),
          DataColumn(label: Text('Status')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(const Text('John Doe')),
            DataCell(const Text('15')),
            DataCell(const Text('Grade 10')),
            DataCell(const Text('Active')),
          ]),
          DataRow(cells: [
            DataCell(const Text('Jane Smith')),
            DataCell(const Text('14')),
            DataCell(const Text('Grade 9')),
            DataCell(const Text('Active')),
          ]),
        ],
      ),
    );
  }

  // Loading Indicator (For when data is being fetched)
  Widget _loadingIndicator() {
    return Center(
      child: SpinKitCircle(
        color: Colors.blueAccent,
        size: 50.0,
      ),
    );
  }
}


