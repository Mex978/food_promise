import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:food_promise/app/shared/widgets/feedback_dialog_widget.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loading = false.obs;
  GlobalKey<FormState> formKey;
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
    formKey = GlobalKey<FormState>();

    textEditingControllerUser = TextEditingController();
    inputs[0]["controller"] = textEditingControllerUser;

    textEditingControllerPass = TextEditingController();
    inputs[1]["controller"] = textEditingControllerPass;
    super.onInit();
  }

  Future<bool> _signInFunction() async {
    loading.value = true;
    final auth = Get.find<FirebaseAuth>();

    final email = textEditingControllerUser.text;
    final password = textEditingControllerPass.text;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      loading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'weak-password') {
        errorDialog(
          'Error',
          'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        errorDialog(
          'Error',
          'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        errorDialog(
          'Error',
          'The email provided is invalid',
        );
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorDialog(
          'Error',
          'The email or password are wrong',
        );
      } else {
        print(e.toString());
      }
    } catch (e) {
      loading.value = false;
      errorDialog(
        'Error',
        e.toString(),
      );
      print(e.toString());
    }
    return false;
  }

  _onSignInPressed() async {
    final success = await _signInFunction();

    if (success) {
      Get.off(HomeScreen()).then((value) => Get.delete<LoginController>());
      print("Sign in success");
    } else {
      print("Sign in failed");
    }
  }

  mainFunction() {
    if (formKey.currentState.validate()) _onSignInPressed();
  }

  @override
  void onClose() {
    print('--> on close login controller <--');
    textEditingControllerUser?.dispose();
    textEditingControllerPass?.dispose();
    super.onClose();
  }
}
