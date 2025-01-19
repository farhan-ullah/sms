import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NicTextField extends StatelessWidget {
  TextEditingController controller ;
   NicTextField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 90,
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.topLeft,

              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("NIC",style: TextStyle(fontWeight: FontWeight.bold),),
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              autofocus: true,
              stylusHandwritingEnabled: true,
              decoration: InputDecoration(
                hintText: 'Enter NIC',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],


                isDense: true,  // This reduces the height by making the field more compact
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,  // You can reduce this value to make the height smaller
                ),              ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,

              keyboardType: TextInputType.number,
              inputFormatters: [_formatter],
              validator: _validateInput,
            ),
          ),
        ],
      ),
    );
  }

}

// Regular expression to validate the input format
final _numberFormatRegex = RegExp(r'^\d{5}-\d{7}-\d{1}$');

// Formatter to insert dashes automatically
TextInputFormatter _formatter = TextInputFormatter.withFunction((oldValue, newValue) {
  String newText = newValue.text.replaceAll(RegExp(r'\D'), '');  // Remove non-digit characters

  // Limit the input to 13 characters
  if (newText.length > 13) {
    newText = newText.substring(0, 13);
  }

  if (newText.length > 5) {
    newText = newText.substring(0, 5) + '-' + newText.substring(5); // Add first dash
  }
  if (newText.length > 13) {
    newText = newText.substring(0, 13) + '-' + newText.substring(13); // Add second dash
  }

  return TextEditingValue(
    text: newText,
    selection: TextSelection.collapsed(offset: newText.length),
  );
});

// Validation function
String? _validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  if (!_numberFormatRegex.hasMatch(value)) {
    return 'Invalid format. Use: 16101-1234566-6';
  }
  return null;
}
