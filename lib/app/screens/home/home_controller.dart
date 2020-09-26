import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/models/promise_model.dart';
import 'package:food_promise/app/shared/service/repository.dart';
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
      Get.snackbar(
        "Success",
        "Promise created with success!",
        backgroundColor: Colors.green[600],
        colorText: Colors.white,
        icon: Icon(Icons.check_circle),
      );
    else
      Get.snackbar(
        "Error",
        "Some error ocurred :(",
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        icon: Icon(Icons.error),
      );
  }
}
