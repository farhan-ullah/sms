import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/id_provider.dart';
import 'package:school/data/models/teacherModel/teacher_model.dart';
import 'package:school/ui/presentation/new_widgets/nic_text_field.dart';

import '../../../businessLogic/providers/teacher_provider.dart';
import '../new_widgets/custom_text_field.dart';
import '../new_widgets/email_custom_field.dart';
import '../widgets/custom_date_picker.dart'; // Make sure to import the CustomTextfield

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _subjectController = TextEditingController();
  final _nicController = TextEditingController();
  final _dateOfJoiningController = TextEditingController();
  final _salaryTierController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final idProvider = Provider.of<IdProvider>(context, listen: false);
    idProvider.generateTeacherID();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _qualificationController.dispose();
    _subjectController.dispose();
    _nicController.dispose();
    _dateOfJoiningController.dispose();
    _salaryTierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idProvider = Provider.of<IdProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Teacher'),
        actions: [
          Card(
            elevation: 10,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color:
                Colors.blueGrey[800], // Slightly dark background for contrast
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ), // More padding for better spacing
              child: Row(
                children: [
                  // Icon for better visual appeal (optional)
                  SizedBox(width: 12), // Space between the icon and the text
                  // Text info styled properly
                  Text(
                    'Teacher ID :',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 3), // Small space between the label and value
                  Text(
                    idProvider.teacherId, // Student ID value
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(key: _formKey,
          child: ListView(
            children: [
              // Teacher ID

              // First Name
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      validator: (value) {
                        if(value?.isEmpty??false){
                          return "Must Enter first Name";
                        }
                        return null;
                      },
                      labelText: 'First Name',
                      controller: _firstNameController,
                    ),
                  ),
                  Expanded(
                    child: CustomTextfield(
                      validator: (value) {
                        if(value?.isEmpty??false){
                          return "Must Enter last Name";
                        }
                        return null;
                      },

                      labelText: 'Last Name',
                      controller: _lastNameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      validator: (value) {
                        if(value?.isEmpty??false){
                          return "Must Enter Phone Number";
                        }
                        return null;
                      },

                      labelText: 'Phone Number',
                      controller: _phoneNumberController,
                    ),
                  ),

                  // Email
                  Expanded(
                    child: EmailCustomTextfield(controller: _emailController),
                  ),
                ],
              ),

              // Last Name

              // Phone Number
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      validator: (value) {
                        if(value?.isEmpty??false){
                          return "Must Enter a Qualification";
                        }
                        return null;
                      },

                      labelText: 'Qualification',
                      controller: _qualificationController,
                    ),
                  ),

                  // Subject
                  Expanded(
                    child: CustomTextfield(
                      validator: (value) {
                        if(value?.isEmpty??false){
                          return "Must Enter a Subject";
                        }
                        return null;
                      },

                      labelText: 'Subject',
                      controller: _subjectController,
                    ),
                  ),
                ],
              ),
              // Address
              CustomTextfield(
                validator: (value) {
                  if(value?.isEmpty??false){
                    return "Must Enter a Complete Address";
                  }
                  return null;
                },

                labelText: 'Address',
                controller: _addressController,
              ),

              // Qualification

              // NIC
              Row(
                children: [
                  Expanded(child: NicTextField(controller: _nicController)),

                  // Date of Joining
                  Expanded(
                    child: CustomDatePicker(
                      controller: _dateOfJoiningController,
                      labelText: 'Date of Joining',
                      onDateSelected: (selectedDate) {
                        print("Selected Date: $selectedDate");
                        _dateOfJoiningController.text = selectedDate;
                        // You can pass this date to a method if needed.
                      },
                    ),
                  ),
                ],
              ),

              // Salary Tier
              CustomTextfield(
                labelText: 'Salary Tier',
                controller: _salaryTierController,
              ),

              // Add Teacher Button
              ElevatedButton(
                onPressed: () {
                  String teacherID = idProvider.teacherId;
                  final teacherProvider = Provider.of<TeacherProvider>(
                    context,
                    listen: false,
                  );
                  TeacherModel teacherModel = TeacherModel(
                    dateOfJoining: _dateOfJoiningController.text,
                    qualification: _qualificationController.text,
                    salaryTier: _salaryTierController.text,
                    teacherAddress: _addressController.text,
                    teacherId: teacherID,
                    teacherFirstName: _firstNameController.text,
                    teacherLastName: _lastNameController.text,
                    teacherEmail: _emailController.text,
                    teacherNic: _nicController.text,
                    teacherPhoneNumber: _phoneNumberController.text,

                    // teacherSubject: _subjectController.text,
                  );

                  if(_formKey.currentState?.validate()??false){
                    teacherProvider.enrollTeacher(teacherModel);

                    // Show a success message after adding the teacher
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Teacher added successfully!')),

                    );
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _phoneNumberController.clear();
                    _emailController.clear();
                    _addressController.clear();
                    _qualificationController.clear();
                    _subjectController.clear();
                    _nicController.clear();
                    _dateOfJoiningController.clear();
                  }


                },
                child: const Text('Add Teacher'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Clear the text fields after submission
  void _clearFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    _addressController.clear();
    _qualificationController.clear();
    _subjectController.clear();
    _nicController.clear();
    _dateOfJoiningController.clear();
    _salaryTierController.clear();
  }
}
