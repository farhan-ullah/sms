import 'package:flutter/material.dart';

class TimeTableModel {
  TimeOfDay startTime;
  TimeOfDay endTime;
  String timeTableName;
  String? day;
  String? date;
  String className;
  String? teacherName;

  TimeTableModel({
    this.className = "",
    this.date = "",
    this.day = "",
    this.teacherName = "",
    required this.endTime,
    required this.startTime,
    required this.timeTableName,
  });
}

class TimetableCreationScreen extends StatefulWidget {
  @override
  _TimetableCreationScreenState createState() =>
      _TimetableCreationScreenState();
}

class _TimetableCreationScreenState extends State<TimetableCreationScreen> {
  // List to hold multiple timetable entries
  List<TimeTableModel> timetables = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for adding new timetable entry
  TextEditingController _classNameController = TextEditingController();
  TextEditingController _teacherNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeTableNameController = TextEditingController();

  // List of available days
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  // Handle day change (Dropdown instead of TextFormField)
  String? _selectedDay;
  TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);

  // Add a new timetable entry to the list
  void _addTimetableEntry() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        timetables.add(TimeTableModel(
          startTime: _startTime,
          endTime: _endTime,
          timeTableName: _timeTableNameController.text,
          className: _classNameController.text,
          teacherName: _teacherNameController.text,
          day: _selectedDay,
          date: _dateController.text,
        ));
      });

      // Clear the form fields after adding an entry
      _timeTableNameController.clear();
      _classNameController.clear();
      _teacherNameController.clear();
      _dateController.clear();
      setState(() {
        _selectedDay = null;
      });
    }
  }

  // Remove a timetable entry from the list
  void _removeTimetableEntry(int index) {
    setState(() {
      timetables.removeAt(index);
    });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (selectedTime != null) {
      setState(() {
        _startTime = selectedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (selectedTime != null) {
      setState(() {
        _endTime = selectedTime;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Finalize the timetable by taking the entries and performing an action
  void _finalizeTimetable() {
    if (timetables.isNotEmpty) {
      // Here you can save, export, or perform other actions with the timetable
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Timetable has been finalized!')),
      );

      // Example: Clear all timetables after finalizing
      setState(() {
        timetables.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No timetable entries to finalize!')),
      );
    }
  }

  @override
  void dispose() {
    _classNameController.dispose();
    _teacherNameController.dispose();
    _dateController.dispose();
    _timeTableNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Timetable')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _timeTableNameController,
                    decoration: InputDecoration(labelText: 'Timetable Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a timetable name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _classNameController,
                    decoration: InputDecoration(labelText: 'Class Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a class name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _teacherNameController,
                    decoration: InputDecoration(labelText: 'Teacher Name'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedDay,
                    items: days.map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Day'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a day';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(labelText: 'Date'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Start Time: ${_startTime.format(context)}"),
                    trailing: Icon(Icons.access_time),
                    onTap: () => _selectStartTime(context),
                  ),
                  ListTile(
                    title: Text("End Time: ${_endTime.format(context)}"),
                    trailing: Icon(Icons.access_time),
                    onTap: () => _selectEndTime(context),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addTimetableEntry,
                    child: Text('Add Timetable Entry'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: timetables.length,
                itemBuilder: (context, index) {
                  final entry = timetables[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('${entry.timeTableName} (${entry.className})'),
                      subtitle: Text(
                        'Teacher: ${entry.teacherName}\nDay: ${entry.day}, Date: ${entry.date}\n'
                            'Start Time: ${entry.startTime.format(context)} - '
                            'End Time: ${entry.endTime.format(context)}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTimetableEntry(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _finalizeTimetable,
              child: Text('Finalize Timetable'),
            ),
          ],
        ),
      ),
    );
  }
}
