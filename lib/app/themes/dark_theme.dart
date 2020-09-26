import 'package:flutter/material.dart';

class DarkTheme {
  static const primaryColor = Color(0xFF494A68);
  static const secondaryColor = Color(0xFF424361);

  static final ThemeData theme = ThemeData(
    accentColor: Colors.white,
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    canvasColor: secondaryColor,
    indicatorColor: Colors.white,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: secondaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
