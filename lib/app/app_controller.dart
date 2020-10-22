import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class FoodPromiseController extends GetxController {
  final isLogged = false.obs;

  void chekIsLogged() {
    final auth = Modular.get<FirebaseAuth>();

    if (auth.currentUser == null) {
      print('User is currently signed out!');
      isLogged.value = false;
    } else {
      print('User is signed in!');
      isLogged.value = true;
    }
  }
}
