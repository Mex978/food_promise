import 'package:flutter/material.dart';
import 'package:food_promise/app/app_widget.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:get/get.dart';

void main() {
  Get.put(Repository(client: null));

  runApp(FoodPromise());
}
