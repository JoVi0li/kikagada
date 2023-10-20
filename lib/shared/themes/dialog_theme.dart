import 'package:flutter/material.dart';

class CustomDialogTheme {
  static DialogTheme theme() {
    return const DialogTheme(
      backgroundColor: Color(0xFFFEFDF9),
      titleTextStyle: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color(0xFF020202),
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF020202),
      ),
    );
  }
}
