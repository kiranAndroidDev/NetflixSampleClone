import 'package:flutter/material.dart';

const Color primary = Colors.black;
const Color primaryDark = Colors.black;
const Color accent = Colors.red;
class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    return Theme.of(context).copyWith(
        primaryColor: primary,
        accentColor: accent,
        splashColor: primary,
        scaffoldBackgroundColor: Colors.black,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54)
    );
  }
}