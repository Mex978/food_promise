import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/app_controller.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:food_promise/app/themes/dark_theme.dart';
import 'package:asuka/asuka.dart' as asuka;

class FoodPromise extends StatefulWidget {
  @override
  _FoodPromiseState createState() => _FoodPromiseState();
}

class _FoodPromiseState extends State<FoodPromise> {
  final controller = Modular.get<FoodPromiseController>();
  StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();

    _subscription = controller.isLogged.listen((value) {
      _subscription.cancel();
      if (value) {
        Modular.link.pushNamed('/home');
      } else {
        Modular.to.pushNamed('/login');
      }
    });
  }

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
          controller.chekIsLogged();
        }

        return GestureDetector(
          onTap: () => FoodPromiseUtils.hideKeyboard(context),
          child: MaterialApp(
            builder: asuka.builder,
            title: 'Food Promise',
            theme: DarkTheme.theme,
            initialRoute: Modular.initialRoute,
            navigatorKey: Modular.navigatorKey,
            onGenerateRoute: Modular.generateRoute,
          ),
        );
      },
    );
  }
}
