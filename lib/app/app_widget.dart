import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:food_promise/app/themes/dark_theme.dart';
import 'package:get/get.dart';

class FoodPromise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Promise',
      theme: DarkTheme.theme,
      home: HomeScreen(),
    );
  }
}
