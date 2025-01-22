import 'package:flutter/material.dart';

class EmailCustomTextfield extends StatefulWidget {
  final TextEditingController controller;

  const EmailCustomTextfield({
    required this.controller,
    super.key,
  });

  @override
  State<EmailCustomTextfield> createState() => _EmailCustomTextfieldState();
}

class _EmailCustomTextfieldState extends State<EmailCustomTextfield> {
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
    return SizedBox(height: 90,

      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.topLeft,

              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              autofocus: true,
              // stylusHandwritingEnabled: true,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                  // labelText: "Email",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },    ),
          ),
        ],
      ),
    );
  }
}
