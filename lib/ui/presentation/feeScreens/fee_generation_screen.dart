import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/classNameModel/class_name_model.dart';
import 'package:school/data/models/student_model/student_model.dart';
import '../../../data/models/fee_generation_receipt_model.dart';


class GenerateFeeScreen extends StatefulWidget {
  const GenerateFeeScreen({super.key});

  @override
  State<GenerateFeeScreen> createState() => _GenerateFeeScreenState();
}

class _GenerateFeeScreenState extends State<GenerateFeeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String? selectedClass;
  String? selectedFeeType;
  String? paymentStatus;
  String? dueDateFilter;
  String searchQuery = "";

  final Map<String, Receipt> studentReceipts = {}; // Map to store student receipts
  final List<String> feeTypes = [
    "Tuition Fee", "Admission Fee", "Transport Fee", "Lab Fee", "Sports Fee", "Fine", "Other"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: feeTypes.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);

    List<StudentModel> studentData = studentProvider.mockStudentList;

    // Apply the filters
    List<StudentModel> filteredStudents = _filterStudents(studentData);
    String selectedMonth = 'January';
    String selectedYear = '2025';

    // List of months and years for the dropdowns
    final List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final List<String> years = ['2025', '2024', '2023', '2022', '2021'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Fee"),
        bottom: TabBar(
          controller: _tabController,
          tabs: feeTypes.map((feeType) => Tab(text: feeType)).toList(),
        ),
      ),
      body: Column(
        children: [
          // Filter UI Section (Class, Fee Type, Payment Status, Due Date, Search)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Class'),
                    value: selectedClass,
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                    items: _getClassNames(studentData).map((className) {
                      return DropdownMenuItem<String>(
                        value: className,
                        child: Text(className),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Name or ID',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedClass = null;
                      selectedFeeType = null;
                      paymentStatus = null;
                      dueDateFilter = null;
                      searchQuery = "";
                    });
                  },
                  child: Text("Reset Filters"),
                ),
              ],
            ),
          ),
          // TabView displaying different fee types
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: feeTypes.map((feeType) {
                return _buildFeeTypeTab(filteredStudents, feeType, years, months, selectedYear, selectedMonth);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeTypeTab(List<StudentModel> filteredStudents, String feeType,List<String> years, List<String> months,String selectedYear, String selectedMonth) {
    switch (feeType) {
      case 'Tuition Fee':
        return _buildTuitionFeeTab(filteredStudents, selectedMonth, years, months, selectedYear);
      case 'Admission Fee':
        return _buildAdmissionFeeTab(filteredStudents, selectedYear, selectedMonth);
      case 'Transport Fee':
        return _buildTransportFeeTab(filteredStudents, years, months, selectedMonth, selectedYear);
      case 'Lab Fee':
        return _buildLabFeeTab(filteredStudents, selectedYear, selectedMonth);
      case 'Sports Fee':
        return _buildSportsFeeTab(filteredStudents, selectedYear, selectedMonth);
      case 'Fine':
        return _buildFineTab(filteredStudents, selectedYear, selectedMonth);
      case 'Other':
        return _buildOtherFeeTab(filteredStudents, selectedYear, selectedMonth);
      default:
        return Container();
    }
  }
  // Tuition Fee Tab

  Widget _buildTuitionFeeTab(List<StudentModel> filteredStudents, String selectedMonth, List<String> years, List<String> months, String selectedYear) {
    return Column(
      children: [
        // Month and Year Dropdowns at the top
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Month Dropdown
              DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
              ),
              SizedBox(width: 20),

              // Year Dropdown
              DropdownButton<String>(
                value: selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: years.map<DropdownMenuItem<String>>((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information (specifically for Tuition Fee)
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getTuitionFeeByClass(student.classID.toString())
                  .toString();  // Getting the Tuition Fee instead of Sports Fee

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button (For Tuition Fee)
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for Tuition Fee
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Tuition Fee",  // Fee type is set as "Tuition Fee"
                            feeAmount: double.parse(classFee),  // Store the tuition fee amount
                            paymentStatus: "Generated",  // Set the payment status as "Generated"
                            paymentDate: DateTime.now(),  // Store the current date as payment date
                            month: selectedMonth, // Store the selected month
                            year: selectedYear,  // Store the selected year
                          );

                          // Show a snack bar to notify the fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating tuition fee for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Tuition Fee"),
                      ),
                      SizedBox(width: 30),

                      // Print Button (only shows after fee is generated and feeType is "Tuition Fee")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Tuition Fee")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!); // Print the tuition fee receipt
                          },
                          child: Text("Print Tuition Fee Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Tuition Fee")));
            },
            child: Text("Generate All Fees for Tuition Fee"),
          ),
        ),
      ],
    );
  }

  Widget _buildAdmissionFeeTab(List<StudentModel> filteredStudents, String selectedYear, String selectedMonth) {
    return Column(
      children: [
        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information (specifically for Tuition Fee)
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getTuitionFeeByClass(student.classID.toString())
                  .toString();  // Getting the Tuition Fee instead of Sports Fee

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button (For Tuition Fee)
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for Tuition Fee
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Admission Fee",  // Fee type is set as "Tuition Fee"
                            feeAmount: double.parse(classFee),  // Store the tuition fee amount
                            paymentStatus: "Generated",  // Set the payment status as "Generated"
                            paymentDate: DateTime.now(), year: selectedYear,month: selectedMonth  // Store the current date as payment date
                          );

                          // Show a snack bar to notify the fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating Admission fee for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Admission Fee"),
                      ),
                      SizedBox(width: 30),

                      // Print Button (only shows after fee is generated and feeType is "Tuition Fee")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Admission Fee")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!); // Print the tuition fee receipt
                          },
                          child: Text("Print Admission Fee Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Lab Fee")));
            },
            child: Text("Generate All Fees for Lab Fee"),
          ),
        ),
      ],
    );
  }


  // Transport Fee Tab
  Widget _buildTransportFeeTab(List<StudentModel> filteredStudents,List<String> years,List<String> months, String selectedMonth, String selectedYear) {
    return Column(
      children: [
        // Month and Year Dropdowns at the top
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Month Dropdown
              DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
              ),
              SizedBox(width: 20),

              // Year Dropdown
              DropdownButton<String>(
                value: selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: years.map<DropdownMenuItem<String>>((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information (specifically for Transport Fee)
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getTransportFeeByClass(student.classID.toString())
                  .toString();  // Getting the Transport Fee instead of Tuition Fee

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button (For Transport Fee)
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for Transport Fee
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Transport Fee",  // Fee type is set as "Transport Fee"
                            feeAmount: double.parse(classFee),  // Store the transport fee amount
                            paymentStatus: "Generated",  // Set the payment status as "Generated"
                            paymentDate: DateTime.now(),  // Store the current date as payment date
                            month: selectedMonth, // Store the selected month
                            year: selectedYear,  // Store the selected year
                          );

                          // Show a snack bar to notify the fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating transport fee for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Transport Fee"),
                      ),
                      SizedBox(width: 30),

                      // Print Button (only shows after fee is generated and feeType is "Transport Fee")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Transport Fee")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!); // Print the transport fee receipt
                          },
                          child: Text("Print Transport Fee Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Transport Fee")));
            },
            child: Text("Generate All Fees for Transport Fee"),
          ),
        ),
      ],
    );
  }


  Widget _buildLabFeeTab(List<StudentModel> filteredStudents,String selectedYear, String selectedMonth) {
    return Column(
      children: [
        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information (specifically for Tuition Fee)
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getTuitionFeeByClass(student.classID.toString())
                  .toString();  // Getting the Tuition Fee instead of Sports Fee

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button (For Tuition Fee)
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for Tuition Fee
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Lab Fee",  // Fee type is set as "Tuition Fee"
                            feeAmount: double.parse(classFee),  // Store the tuition fee amount
                            paymentStatus: "Generated",  // Set the payment status as "Generated"
                            paymentDate: DateTime.now(), year: selectedYear,month: selectedMonth  // Store the current date as payment date
                          );

                          // Show a snack bar to notify the fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating Transport fee for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Lab Fee"),
                      ),
                      SizedBox(width: 30),

                      // Print Button (only shows after fee is generated and feeType is "Tuition Fee")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Lab Fee")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!); // Print the tuition fee receipt
                          },
                          child: Text("Print Lab Fee Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Lab Fee")));
            },
            child: Text("Generate All Fees for Lab Fee"),
          ),
        ),
      ],
    );
  }

  Widget _buildSportsFeeTab(List<StudentModel> filteredStudents,String selectedYear, String selectedMonth) {
    return Column(
      children: [
        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information (specifically for Tuition Fee)
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getSportsFeeByClass(student.classID.toString())
                  .toString();  // Getting the Tuition Fee instead of Sports Fee

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button (For Tuition Fee)
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for Tuition Fee
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Sports Fee",  // Fee type is set as "Tuition Fee"
                            feeAmount: double.parse(classFee),  // Store the tuition fee amount
                            paymentStatus: "Generated",  // Set the payment status as "Generated"
                            paymentDate: DateTime.now(), year: selectedYear,month: selectedMonth,  // Store the current date as payment date
                          );

                          // Show a snack bar to notify the fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating Sports fee for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Sports Fee"),
                      ),
                      SizedBox(width: 30),

                      // Print Button (only shows after fee is generated and feeType is "Tuition Fee")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Sports Fee")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!); // Print the tuition fee receipt
                          },
                          child: Text("Print Sports Fee Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Sports Fee")));
            },
            child: Text("Generate All Fees for Sports Fee"),
          ),
        ),
      ],
    );
  }

  Widget _buildFineTab(List<StudentModel> filteredStudents, String selectedYear, String selectedMonth) {
    return Column(
      children: [
        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fine information
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFine = Provider.of<FeeProvider>(context)
                  .getFineByClass(student.classID.toString())
                  .toString();

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation (optional)
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text("${student.firstName} ${student.lastName}"),
                      ),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFine)),
                      SizedBox(width: 30),

                      // Generate Fee Button
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details for the student in studentReceipts map
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Fine", // Set the fee type as Fine
                            feeAmount: double.parse(classFine), // Store the class fine
                            paymentStatus: "Generated", // Set the payment status as Generated
                            paymentDate: DateTime.now(), year: selectedYear,month: selectedMonth, // Store the current date as the payment date
                          );

                          // Show a snack bar to notify fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating fine for ${student.firstName}"),
                          ));

                          // Trigger UI update to show the print receipt button
                          setState(() {});
                        },
                        child: Text("Generate Fine"),
                      ),
                      SizedBox(width: 30),

                      // Print Receipt Button (only shows after the fine is generated and feeType is "Fine")
                      if (studentReceipts.containsKey(student.studentId.toString()) &&
                          studentReceipts[student.studentId.toString()]!.feeType == "Fine")
                        ElevatedButton(
                          onPressed: () {
                            _printReceipt(studentReceipts[student.studentId.toString()]!);
                          },
                          child: Text("Print Fine Receipt"),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Fine")));
            },
            child: Text("Generate All Fees for Fine"),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherFeeTab(List<StudentModel> filteredStudents, String selectedYear, String selectedMonth) {
    return Column(
      children: [
        // List of filtered students based on selected fee type
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              // Retrieve class data and fee information
              ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                  .getClassByID(student.classID.toString());
              String classFee = Provider.of<FeeProvider>(context)
                  .getOtherFeeByClass(student.classID.toString())
                  .toString();

              return GestureDetector(
                onTap: () {
                  // Handle individual fee generation if needed
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(flex: 1, child: Text(student.studentId.toString())),
                      SizedBox(width: 30),
                      Expanded(flex: 2, child: Text("${student.firstName} ${student.lastName}")),
                      Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
                      Expanded(flex: 1, child: Text(classFee)),
                      SizedBox(width: 30),

                      // Generate Fee Button
                      ElevatedButton(
                        onPressed: () {
                          // Store the receipt details
                          studentReceipts[student.studentId.toString()] = Receipt(
                            studentName: "${student.firstName} ${student.lastName}",
                            studentId: student.studentId.toString(),
                            className: studentClass?.className ?? '',
                            feeType: "Other", // You may change this based on the type
                            feeAmount: double.parse(classFee),
                            paymentStatus: "Generated",
                            paymentDate: DateTime.now(), year: selectedYear,month: selectedMonth,
                          );

                          // Show a snack bar for fee generation
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Generating fee for ${student.firstName}"),
                          ));
                          setState(() {}); // Trigger UI update to show the receipt button
                        },
                        child: Text("Generate Fee"),
                      ),
                      SizedBox(width: 30),

                      // Display the "Print Receipt" button if the fee has been generated
                      if (studentReceipts.containsKey(student.studentId.toString()))
                        if (studentReceipts[student.studentId.toString()]!.feeType == "Other")
                          ElevatedButton(
                            onPressed: () {
                              _printReceipt(studentReceipts[student.studentId.toString()]!);
                            },
                            child: Text("Print Other Fee Receipt"),
                          )
                        else if (studentReceipts[student.studentId.toString()]!.feeType == "library")
                          ElevatedButton(
                            onPressed: () {
                              _printReceipt(studentReceipts[student.studentId.toString()]!);
                            },
                            child: Text("Print Library Receipt"),
                          )
                        else
                          Container(), // Or any fallback widget for other cases
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Button to generate all fees for the current fee type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating all fees for Other")));
            },
            child: Text("Generate All Fees for Other"),
          ),
        ),
      ],
    );
  }


  List<String> _getClassNames(List<StudentModel> students) {
    return students
        .map((student) => Provider.of<ClassNameProvider>(context, listen: false)
        .getClassByID(student.classID.toString())?.className ?? "")
        .toSet()
        .toList();
  }

  List<StudentModel> _filterStudents(List<StudentModel> students) {
    return students.where((student) {
      // Filter by class
      if (selectedClass != null && selectedClass!.isNotEmpty) {
        ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context, listen: false)
            .getClassByID(student.classID.toString());
        if (studentClass?.className != selectedClass) {
          return false;
        }
      }

      // Filter by search query (name or student ID)
      if (searchQuery.isNotEmpty) {
        String studentName = "${student.firstName} ${student.lastName}".toLowerCase();
        if (!studentName.contains(searchQuery.toLowerCase()) &&
            !student.studentId.toString().contains(searchQuery)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _printReceipt(Receipt receipt) {
    // Here you can implement your print logic (PDF, file, etc.)
    print("Receipt for ${receipt.studentName}");
    print("Student ID: ${receipt.studentId}");
    print("Class: ${receipt.className}");
    print("Fee Type: ${receipt.feeType}");
    print("Fee Amount: ${receipt.feeAmount}");
    print("Payment Status: ${receipt.paymentStatus}");
    print("Payment Date: ${receipt.paymentDate}");
  }
}
