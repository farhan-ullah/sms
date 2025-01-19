import 'dart:io';

import 'package:flutter/material.dart';

AppBar buildAppbar(String pageName) {
  return AppBar(
    title: Row(
      children: [
        Expanded(child:  Text(pageName)),
        Text("Admin "),
        Icon(Icons.logout),



      ],
    ),
    backgroundColor: Colors.deepPurple,
  );
}
