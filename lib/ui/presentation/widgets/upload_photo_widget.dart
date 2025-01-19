import 'package:flutter/material.dart';

class UploadPhotoWidget extends StatelessWidget {
  final String labelText;  // Label text for the widget
  final String? imagePath; // Path of the image (null means no image selected)

  UploadPhotoWidget({
    required this.labelText,
    this.imagePath,  // This will be null if no photo is selected
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(labelText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),

        // Display the image or placeholder
        GestureDetector(
          onTap: () {
            // Placeholder for image selection
            print('Tapped to upload photo');
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey[200], // Background color
            child: imagePath == null
                ? Icon(Icons.add_a_photo, size: 40, color: Colors.grey) // Placeholder icon
                : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath!,  // Show selected image if available
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
