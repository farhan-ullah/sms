import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart'; // For checking the platform

// Model for the Timetable class to manage timetable data
class Timetable {
  static final Timetable _instance = Timetable._internal();

  factory Timetable() {
    return _instance;
  }

  Timetable._internal();

  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final List<String> timeSlots = [
    "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM",
  ];

  Map<String, List<String>> timetableData = {};

  void initialize() {
    timetableData = {
      'Monday': ['Math', 'English', 'Science', 'History', 'PE', 'Art', 'Music', 'Geography'],
      'Tuesday': ['History', 'Math', 'Biology', 'Chemistry', 'Art', 'PE', 'Physics', 'Literature'],
      'Wednesday': ['Chemistry', 'PE', 'Math', 'History', 'Physics', 'Biology', 'English', 'Art'],
      'Thursday': ['Physics', 'Biology', 'English', 'Math', 'Art', 'Chemistry', 'Music', 'History'],
      'Friday': ['Music', 'History', 'PE', 'Math', 'English', 'Biology', 'Chemistry', 'Geography'],
    };
  }

  void editSubject(String day, int index, String newSubject) {
    if (timetableData[day] != null && index >= 0 && index < timetableData[day]!.length) {
      timetableData[day]![index] = newSubject;
    }
  }

  void markSubjectAsNA(String day, int index) {
    if (timetableData[day] != null && index >= 0 && index < timetableData[day]!.length) {
      timetableData[day]![index] = 'N/A';
    }
  }
}

class TimetablePreviewScreen extends StatefulWidget {
  @override
  _TimetablePreviewScreenState createState() => _TimetablePreviewScreenState();
}

class _TimetablePreviewScreenState extends State<TimetablePreviewScreen> {
  final Timetable timetable = Timetable();
  TextEditingController _subjectController = TextEditingController();
  String? _selectedDay;
  int? _selectedIndex;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    timetable.initialize();
  }

  // Function to handle editing
  void _editSubject(String day, int index) {
    if (_isEditing) {
      _subjectController.text = timetable.timetableData[day]![index]; // Pre-fill the subject
      _selectedDay = day;
      _selectedIndex = index;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Subject'),
            content: TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_selectedDay != null && _selectedIndex != null) {
                    timetable.editSubject(_selectedDay!, _selectedIndex!, _subjectController.text);
                    setState(() {}); // Update UI
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to mark subject as N/A
  void _markSubjectAsNA(String day, int index) {
    timetable.markSubjectAsNA(day, index);
    setState(() {}); // Update UI
  }

  // Toggle editing mode
  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable Preview'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView( // Wrap the entire body inside SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Table(
                border: TableBorder.all(color: Colors.blueAccent),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Time', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      for (var day in timetable.days)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(day, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                    ],
                  ),
                  for (int i = 0; i < timetable.timeSlots.length; i++)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(timetable.timeSlots[i], style: TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                        for (var day in timetable.days)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Mark as N/A button
                                IconButton(
                                  icon: Icon(Icons.clear, size: 20, color: Colors.red),
                                  onPressed: () => _markSubjectAsNA(day, i),
                                ),
                                _isEditing
                                    ? GestureDetector(
                                  onTap: () => _editSubject(day, i),
                                  child: Text(
                                    timetable.timetableData[day] != null &&
                                        timetable.timetableData[day]!.length > i
                                        ? timetable.timetableData[day]![i]
                                        : 'N/A',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                )
                                    : Text(
                                  timetable.timetableData[day] != null &&
                                      timetable.timetableData[day]!.length > i
                                      ? timetable.timetableData[day]![i]
                                      : 'N/A',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 250,
                    child: ElevatedButton(
                      onPressed: _toggleEditing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: Text(_isEditing ? 'Close Edit' : 'Edit Timetable'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Delete Timetable'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _generateAndExportPDF(timetable, context); // Pass context to use for SnackBar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Export Timetable'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to generate the PDF and save it
  void _generateAndExportPDF(Timetable timetable, BuildContext context) async {
    final pdf = pw.Document();

    // Adding title to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Weekly Timetable', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Time', ...timetable.days],
                data: List.generate(timetable.timeSlots.length, (i) {
                  return [
                    timetable.timeSlots[i],
                    ...timetable.days.map((day) {
                      var subject = timetable.timetableData[day]?[i];
                      return subject ?? 'N/A'; // Null-safe check
                    }).toList(),
                  ];
                }),
              ),
            ],
          );
        },
      ),
    );

    // Get the application directory depending on platform
    Directory directory;
    if (Platform.isAndroid || Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError("This platform is not supported.");
    }

    final outputPath = '${directory.path}/timetable.pdf';
    final outputFile = File(outputPath);

    // Save the PDF to the file
    await outputFile.writeAsBytes(await pdf.save());

    // Show success message with the file path
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF exported to: $outputPath'),
    ));
  }
}
