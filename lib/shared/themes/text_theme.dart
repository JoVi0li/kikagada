import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextTheme theme() {
    return const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.w900),
      titleSmall: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.normal
      ),
    );
  }
}
