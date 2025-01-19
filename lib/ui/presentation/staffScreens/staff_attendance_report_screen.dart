import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Importing fl_chart package
import 'dart:math'; // For generating random data

import '../../../services/staff_attendance_service.dart'; // Your service
import '../../../data/models/attendanceModel/staff_attendance_model.dart'; // Your model

class StaffAttendanceReportScreen extends StatefulWidget {
  @override
  _StaffAttendanceReportScreenState createState() =>
      _StaffAttendanceReportScreenState();
}

class _StaffAttendanceReportScreenState extends State<StaffAttendanceReportScreen>
    with TickerProviderStateMixin {
  late StaffAttendanceService _attendanceService;
  String? _selectedDepartment;
  DateTimeRange? _selectedDateRange;
  Map<String, int> _attendanceSummary = {'Present': 0, 'Absent': 0, 'On Leave': 0};

  List<String> _departmentList = ['HR', 'Sales', 'IT', 'Admin', 'Finance'];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _attendanceService = StaffAttendanceService(); // Initialize the service
    _tabController = TabController(length: 2, vsync: this); // Two tabs: Staff & Teacher
  }

  // Fetch attendance summary based on selected department
  void _fetchAttendanceSummary(String departmentId) {
    setState(() {
      _attendanceSummary = _attendanceService.getStaffAttendanceSummary(departmentId);
    });
  }

  // Generate a pie chart for the attendance summary
  Widget _generateAttendanceChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: _attendanceSummary['Present']?.toDouble() ?? 0,
            title: 'Present',
            color: Colors.green,
            radius: 40,
            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            value: _attendanceSummary['Absent']?.toDouble() ?? 0,
            title: 'Absent',
            color: Colors.red,
            radius: 40,
            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            value: _attendanceSummary['On Leave']?.toDouble() ?? 0,
            title: 'On Leave',
            color: Colors.blue,
            radius: 40,
            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Filter attendance by date range
  void _filterAttendanceByDateRange(DateTimeRange? dateRange) {
    if (dateRange != null) {
      setState(() {
        _selectedDateRange = dateRange;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Attendance Report'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Staff Attendance'),
            Tab(text: 'Teacher Attendance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Staff Attendance Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Department selection dropdown
                DropdownButton<String>(
                  value: _selectedDepartment,
                  hint: Text('Select Department'),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDepartment = newValue;
                    });
                    if (newValue != null) {
                      _fetchAttendanceSummary(newValue);
                    }
                  },
                  items: _departmentList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Date range picker
                ElevatedButton(
                  onPressed: () async {
                    DateTimeRange? pickedRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2025, 1, 1),
                      lastDate: DateTime(2025, 12, 31),
                      initialDateRange: _selectedDateRange,
                    );
                    _filterAttendanceByDateRange(pickedRange);
                  },
                  child: Text(
                    _selectedDateRange == null
                        ? 'Select Date Range'
                        : 'Selected: ${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} - ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                SizedBox(height: 20),

                // Attendance Pie Chart
                if (_selectedDepartment != null)
                  Container(
                    height: 200,
                    child: _generateAttendanceChart(),
                  ),
                SizedBox(height: 20),

                // Display the attendance summary for the selected department
                if (_selectedDepartment != null)
                  Column(
                    children: [
                      Text(
                        'Attendance Summary for ${_selectedDepartment!}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _attendanceSummary.isNotEmpty
                                  ? Column(
                                children: _attendanceSummary.entries
                                    .map((entry) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(entry.key, style: TextStyle(fontSize: 16)),
                                      Text(entry.value.toString(), style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ))
                                    .toList(),
                              )
                                  : Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),

                // List of Staff Attendance Records for the selected department
                if (_selectedDepartment != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _attendanceService.getStaffAttendanceByDepartment(_selectedDepartment!).length,
                      itemBuilder: (context, index) {
                        var attendance = _attendanceService.getStaffAttendanceByDepartment(_selectedDepartment!)[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(attendance.staffName),
                            subtitle: Text('Date: ${attendance.date.toLocal().toString().split(' ')[0]}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: attendance.isPresent ? Colors.green : Colors.grey,
                                ),
                                Icon(
                                  Icons.cancel,
                                  color: !attendance.isPresent && !attendance.isOnLeave
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                Icon(
                                  Icons.remove_circle,
                                  color: attendance.isOnLeave ? Colors.blue : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Teacher Attendance Tab (You can customize this as needed)
          Center(
            child: Text('Teacher Attendance Data Goes Here', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
