import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'shared/service/repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => FirebaseFirestore.instance),
        Bind((i) => Repository(client: i())),
        Bind((i) => FoodPromiseController()),
      ];

  @override
  Widget get bootstrap => FoodPromise();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (context, args) => CircularProgressIndicator(),
        ),
        ModularRouter(
          '/login',
          child: (context, args) => LoginScreen(),
        ),
        ModularRouter(
          '/home',
          child: (context, args) => HomeScreen(),
        ),
      ];
}
