import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:food_promise/app/themes/dark_theme.dart';
import 'package:get/get.dart';

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
          Get.put(Repository(client: FirebaseFirestore.instance));

          return GetMaterialApp(
            title: 'Food Promise',
            theme: DarkTheme.theme,
            home: HomeScreen(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
