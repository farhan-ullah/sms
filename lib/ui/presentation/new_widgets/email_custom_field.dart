import 'package:flutter/material.dart';

class EmailCustomTextfield extends StatelessWidget {
  final TextEditingController controller;

  const EmailCustomTextfield({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 80,

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
              stylusHandwritingEnabled: true,
              decoration: InputDecoration(
                hintText: 'Enter Email',
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
