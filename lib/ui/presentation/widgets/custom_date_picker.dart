import 'package:flutter/material.dart';
import 'package:school/ui/presentation/new_widgets/custom_text_field.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(String) onDateSelected;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show the date picker
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          // Format the selected date as a string (yyyy-MM-dd)
          String formattedDate = "${selectedDate.toLocal()}".split(' ')[0];

          // Set the selected date to the TextEditingController
          controller.text = formattedDate;

          // Pass the formatted date back to the parent widget
          onDateSelected(formattedDate);
        }
      },
      child: AbsorbPointer(
        child: CustomTextfield(labelText: labelText, controller: controller),
      ),
    );
  }
}
