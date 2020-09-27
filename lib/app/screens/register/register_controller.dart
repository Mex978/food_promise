import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_screen.dart';
import 'package:food_promise/app/screens/login/login_controller.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/widgets/feedback_dialog_widget.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final loading = false.obs;
  GlobalKey<FormState> formKey;
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerEmail;
  TextEditingController textEditingControllerPass;
  TextEditingController textEditingControllerRePass;

  final List<dynamic> inputs = [
    {
      "label": "Name",
      "obscure": false,
      "focusNode": FocusNode(),
    },
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
    formKey = GlobalKey<FormState>();

    textEditingControllerName = TextEditingController();
    inputs[0]["controller"] = textEditingControllerName;

    textEditingControllerEmail = TextEditingController();
    inputs[1]["controller"] = textEditingControllerEmail;

    textEditingControllerPass = TextEditingController();
    inputs[2]["controller"] = textEditingControllerPass;

    textEditingControllerRePass = TextEditingController();
    inputs[3]["controller"] = textEditingControllerRePass;
    super.onInit();
  }

  Future<bool> _signUpFunction() async {
    loading.value = true;
    final auth = Get.find<FirebaseAuth>();

    final name = textEditingControllerName.text;
    final email = textEditingControllerEmail.text;
    final password = textEditingControllerPass.text;
    final rePassword = textEditingControllerRePass.text;

    try {
      if (rePassword == password) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        final uid = userCredential.user.uid;

        final repository = Get.find<Repository>();
        final result =
            await repository.createUser(uid: uid, name: name, email: email);

        loading.value = false;
        return result;
      } else {
        loading.value = false;
        errorDialog(
          'Error',
          'The passwords don\'t match',
        );
      }
    } on FirebaseAuthException catch (e) {
      print("ERRO SIGN UP ==> ${e.toString()}");
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

  _onSignUpPressed() async {
    final success = await _signUpFunction();

    if (success) {
      Get.offAll(HomeScreen()).then((_) => Get.delete<RegisterController>()
          .then((_) => Get.delete<LoginController>()));
      print("Sign Up");
    } else {
      print('Sign up failed');
    }
  }

  mainFunction() {
    if (formKey.currentState.validate()) _onSignUpPressed();
  }

  @override
  void onClose() {
    print('--> on close register controller <--');
    textEditingControllerEmail?.dispose();
    textEditingControllerPass?.dispose();
    textEditingControllerRePass?.dispose();
    super.onClose();
  }
}
