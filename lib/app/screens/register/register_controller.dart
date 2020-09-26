import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController textEditingControllerUser;
  TextEditingController textEditingControllerPass;
  TextEditingController textEditingControllerRePass;

  final List<dynamic> inputs = [
    {
      "label": "E-mail",
      "obscure": false,
      "focusNode": FocusNode(),
    },
    {
      "label": "Password",
      "obscure": true,
      "focusNode": FocusNode(),
    },
    {
      "label": "Re-Password",
      "obscure": true,
      "focusNode": FocusNode(),
    },
  ];

  @override
  void onInit() {
    textEditingControllerUser = TextEditingController();
    textEditingControllerPass = TextEditingController();
    textEditingControllerRePass = TextEditingController();
    super.onInit();
  }

  Future<bool> _signUpFunction() async {
    final auth = Get.find<FirebaseAuth>();

    final email = textEditingControllerUser.text;
    final password = textEditingControllerPass.text;
    final re_password = textEditingControllerRePass.text;

    try {
      if (re_password == password) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar(
          'Error',
          'The passwords don\'t match',
          backgroundColor: Colors.red[600],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'The password provided is too weak.',
          backgroundColor: Colors.red[600],
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'The account already exists for that email.',
          backgroundColor: Colors.red[600],
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error',
          'The email provided is invalid',
          backgroundColor: Colors.red[600],
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  onSignUpPressed() async {
    final success = await _signUpFunction();

    if (success) {
      Get.delete<LoginController>();
      Get.back();
      Get.to(HomeScreen());
    }
    print("Sign Up");
  }

  @override
  void onClose() {
    textEditingControllerUser?.dispose();
    textEditingControllerPass?.dispose();
    textEditingControllerRePass?.dispose();
    super.onClose();
  }
}
