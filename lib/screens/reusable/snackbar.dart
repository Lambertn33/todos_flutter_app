  import 'package:flutter/material.dart';

  void showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }