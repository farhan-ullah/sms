import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../businessLogic/providers/attendance_provider.dart';
import '../../../data/models/attendanceModel/student_attendance_model.dart';
import '../../../services/attendance_service.dart';

class AttendanceReportScreen extends StatefulWidget {
  @override
  _AttendanceReportScreenState createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  late AttendanceService _attendanceService;
  late List<StudentAttendanceModel> _attendanceRecords;
  String? _selectedClass;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<String> _classList = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];
  List<String> _filterOptions = ['Today', 'Last Week', 'Last Month', 'Custom'];
  String _selectedFilter = 'Today';
  bool _showDetails = false; // Toggle between graph and details

  @override
  void initState() {
    super.initState();
    _attendanceService = AttendanceService();
    _attendanceRecords = _attendanceService.getAllAttendance();
    _filterAttendance('Today');
  }

  void _filterAttendance(String filterType) {
    DateTime startDate;
    DateTime endDate = DateTime.now();

    // If filter is "Today", make sure we only show today's records
    switch (filterType) {
      case 'Last Week':
        startDate = endDate.subtract(Duration(days: 7));
        break;
      case 'Last Month':
        startDate = endDate.subtract(Duration(days: 30));
        break;
      case 'Custom':
        startDate = _startDate;
        endDate = _endDate;
        break;
      case 'Today':
      default:
        startDate = DateTime(endDate.year, endDate.month, endDate.day);  // Set start of today
        endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);  // Set end of today
        break;
    }

    setState(() {
      _selectedFilter = filterType;
      _startDate = startDate;
      _endDate = endDate;

      // Only fetch records for the selected class (if any) and within the date range
      _attendanceRecords = _attendanceService.getAllAttendance().where((attendance) {
        bool isInDateRange = attendance.date.isAfter(startDate.subtract(Duration(days: 1))) &&
            attendance.date.isBefore(endDate.add(Duration(days: 1)));
        bool matchesClass = _selectedClass == null || attendance.classId == _selectedClass;
        return isInDateRange && matchesClass;
      }).toList();
    });
  }

  // Aggregate attendance by student
  Map<String, Map<String, int>> _aggregateAttendanceByStudent() {
    Map<String, Map<String, int>> studentAttendanceSummary = {};

    for (var record in _attendanceRecords) {
      if (!studentAttendanceSummary.containsKey(record.studentName)) {
        studentAttendanceSummary[record.studentName] = {'Present': 0, 'Absent': 0, 'On Leave': 0};
      }

      if (record.isPresent) {
        studentAttendanceSummary[record.studentName]!['Present'] =
            studentAttendanceSummary[record.studentName]!['Present']! + 1;
      } else if (record.isOnLeave) {
        studentAttendanceSummary[record.studentName]!['On Leave'] =
            studentAttendanceSummary[record.studentName]!['On Leave']! + 1;
      } else {
        studentAttendanceSummary[record.studentName]!['Absent'] =
            studentAttendanceSummary[record.studentName]!['Absent']! + 1;
      }
    }

    return studentAttendanceSummary;
  }

  Future<void> _selectStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
      _filterAttendance('Custom');
    }
  }

  Future<void> _selectEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
      _filterAttendance('Custom');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, int>> studentAttendanceSummary = _aggregateAttendanceByStudent();

    // Prepare the PieChart data
    List<PieChartSectionData> pieChartData = [];
    int totalPresent = 0, totalAbsent = 0, totalOnLeave = 0;

    studentAttendanceSummary.forEach((studentName, summary) {
      totalPresent += summary['Present']!;
      totalAbsent += summary['Absent']!;
      totalOnLeave += summary['On Leave']!;
    });

    pieChartData = [
      PieChartSectionData(
        value: totalPresent.toDouble(),
        color: Colors.green,
        title: 'Present\n$totalPresent',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: totalAbsent.toDouble(),
        color: Colors.red,
        title: 'Absent\n$totalAbsent',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: totalOnLeave.toDouble(),
        color: Colors.blue,
        title: 'On Leave\n$totalOnLeave',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Report"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedClass,
                    isExpanded: true,
                    hint: Text('Select Class'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedClass = newValue;
                      });
                      _filterAttendance(_selectedFilter);
                    },
                    items: _classList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                    underline: Container(),
                    dropdownColor: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    isExpanded: true,
                    onChanged: (String? filterValue) {
                      setState(() {
                        _filterAttendance(filterValue!);
                      });
                    },
                    items: _filterOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                    icon: Icon(Icons.filter_list, color: Colors.deepPurple),
                    underline: Container(),
                    dropdownColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Showing attendance for: $_selectedFilter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),

            // Custom Date Picker for the "Custom" Filter
            if (_selectedFilter == 'Custom') ...[
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectStartDate,
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: "Start Date"),
                        child: Text(DateFormat('yyyy-MM-dd').format(_startDate)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _selectEndDate,
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: "End Date"),
                        child: Text(DateFormat('yyyy-MM-dd').format(_endDate)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20),

            // Toggle between Graph and List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showDetails = !_showDetails;
                    });
                  },
                  child: Text(_showDetails ? 'Show Graph' : 'Show Details'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Show Graph or Attendance Details
            _showDetails
                ? Expanded(
              child: ListView.builder(
                itemCount: studentAttendanceSummary.length,
                itemBuilder: (context, index) {
                  String studentName = studentAttendanceSummary.keys.elementAt(index);
                  var summary = studentAttendanceSummary[studentName]!;
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        studentName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                          'Present: ${summary['Present']}  Absent: ${summary['Absent']}  On Leave: ${summary['On Leave']}'),
                      trailing: Icon(
                        summary['Present']! > 0
                            ? Icons.check_circle
                            : (summary['On Leave']! > 0
                            ? Icons.schedule
                            : Icons.cancel),
                        color: summary['Present']! > 0
                            ? Colors.green
                            : (summary['On Leave']! > 0 ? Colors.blue : Colors.red),
                      ),
                    ),
                  );
                },
              ),
            )
                : Expanded(
              child: PieChart(
                PieChartData(
                  sections: pieChartData,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 60,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Export Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Export logic can be added here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Export Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
