import 'package:flutter/material.dart';
import '../../../data/models/attendanceModel/student_attendance_model.dart';
import '../../../services/attendance_service.dart';  // Assuming you have this service or provider for managing attendance

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  _TakeAttendanceScreenState createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  late AttendanceService _attendanceService;
  late List<StudentAttendanceModel> _students;
  DateTime _selectedDate = DateTime.now();
  String? _selectedClass;

  List<String> _classList = ["Class 1", "Class 2", "Class 3", "Class 4"]; // Example classes

  @override
  void initState() {
    super.initState();
    _attendanceService = AttendanceService();
    _students = _attendanceService.getAllAttendance(); // Get all attendance by default
  }

  // Fetch attendance based on selected class
  void _filterAttendanceByClass(String? selectedClass) {
    if (selectedClass != null) {
      setState(() {
        _students = _attendanceService.getAttendanceByClass(selectedClass);
      });
    } else {
      setState(() {
        _students = _attendanceService.getAllAttendance(); // Reset to all attendance
      });
    }
  }

  // Save attendance for all students
  void _saveAttendance() {
    for (var student in _students) {
      _attendanceService.addOrUpdateAttendance(student);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Attendance has been recorded for ${_selectedDate.toLocal()}'),
    ));
  }

  // Function to handle the checkbox toggling for Present/Absent
  void _toggleAttendance(StudentAttendanceModel student, bool isPresent) {
    setState(() {
      if (isPresent) {
        student.isPresent = true;
        student.isOnLeave = false;
      } else {
        student.isPresent = false;
      }
    });
  }

  // Function to toggle leave status
  void _toggleLeave(StudentAttendanceModel student) {
    setState(() {
      student.isOnLeave = !student.isOnLeave;
      if (student.isOnLeave) {
        student.isPresent = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Class Filters Row
            Row(
              children: [
                // Date Picker
// Date Picker Row
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
                              ? 'Today' // Show "Today" if selected date is today
                              : 'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}', // Show formatted date (YYYY-MM-DD) otherwise
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.calendar_today, color: Colors.deepPurple),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Class Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedClass,
                    isExpanded: true,
                    hint: Text('Select Class'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedClass = newValue;
                      });
                      _filterAttendanceByClass(newValue);
                    },
                    items: _classList.map<DropdownMenuItem<String>>((String value) {
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
                ),
              ],
            ),
            SizedBox(height: 20),

            // List of students and their attendance status
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  var student = _students[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(student.studentName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      subtitle: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Present Button
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: student.isPresent ? Colors.green : Colors.grey,
                            ),
                            onPressed: () => _toggleAttendance(student, true), // Mark present
                          ),
                          // Absent Button
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: !student.isPresent && !student.isOnLeave
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () => _toggleAttendance(student, false), // Mark absent
                          ),
                          // Leave Button
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: student.isOnLeave ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () => _toggleLeave(student), // Mark leave
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

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
