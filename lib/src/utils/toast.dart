import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class showToast{
  static Future<bool> displayToast(String message,Color messColor) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: messColor,
        textColor: Colors.white,
        fontSize: 16);
  }
}