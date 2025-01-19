import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/classNameModel/class_name_model.dart';
import 'package:school/data/models/student_model/student_model.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this); // 7 tabs for the 7 fee types
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

    // Filter students based on selected filters
    // List<StudentModel> filteredStudents = _filterStudents(studentData);

    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Fee"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Tuition Fee"),
            Tab(text: "Admission Fee"),
            Tab(text: "Transport Fee"),
            Tab(text: "Lab Fee"),
            Tab(text: "Sports Fee"),
            Tab(text: "Fine"),
            Tab(text: "Other"),
          ],
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
                    // Reset the filters to default values
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
              children: [
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),
                _buildAdmissionFeeTab(),


                // _buildFeeTab(filteredStudents, "Other"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildFeeTab(List<StudentModel> students, String feeType) {
  //   return ValueListenableBuilder(
  //     valueListenable: Boxes.getStudents().listenable(),
  //     builder: (context, value, child) {
  //       List<StudentModel> filteredStudents = _filterStudents(students);
  //       if (filteredStudents.isEmpty) {
  //         return Center(child: Text("No students found with the selected filters."));
  //       }
  //
  //       return ListView.builder(
  //         itemCount: filteredStudents.length,
  //         itemBuilder: (context, index) {
  //           final student = filteredStudents[index];
  //
  //           // Retrieve class data and fee information
  //           ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
  //               .getClassByID(student.classID.toString());
  //           String classFee = Provider.of<FeeProvider>(context)
  //               .getAdmissionFeeByClass(student.classID.toString())
  //               .toString();
  //
  //           return GestureDetector(
  //             onTap: () {
  //               Provider.of<FeeProvider>(context, listen: false).generateFeeForSingleStudent(
  //                   student.studentId ?? "", feeType, double.parse(classFee), "June");
  //             },
  //             child: Card(
  //               elevation: 4,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   SizedBox(width: 30),
  //                   Expanded(flex: 1, child: Text(student.studentId.toString())),
  //                   SizedBox(width: 30),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text("${student.firstName} ${student.lastName}"),
  //                   ),
  //                   Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
  //                   Expanded(flex: 1, child: Text(classFee)),
  //                   SizedBox(width: 30),
  //                   ElevatedButton(onPressed: () {}, child: Text("Generate Fee")),
  //                   SizedBox(width: 30),
  //                   PopupMenuButton(itemBuilder: (context) {
  //                     return [
  //                       PopupMenuItem(
  //                         child: ListTile(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                             showFeeDialog("${student.firstName} ${student.lastName}");
  //                           },
  //                           title: Text("Add New Fee"),
  //                           trailing: Icon(FontAwesomeIcons.plus),
  //                         ),
  //                       ),
  //                     ];
  //                   }),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  // Widget _buildIt(List<StudentModel> students, String feeType){
  //   return Consumer<FeeProvider>(
  //     builder: (BuildContext context, value, Widget? child) {
  //       List<StudentModel> filteredStudents = _filterStudents(students);
  //       // if (filteredStudents.isEmpty) {
  //       //   return Center(
  //       //       child: Text("No students found with the selected filters."));
  //       // }
  //
  //       return FutureBuilder(future: value.getStudentsWithUnGeneratedFeeForYearAndMonth(2025, "January"),
  //         builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {
  //
  //
  //         if(!snapshot.hasData){
  //           return Text("No Student found");
  //         }
  //         return ListView.builder(
  //           itemCount: snapshot.data?.length??0,
  //           itemBuilder: (context, index) {
  //             final student = filteredStudents[index];
  //
  //             // Retrieve class data and fee information
  //             ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
  //                 .getClassByID(student.classID.toString());
  //             String classFee = Provider.of<FeeProvider>(context)
  //                 .getTuitionFeeByClass(student.classID.toString())
  //                 .toString();
  //
  //             return GestureDetector(
  //               onTap: () {
  //                 Provider.of<FeeProvider>(context, listen: false).generateFeeForSingleStudent(
  //                     student.studentId ?? "", feeType, double.parse(classFee), "January");
  //               },
  //               child: Card(
  //                 elevation: 4,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     SizedBox(width: 30),
  //                     Expanded(flex: 1, child: Text(student.studentId.toString())),
  //                     SizedBox(width: 30),
  //                     Expanded(
  //                       flex: 2,
  //                       child: Text("${student.firstName} ${student.lastName}"),
  //                     ),
  //                     Expanded(flex: 1, child: Text(studentClass?.className.toString() ?? "")),
  //                     Expanded(flex: 1, child: Text(classFee)),
  //                     SizedBox(width: 30),
  //                     ElevatedButton(onPressed: () {}, child: Text("Generate Fee")),
  //                     SizedBox(width: 30),
  //                     PopupMenuButton(itemBuilder: (context) {
  //                       return [
  //                         PopupMenuItem(
  //                           child: ListTile(
  //                             onTap: () {
  //                               Navigator.pop(context);
  //                               showFeeDialog("${student.firstName} ${student.lastName}");
  //                             },
  //                             title: Text("Add New Fee"),
  //                             trailing: Icon(FontAwesomeIcons.plus),
  //                           ),
  //                         ),
  //                       ];
  //                     }),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //
  //         },
  //       );
  //     },
  //   );
  // }
  Widget _buildAdmissionFeeTab(){
    final studentProvider = Provider.of<StudentProvider>(context);
    return Consumer<FeeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        // if (filteredStudents.isEmpty) {
        //   return Center(
        //       child: Text("No students found with the selected filters."));
        // }

        return FutureBuilder(future: value.getStudentsWithUnGeneratedAdmissionFee(studentProvider),
          builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {


            if(snapshot.data?.isEmpty??false){
              return Text("No Student found");
            }
            return ListView.builder(
              itemCount: snapshot.data?.length??0,
              itemBuilder: (context, index) {
                final student = snapshot.data![index];

                // Retrieve class data and fee information
                ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context)
                    .getClassByID(student.classID.toString());
                String classFee = Provider.of<FeeProvider>(context)
                    .getAdmissionFeeByClass(student.classID.toString())
                    .toString();
               final feeProvider=  Provider.of<FeeProvider>(context, listen: false);


                return GestureDetector(
       onTap: (){
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
                        ElevatedButton(onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("It should generate and export fee slip pdf")));

                          ///It should add the fee to the generated fee list by student ID
                          /// It should add this amount to fee receivable ... i-e debit the fee receivable and credit the fee T account
                          ///
                        }, child: Text("Generate Fee")),
                        SizedBox(width: 30),
                        PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  // showFeeDialog("${student.firstName} ${student.lastName}");
                                },
                                title: Text("Add New Fee"),
                                trailing: Icon(FontAwesomeIcons.plus),
                              ),
                            ),
                          ];
                        }),
                      ],
                    ),
                  ),
                );
              },
            );

          },
        );
      },
    );
  }

  List<String> _getClassNames(List<StudentModel> students) {
    return students
        .map((student) => Provider.of<ClassNameProvider>(context, listen: false)
        .getClassByID(student.classID.toString())?.className ?? "")
        .toSet()
        .toList();
  }

  // List<StudentModel> _filterStudents(List<StudentModel> students) {
  //   return students.where((student) {
  //     // Filter by class
  //     if (selectedClass != null && selectedClass!.isNotEmpty) {
  //       ClassNameModel? studentClass = Provider.of<ClassNameProvider>(context, listen: false)
  //           .getClassByID(student.classID.toString());
  //       if (studentClass?.className != selectedClass) {
  //         return false;
  //       }
  //     }
  //
  //     // Filter by search query (name or student ID)
  //     if (searchQuery.isNotEmpty) {
  //       String studentName = "${student.firstName} ${student.lastName}".toLowerCase();
  //       if (!studentName.contains(searchQuery.toLowerCase()) &&
  //           !student.studentId.toString().contains(searchQuery)) {
  //         return false;
  //       }
  //     }
  //
  //     return true;
  //   }).toList();
  // }

  // void showFeeDialog(String studentName) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       final feeProvider = Provider.of<FeeProvider>(context, listen: false);
  //       return SizedBox(
  //         height: 600,
  //         width: 500,
  //         child: AlertDialog(
  //           title: Text("Fee Generation for $studentName"),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextFormField(
  //                 decoration: InputDecoration(labelText: "Fee Details"),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Card(
  //                   elevation: 3,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(12.0),
  //                     child: DropdownButtonFormField<String>(
  //                       decoration: InputDecoration(
  //                         labelText: "Fee Type",
  //                         border: OutlineInputBorder(),
  //                       ),
  //                       value: feeProvider.selectedFeeType,
  //                       items: const [
  //                         DropdownMenuItem(value: "Not Specified", child: Text("Not Specified")),
  //                         DropdownMenuItem(value: "Admission Fee", child: Text("Admission Fee")),
  //                         DropdownMenuItem(value: "Tuition Fee", child: Text("Tuition Fee")),
  //                         DropdownMenuItem(value: "Lab Fee", child: Text("Lab Fee")),
  //                         DropdownMenuItem(value: "Sports Fee", child: Text("Sports Fee")),
  //                         DropdownMenuItem(value: "Transport Fee", child: Text("Transport Fee")),
  //                         DropdownMenuItem(value: "Fine", child: Text("Fine")),
  //                         DropdownMenuItem(value: "Other", child: Text("Other")),
  //                       ],
  //                       onChanged: (value) {
  //                         feeProvider.changeSelectedFeeType(value!);
  //                       },
  //                       validator: (value) {
  //                         if (value == 'Not Specified' || value == null || value.isEmpty) {
  //                           return 'Please select a Fee Type';
  //                         }
  //                         return null;
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               ElevatedButton(onPressed: () {}, child: Text("Create Fee"))
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
