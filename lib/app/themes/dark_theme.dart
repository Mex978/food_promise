import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static const primaryColor = Color(0xFF494A68);
  static const secondaryColor = Color(0xFF424361);

  static final ThemeData theme = ThemeData(
    accentColor: Colors.white,
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    canvasColor: secondaryColor,
    fontFamily: GoogleFonts.openSans().fontFamily,
    indicatorColor: Colors.white,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: secondaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
