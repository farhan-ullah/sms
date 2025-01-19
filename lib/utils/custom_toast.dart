import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class MyToast {
  void showToast(String msg, BuildContext context){
//Interactive toast, set [isIgnoring] false.
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        margin: EdgeInsets.symmetric(horizontal: 50.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.green[600],
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      context: context,

      isIgnoring: false,
      duration: Duration(seconds: 3),
    );  }
}