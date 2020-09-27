import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorDialog(String title, String message) {
  Get.snackbar(
    title,
    message,
    forwardAnimationCurve: Curves.ease,
    reverseAnimationCurve: Curves.ease,
    backgroundColor: Colors.red[600],
    colorText: Colors.white,
    icon: Icon(Icons.error),
  );
}

successDialog(String title, String message) {
  Get.snackbar(
    title,
    message,
    forwardAnimationCurve: Curves.ease,
    reverseAnimationCurve: Curves.ease,
    backgroundColor: Colors.green[600],
    colorText: Colors.white,
    icon: Icon(Icons.check_circle),
  );
}
