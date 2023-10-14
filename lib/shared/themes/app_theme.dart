import 'package:flutter/material.dart';
import 'package:kikagada/shared/themes/app_bar_theme.dart';
import 'package:kikagada/shared/themes/color_theme.dart';
import 'package:kikagada/shared/themes/dialog_theme.dart';
import 'package:kikagada/shared/themes/text_button_theme.dart';
import 'package:kikagada/shared/themes/text_theme.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      colorScheme: CustomColorTheme.theme(),
      scaffoldBackgroundColor: const Color(0xFF402319),
      useMaterial3: true,
      textTheme: CustomTextTheme.theme(),
      appBarTheme: CustomAppBarTheme.theme(),
      dialogTheme: CustomDialogTheme.theme(),
      textButtonTheme: CustomTextButtonTheme.theme(),
    );
  }
}
