import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/app_controller.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:food_promise/app/themes/dark_theme.dart';
import 'package:get/get.dart';

import 'screens/login/login_screen.dart';
import 'shared/service/repository.dart';

class FoodPromise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final _controller = Get.put(FoodPromiseController());

          return GestureDetector(
            onTap: () => FoodPromiseUtils.hideKeyboard(context),
            child: GetMaterialApp(
              title: 'Food Promise',
              theme: DarkTheme.theme,
              home: LoginScreen(),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
