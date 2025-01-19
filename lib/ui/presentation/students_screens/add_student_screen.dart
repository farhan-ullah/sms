import 'package:flutter/material.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/businessLogic/providers/id_provider.dart';
import 'package:school/businessLogic/providers/parent_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/data/models/parentModel/parent_model.dart';
import 'package:school/data/models/student_model/student_model.dart';
import 'package:provider/provider.dart';
import 'package:school/ui/presentation/new_widgets/email_custom_field.dart';
import 'package:school/ui/presentation/new_widgets/nic_text_field.dart';
import 'package:school/ui/presentation/widgets/parent_drop_down_menu.dart';
import '../../../data/models/feeModel/fee_model.dart';
import '../new_widgets/custom_text_field.dart';
import '../new_widgets/methods/build_app_bar.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/upload_photo_widget.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController admissionFeeController = TextEditingController();
  // final TextEditingController classNameController = TextEditingController();
  //to be removed
  final TextEditingController fatherFirstNameController =
      TextEditingController();
  final TextEditingController fatherLastNameController =
      TextEditingController();
  final TextEditingController referenceController = TextEditingController();

  final TextEditingController reasonOfLeavingController =
      TextEditingController();

  final TextEditingController fatherEmailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController previousSchoolController =
      TextEditingController();
  final TextEditingController admissionConcessionController =
      TextEditingController();
  final TextEditingController tuitionConcessionController =
      TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  final TextEditingController emergencyContactController =
      TextEditingController();

  final TextEditingController otherNoController = TextEditingController();
  final TextEditingController parentNICController = TextEditingController();

  final TextEditingController parentPhoneController = TextEditingController();

  final TextEditingController genderController = TextEditingController();
  //to be removed
  final TextEditingController dobController = TextEditingController();
  final TextEditingController admissionDateController = TextEditingController();

  //to be removed
  final TextEditingController dateOfAdmissionController =
      TextEditingController();
  //to be removed
  final TextEditingController rollNoController = TextEditingController();

  final TextEditingController placeOfBrithController = TextEditingController();
