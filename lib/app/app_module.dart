import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/auth/auth_module.dart';
import 'package:food_promise/app/modules/home/home_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'shared/service/repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<FirebaseAuth>((i) => FirebaseAuth.instance),
        Bind<FirebaseFirestore>((i) => FirebaseFirestore.instance),
        Bind<Repository>((i) => Repository(client: i())),
        Bind<FoodPromiseController>((i) => FoodPromiseController()),
      ];

  @override
  Widget get bootstrap => FoodPromise();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (context, args) => Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        ModularRouter(
          '/login',
          module: AuthModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/home',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
