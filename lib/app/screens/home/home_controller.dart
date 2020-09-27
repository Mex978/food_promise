import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/models/promise_model.dart';
import 'package:food_promise/app/screens/login/login_screen.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/widgets/feedback_dialog_widget.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final loading = false.obs;
  final Repository _repository = Get.find();

  final promises = <Promise>[].obs;

  @override
  onInit() {
    print("---> on init <---");
    loadPromises();
  }

  loadPromises() async {
    loading.value = true;

    _repository.getPromises().then((list) {
      promises.clear();
      promises.addAll(list);
      loading.value = false;
    });
  }

  makePromise() async {
    final success = await _repository.createPromise();

    if (success)
      successDialog(
        "Success",
        "Promise created with success!",
      );
    else
      errorDialog(
        "Error",
        "Some error ocurred :(",
      );
  }

  signOut() async {
    final auth = Get.find<FirebaseAuth>();
    auth.signOut().then((value) => Get.offAll(LoginScreen()));
  }
}
