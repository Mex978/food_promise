import 'package:flutter/material.dart';

class DarkTheme {
  static const primaryColor = Color(0xFF494A68);
  // static const secondaryColor = Color(0xFF494A68);

  static final ThemeData theme = ThemeData(
      primaryColor: primaryColor,
      accentColor: Colors.white,
      canvasColor: Color(0xFF424361),
      indicatorColor: Colors.white,
      accentColorBrightness: Brightness.dark,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Color(0xFF424361));
}
