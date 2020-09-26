import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'shared/service/repository.dart';

class FoodPromiseController extends GetxController {
  final isLogged = false.obs;

  _inject() {
    Get.put(FirebaseAuth.instance);
    Get.put(Repository(client: FirebaseFirestore.instance));
  }

  chekIsLogged() {
    final auth = Get.find<FirebaseAuth>();
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void onInit() {
    print(isLogged);
    _inject();
    chekIsLogged();
    super.onInit();
  }
}