String? selectedClassID = "";
double? discountedTuitionFee;



  @override
  void initState() {
    super.initState();

    final idProvider = Provider.of<IdProvider>(context, listen: false);
    idProvider.getStudentID();
    idProvider.getParentID();
  }

  // TextEditingController firstNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassNameProvider>(context);
    final idProvider = Provider.of<IdProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);
    // bool enableConcession = studentProvider.giveDiscount;

    bool parentToBeAdded = studentProvider.parentOption;
    final feeProvider = Provider.of<FeeProvider>(context);

    return Scaffold(
      appBar: buildAppbar("Enroll New Student"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // To avoid overflow issues on small screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group 1: Student Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Student Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color:
                        Colors
                            .blueGrey[800], // Slightly dark background for contrast
                    child: Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ), // More padding for better spacing
                      child: Row(
                        children: [
                          // Icon for better visual appeal (optional)
                          Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 12,
                          ), // Space between the icon and the text
                          // Text info styled properly
                          Text(
                            'Student ID:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ), // Small space between the label and value
                          Text(
                            idProvider.studentId, // Student ID value
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Dual Columns
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(

                      labelText: 'First Name',
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Last Name',
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      controller: dobController,
                      labelText: 'Date of Birth',
                      onDateSelected: (selectedDate) {
                        print("Selected Date: $selectedDate");
                        dobController.text = selectedDate;
                        // You can pass this date to a method if needed.
                      },
                    ),
                  ),

                  Expanded(
                    child: CustomDatePicker(
                      controller: admissionDateController,
                      labelText: 'Date of Admission',
                      onDateSelected: (selectedDate) {
                        print("Selected Admission Date: $selectedDate");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Place of Birth',
                      controller: placeOfBrithController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Date of Admission',
                      controller: dateOfAdmissionController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Emergency Contact Number',
                      controller: emergencyContactController,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              CustomTextfield(
                labelText: 'Home and Street Address',
                controller: addressController,
              ),

              UploadPhotoWidget(labelText: "Upload photo"), const Divider(),
              SizedBox(height: 20),

              // Group 2: Parent/Guardian Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Parent/Guardian Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 35),
                  Consumer<StudentProvider>(
                    builder: (context, studentProvider, child) {
                      return Row(
                        children: [
                          const Text("Parents already added?"),
                          Switch(
                            value: studentProvider.parentOption,
                            onChanged: (value) {
                              studentProvider.changeParentSetting();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  studentProvider.parentOption
                      ? SizedBox() // When parent is added, nothing here
                      : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SearchAndSelectParent(), // Your custom widget for searching and selecting a parent
                    ),
                  ),
                  studentProvider.parentOption
                      ? Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.blueGrey[800],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          const Text(
                            'Parent ID :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            idProvider.parentId, // Parent ID dynamically fetched
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : SizedBox(),
                ],
              ),
              parentToBeAdded ? const SizedBox(height: 10) : SizedBox(),
              parentToBeAdded
                  ? Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          labelText: 'Father/Guardian First Name',
                          controller: fatherFirstNameController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextfield(
                          labelText: 'Father/Guardian Last Name',
                          controller: fatherLastNameController,
                        ),
                      ),
                    ],
                  )
                  : SizedBox(),
              const SizedBox(height: 10),
              parentToBeAdded
                  ? Row(
                    children: [
                      parentToBeAdded
                          ? Expanded(
                            child: EmailCustomTextfield(controller: fatherEmailController),
                          )
                          : SizedBox(),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextfield(
                          labelText: 'Phone No',
                          controller: parentPhoneController,
                        ),
                      ),
                    ],
                  )
                  : SizedBox(),
              const SizedBox(height: 10),
              parentToBeAdded
                  ? Row(
                    children: [
                      Expanded(
                        child: NicTextField(controller: parentNICController),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextfield(
                          labelText: 'Replace',
                          controller: rollNoController,
                        ),
                      ),
                    ],
                  )
                  : SizedBox(),
              const SizedBox(height: 10),
              parentToBeAdded
                  ? Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          labelText: 'Other Phone No',
                          controller: otherNoController,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                  : SizedBox(),
              const Divider(),
              const SizedBox(height: 20),

              // Group 3: Additional Info
              const Text(
                "Academic Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Consumer<ClassNameProvider>(
                        builder: (context, classProvider, child) {
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Class Name",
                              border: OutlineInputBorder(),
                            ),
                            value: classProvider.selectedClass == "No Class Selected"
                                ? null
                                : classProvider.selectedClass, // Set selected value

                            items: classProvider.mockClassList.map<DropdownMenuItem<String>>((classItem) {
                              return DropdownMenuItem<String>(
                                value: classItem.classID, // Set the value to classItem.classID
                                child: Text(
                                  '${classItem.classID} - ${classItem.classID}', // Display classID and className together
                                ),
                              );
                            }).toList(),

                            onChanged: (String? value) {
                              print(classProvider.selectedClass);

                              // Update the provider when the user selects a value
                              if (value != null) {
                                selectedClassID=value;
                                classProvider.changeCLassName(value); // Update selectedClass in provider
                                feeProvider.getAdmissionFeeByClass(classProvider.selectedClass);
                              }
                            },

                            validator: (value) {
                              print(classProvider.selectedClass);
                              if (value == null || value.isEmpty) {
                                return 'Please select a Class';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Replace',
                      controller: parentNICController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Roll No',
                      controller: rollNoController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Previous School Name',
                      controller: previousSchoolController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Reason for Leaving',
                      controller: reasonOfLeavingController,
                    ),
                  ),
                ],
              ),
              CustomTextfield(
                labelText: 'Reference',
                controller: previousSchoolController,
              ),
              const Divider(),
              const SizedBox(height: 20),

              // Group 4: Payment Info
              const Text(
                "Group 4: Payment Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Consumer<FeeProvider>(
                builder: (context, feeProvider, child) {
                  double getAdmissionFeeByClass = feeProvider
                      .getAdmissionFeeByClass(selectedClassID.toString());
                  double getTuitionFeeByClass = feeProvider
                      .getTuitionFeeByClass(selectedClassID.toString());
                  print("Admission Fee: $getAdmissionFeeByClass");
                  print("Tuition Fee: $getTuitionFeeByClass");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      SizedBox(
                        width: 250,
                        child: Text(
                          "Admission Fee : $getAdmissionFeeByClass ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 250,
                        child: Text(
                          "Tuition Fee : ${studentProvider.giveDiscount
                              ? (concessionController.text.isEmpty
                              ? feeProvider.getTuitionFeeByClass(selectedClassID.toString())
                              : discountedTuitionFee ?? feeProvider.getTuitionFeeByClass(selectedClassID.toString()))
                              : feeProvider.getTuitionFeeByClass(selectedClassID.toString())}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Tuition Fee',
                      controller: fatherEmailController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      labelText: 'Discount in Fee',
                      controller: fatherEmailController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFeeConcessionToggle(studentProvider, feeProvider),
              Consumer<StudentProvider>(
                builder: (context, studentProvider, child) {
                  String generatedStudentID = idProvider.studentId;
                  final parentProvider = Provider.of<ParentProvider>(context);
                  String parent;
                  parentToBeAdded
                      ? parent = idProvider.parentId
                      : parent = parentProvider.preParentId.toString();
                  return ElevatedButton(
                    onPressed: () async {
                      FeeModel admissionFee = FeeModel(
                        feeType: "Admission",  // Type of fee
                        feeName: "Admission Fee",  // Name of the fee
                        createdFeeAmount: feeProvider.getAdmissionFeeByClass(IdProvider().classId),  // Set the fee amount (you should define admissionFeeAmount)
                        isFullyPaid: false,  // Assuming it's not paid yet
                        dueDate: "2025-01-15",  // Set the due date
                        feeDescription: "Initial admission fee for the student",  // Fee description
                        feeMonth: "January",  // Fee month
                        feeArrears: 0.0,  // No arrears initially
                        generatedFeeAmount: 0,  // Same as created fee amount initially
                      );

                      StudentModel studentData = StudentModel(
                        parentId: parent,
                        firstName: firstNameController.text,
                        classID: classProvider.selectedClass,
                        lastName: lastNameController.text,
                        studentId: generatedStudentID,
                        otherPhoneNo: otherNoController.text,
                        previousSchoolName: previousSchoolController.text,
                        gender: "female",
                        dateOfAdmission: dateOfAdmissionController.text,
                        placeOfBirth: placeOfBrithController.text,
                        dateOfBirth: dobController.text,
                        reasonOfLeaving: reasonOfLeavingController.text,
                        completeAddress: addressController.text,
                        emergencyContactNo: emergencyContactController.text,
                        reference: referenceController.text,
                        rollNo: rollNoController.text,
                        section: sectionController.text,
                        studentAllFeeTypes: {},//this
                        photoLink: "",
                        concessionInPercent: !feeProvider.isConcessionInRupees
                            ? double.tryParse(concessionController.text) ?? 0.0
                            : null, // Set it as null when it's not in percentage.
                        concessionInPKR: feeProvider.isConcessionInRupees
                            ? double.tryParse(concessionController.text) ?? 0.0
                            : null, // Set it as null when it's not in PKR.

                      );

                      ParentModel parentData = ParentModel(
                        parentId: idProvider.parentId,
                        lastName: fatherLastNameController.text,
                        firstName: fatherFirstNameController.text,
                        phoneNumber: parentPhoneController.text,
                        email: fatherEmailController.text,
                        nic: parentNICController.text,
                      );

                      try {
                        studentProvider.enrollStudent(studentData, parentData,studentProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Student Accepted Successfully"),
                          ),
                        );
                        idProvider.getStudentID();
                        idProvider.generateStudentID();
                        parentToBeAdded?idProvider.generateParentID():null;
                        classProvider.addStudentToAClass(selectedClassID??"",generatedStudentID);///how to pass classID instead of className
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                      parentProvider.addChildToParent(
                        generatedStudentID,
                        parent,
                      );
                    },
                    child: const Text('Add Student'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFeeConcessionToggle(StudentProvider studentProvider, FeeProvider feeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fee Concession Checkbox
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.blueGrey[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Enable Fee Concession",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Checkbox(
                  value: studentProvider.giveDiscount,
                  onChanged: (value) {
                    studentProvider.onOffDiscount(value ?? false); // Toggle the concession status
                    if (value == false) {
                      // Reset values when the discount is turned off
                      concessionController.clear();
                      setState(() {
                        discountedTuitionFee = null;
                      });
                    }
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Only show the Concession Type and Value Input if Fee Concession is enabled
        if (studentProvider.giveDiscount) ...[
          // Concession Type Toggle (Rupees vs Percentage)
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey[50],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    "Concession Type: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ToggleButtons(
                    isSelected: [feeProvider.isConcessionInRupees, !feeProvider.isConcessionInRupees],
                    onPressed: (int index) {
                      feeProvider.toggleConcessionType(index == 0); // Toggle between Rupees and Percentage

                      // Clear the previous value when toggling between types
                      concessionController.clear(); // This clears the value in the TextField
                      setState(() {
                        discountedTuitionFee = null; // Reset discounted fee until new value is entered
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    selectedColor: Colors.white,
                    fillColor: Colors.blueAccent,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Concession in PKR"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Concession in %"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Concession Value TextField
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey[50],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: TextField(
                controller: concessionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Concession Value',
                  hintText: feeProvider.isConcessionInRupees ? 'PKR Amount' : '% Value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      if (feeProvider.isConcessionInRupees) {
                        // Apply direct deduction in PKR (use null-aware operators)
                        discountedTuitionFee = (feeProvider.getTuitionFeeByClass(selectedClassID.toString()) ?? 0.0) -
                            (double.tryParse(value) ?? 0.0);
                      } else {
                        // Apply percentage deduction
                        discountedTuitionFee = applyPercentageDiscount(
                          feeProvider.getTuitionFeeByClass(selectedClassID.toString()) ?? 0.0,
                          double.tryParse(value) ?? 0.0,
                        );
                      }
                    });
                  } else {
                    setState(() {
                      discountedTuitionFee = null; // Reset discounted fee if input is cleared
                    });
                  }
                },
              ),
            ),
          ),
        ],

        const SizedBox(height: 20),

      ],
    );
  }

// This function applies a percentage discount to the fee
  double applyPercentageDiscount(double originalFee, double percentage) {
    return originalFee - (originalFee * (percentage / 100));
  }


TextEditingController concessionController= TextEditingController();
}
