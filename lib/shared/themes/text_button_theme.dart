import 'package:flutter/material.dart';

class CustomTextButtonTheme {
  static TextButtonThemeData theme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFFEFDF9),
        side: const BorderSide(
          color: Color(0xFF020202),
          width: 1.5,
          style: BorderStyle.solid,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(100, 52),
      ),
    );
  }
}
