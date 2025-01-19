import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/id_provider.dart';
import 'package:school/businessLogic/providers/parent_provider.dart';
import 'package:school/data/models/parentModel/parent_model.dart';
import 'package:school/ui/presentation/new_widgets/nic_text_field.dart';
import '../new_widgets/custom_text_field.dart';
import '../new_widgets/email_custom_field.dart';

class AddParentScreen extends StatefulWidget {
  const AddParentScreen({super.key});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _parentIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _parentIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _nicController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final idProvider = Provider.of<IdProvider>(context, listen: false);
    idProvider.getParentID();
  }

  _clearFields() {
    _parentIdController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _nicController.clear();
    _phoneController.clear();
    _addressController.clear();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final idProvider = Provider.of<IdProvider>(context, listen: false);

      final parentData = ParentModel(
        parentId: idProvider.parentId,
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        nic: _nicController.text,
      );

      debugPrint("Attempting to submit the form with the following data:");
      debugPrint("Parent ID: ${parentData.parentId}");
      debugPrint("First Name: ${parentData.firstName}");
      debugPrint("Last Name: ${parentData.lastName}");
      debugPrint("Phone Number: ${parentData.phoneNumber}");
      debugPrint("Email: ${parentData.email}");
      debugPrint("NIC: ${parentData.nic}");

      try {
        // Attempt to submit parent data
        ParentProvider().enrollParent(parentData);
        idProvider.getStudentID();
        idProvider.generateParentID();
        _clearFields();

        // Show success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Parent Added Successfully")),
        );

        // Log success for backend developer
        debugPrint("Parent added successfully. Parent ID: ${parentData.parentId}");

      } catch (e) {
        // Handle failure and show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add parent: $e")),
        );

        // Log error for backend developer
        debugPrint("Error occurred while adding parent: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idProvider = Provider.of<IdProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Parent'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Card(
                      elevation: 6,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.purple[900], // Deep purple for contrast
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.badge,
                              color: Colors.white,
                            ), // Icon for visual appeal
                            const SizedBox(width: 8),
                            Text(
                              'Parent ID: ${idProvider.parentId}', // Replace this with dynamic value
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextfield(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                EmailCustomTextfield(controller: _emailController),
                const SizedBox(height: 5),
                NicTextField(controller: _nicController),
                const SizedBox(height: 5),
                CustomTextfield(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                CustomTextfield(
                  controller: _addressController,
                  labelText: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 26,
                      horizontal: 26,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add Parent',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
