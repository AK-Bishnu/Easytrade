import 'package:flutter/material.dart';

class ErrorHandler {

  static void show(BuildContext context, Object error) {
    final message = error.toString().replaceFirst("Exception: ", "");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

}