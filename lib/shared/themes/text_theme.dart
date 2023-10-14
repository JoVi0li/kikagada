import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextTheme theme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 40,
        color: Color(0xFF594020),
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 20,
        color: Color(0xFF594C3B),
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 14,
        color: Color(0xFF020202),
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    );
  }
}
