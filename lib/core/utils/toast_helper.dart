import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void showToast(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      // SHORT or LONG
      gravity: gravity,
      // BOTTOM, CENTER, TOP
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Show an error toast message
  static void showErrorToast(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // SHORT or LONG
      gravity: gravity, // BOTTOM, CENTER, TOP
      backgroundColor: Colors.red[800], // Dark red background for errors
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
