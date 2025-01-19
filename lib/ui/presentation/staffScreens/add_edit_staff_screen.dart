import 'package:flutter/material.dart';
import 'package:school/services/staff_attendance_service.dart';
import '../../../data/models/attendanceModel/staff_attendance_model.dart';
import '../../../data/models/attendanceModel/teacher_attendance_model.dart';
import '../../../services/attendance_service.dart';
import '../../../services/teacher_attendance_service.dart'; // Assuming you have this service for managing attendance

class TakeStaffAttendanceScreen extends StatefulWidget {
  @override
  _TakeStaffAttendanceScreenState createState() =>
      _TakeStaffAttendanceScreenState();
}

class _TakeStaffAttendanceScreenState extends State<TakeStaffAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late StaffAttendanceService _attendanceService;
  late TeacherAttendanceService _teacherAttendanceService;

  late List<StaffAttendanceModel> _staffMembers;
  late List<StaffAttendanceModel> _filteredStaffMembers;
  late List<TeacherAttendanceModel> _teachers;
  List<TeacherAttendanceModel> _filteredTeachers = [];
  DateTime _selectedDate = DateTime.now();
  String? _selectedDepartment;
  TextEditingController _teacherSearchController = TextEditingController();

  List<String> _departmentList = ["HR", "IT", "Finance", "Admin"]; // Example departments
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _attendanceService = StaffAttendanceService();
    _teacherAttendanceService = TeacherAttendanceService();
    _staffMembers = _attendanceService.getAllStaffAttendance(); // Get all staff attendance
    _filteredStaffMembers = List.from(_staffMembers); // Initialize the filtered list
    _teachers = _teacherAttendanceService.getAllTeacherAttendance(); // Get all teachers attendance
    _filteredTeachers = List.from(_teachers); // Initialize the filtered list
    _tabController = TabController(length: 2, vsync: this);

    // Listener for search field to filter teachers
    _teacherSearchController.addListener(_filterTeachersBySearch);
  }

  // Function to fetch attendance based on selected department
  void _filterAttendanceByDepartment(String? selectedDepartment) {
    setState(() {
      if (selectedDepartment != null) {
        _filteredStaffMembers = _staffMembers
            .where((staff) => staff.departmentId == selectedDepartment)
            .toList(); // Filter staff by department
      } else {
        _filteredStaffMembers = List.from(_staffMembers); // Show all staff if no department is selected
      }
    });
  }

  // Function to filter teachers based on search input
  void _filterTeachersBySearch() {
    String query = _teacherSearchController.text.toLowerCase();
    setState(() {
      _filteredTeachers = _teachers
          .where((teacher) =>
          teacher.teacherName.toLowerCase().contains(query))
          .toList();
    });
  }

  // Function to save attendance for all staff/teachers
  void _saveAttendance() {
    // Save attendance for staff members
    for (var staff in _filteredStaffMembers) {
      _attendanceService.addOrUpdateStaffAttendance(staff); // Correct method for staff
    }

    // Save attendance for teachers
    for (var teacher in _teachers) {
      _teacherAttendanceService.addOrUpdateTeacherAttendance(teacher); // Correct method for teachers
    }

    // Show a snackbar notification to confirm the attendance has been recorded
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Attendance has been recorded for ${_selectedDate.toLocal()}'),
    ));
  }

  // Function to handle the checkbox toggling for Present/Absent for Staff
  void _toggleStaffAttendance(StaffAttendanceModel staff, bool isPresent) {
    setState(() {
      if (isPresent) {
        staff.isPresent = true;
        staff.isOnLeave = false;
      } else {
        staff.isPresent = false;
      }
    });
  }

  // Function to handle the checkbox toggling for Present/Absent for Teachers
  void _toggleTeacherAttendance(TeacherAttendanceModel teacher, bool isPresent) {
    setState(() {
      if (isPresent) {
        teacher.isPresent = true;
        teacher.isOnLeave = false;
      } else {
        teacher.isPresent = false;
      }
    });
  }

  // Function to toggle leave status for Staff
  void _toggleStaffLeave(StaffAttendanceModel staff) {
    setState(() {
      staff.isOnLeave = !staff.isOnLeave;
      if (staff.isOnLeave) {
        staff.isPresent = false;
      }
    });
  }

  // Function to toggle leave status for Teachers
  void _toggleTeacherLeave(TeacherAttendanceModel teacher) {
    setState(() {
      teacher.isOnLeave = !teacher.isOnLeave;
      if (teacher.isOnLeave) {
        teacher.isPresent = false;
      }
    });
  }

  // Function to select the date
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // Prevent selecting Sundays
    if (pickedDate != null && pickedDate.weekday != DateTime.sunday) {
      setState(() {
        _selectedDate = pickedDate;
      });
    } else if (pickedDate?.weekday == DateTime.sunday) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sundays are not allowed. Please select a different day.'),
      ));
    }
  }

  @override
  void dispose() {
    _teacherSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Staff Attendance'),
        backgroundColor: Colors.deepPurple, // Modern app bar color
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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Staff'),
            Tab(text: 'Teachers'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker (This should be shown above both staff and teachers tabs)
            Row(
              children: [
                // Date Picker
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate.isAtSameMomentAs(DateTime.now())
                              ? 'Today'
                              : 'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.calendar_today, color: Colors.deepPurple),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // TabBarView for Staff and Teachers
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Staff Tab
                  Column(
                    children: [
                      // Department Dropdown (Only for staff)
                      DropdownButton<String>(
                        value: _selectedDepartment,
                        isExpanded: true,
                        hint: Text('Select Department'),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDepartment = newValue;
                          });
                          _filterAttendanceByDepartment(newValue);
                        },
                        items: _departmentList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                        underline: Container(),
                        dropdownColor: Colors.white,
                      ),
                      // Staff List
                      Expanded(
                        child: ListView.builder(
                          itemCount: _filteredStaffMembers.length,
                          itemBuilder: (context, index) {
                            var staff = _filteredStaffMembers[index];
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                title: Text(staff.staffName,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                subtitle: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: staff.isPresent ? Colors.green : Colors.grey,
                                      ),
                                      onPressed: () => _toggleStaffAttendance(staff, true), // Mark present
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: !staff.isPresent && !staff.isOnLeave
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () => _toggleStaffAttendance(staff, false), // Mark absent
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: staff.isOnLeave ? Colors.blue : Colors.grey,
                                      ),
                                      onPressed: () => _toggleStaffLeave(staff), // Mark leave
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

                  // Teacher Tab with Search Bar
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _teacherSearchController,
                          decoration: InputDecoration(
                            labelText: 'Search Teacher',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      // Teachers List
                      Expanded(
                        child: ListView.builder(
                          itemCount: _filteredTeachers.length,
                          itemBuilder: (context, index) {
                            var teacher = _filteredTeachers[index];
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                title: Text(teacher.teacherName,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                subtitle: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: teacher.isPresent ? Colors.green : Colors.grey,
                                      ),
                                      onPressed: () => _toggleTeacherAttendance(teacher, true), // Mark present
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: !teacher.isPresent && !teacher.isOnLeave
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () => _toggleTeacherAttendance(teacher, false), // Mark absent
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: teacher.isOnLeave ? Colors.blue : Colors.grey,
                                      ),
                                      onPressed: () => _toggleTeacherLeave(teacher), // Mark leave
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
                ],
              ),
            ),

            // Save Attendance Button
            Center(
              child: ElevatedButton(
                onPressed: _saveAttendance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Save Attendance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
