import 'package:flutter/material.dart';

class SnackBarUtil {
  static void set(String message, BuildContext context, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      margin: const EdgeInsets.only(bottom: 50, left: 25, right: 25),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
