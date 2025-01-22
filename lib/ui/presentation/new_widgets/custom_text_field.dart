import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextfield({
    this.validator,
    required this.labelText,
    super.key,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,  // Increased height for better visual appeal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.labelText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600, // Slightly bolder for emphasis
                    color: _isFocused
                        ? Colors.blueAccent
                        : Colors.black.withOpacity(0.7), // Color change based on focus
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // More spacing between label and input field
            TextFormField(
              stylusHandwritingEnabled: true,

              controller: widget.controller,
              focusNode: _focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: true,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                hintText: widget.labelText,
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                // labelText: widget.labelText,
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
              validator: widget.validator,
            ),
          ],
        ),
      ),
    );
  }
}
