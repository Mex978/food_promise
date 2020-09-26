import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController textEditingControllerUser;
  TextEditingController textEditingControllerPass;

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
  ];

  @override
  void onInit() {
    textEditingControllerUser = TextEditingController();
    inputs[0]["controller"] = textEditingControllerUser;

    textEditingControllerPass = TextEditingController();
    inputs[1]["controller"] = textEditingControllerPass;
    super.onInit();
  }

  Future<bool> _signInFunction() async {
    final auth = Get.find<FirebaseAuth>();

    final email = textEditingControllerUser.text;
    final password = textEditingControllerPass.text;

    try {
      print(email);
      print(password);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('USER CREDENTIALS: $userCredential');
      return true;
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
      } else {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  onSignInPressed() async {
    final success = await _signInFunction();

    if (success) {
      Get.delete<LoginController>();
      Get.back();
      Get.to(HomeScreen());
      print("Sign in success");
    } else {
      print("Sign in failed");
    }
  }

  @override
  void onClose() {
    textEditingControllerUser?.dispose();
    textEditingControllerPass?.dispose();
    super.onClose();
  }
}
