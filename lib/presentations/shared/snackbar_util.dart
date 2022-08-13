import 'package:flutter/material.dart';

class SnackBarUtil {
  static void set(String message, BuildContext context, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: color,
      margin: const EdgeInsets.all(25),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
