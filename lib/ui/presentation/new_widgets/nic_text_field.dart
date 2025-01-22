import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NicTextField extends StatefulWidget {
  TextEditingController controller ;
   NicTextField({super.key,required this.controller});

  @override
  State<NicTextField> createState() => _NicTextFieldState();
}

class _NicTextFieldState extends State<NicTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Adding a listener to manage the focus state
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
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
              // stylusHandwritingEnabled: true,
              decoration: InputDecoration(
                // labelText: "Enter N-I-C",
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                hintText: "National ID number",
                labelStyle: TextStyle(
                  color: _isFocused
                      ? Colors.blueAccent
                      : Colors.grey[600], // Adjust color based on focus
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(25), // Fully rounded border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25), // Fully rounded border
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.grey[100],  // Subtle background color
                isDense: true, // Compact input field
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,

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
