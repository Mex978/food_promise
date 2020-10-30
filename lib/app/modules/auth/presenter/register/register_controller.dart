import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/utils.dart';
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
      'label': 'Name',
      'obscure': false,
      'focusNode': FocusNode(),
    },
    {
      'label': 'E-mail',
      'obscure': false,
      'focusNode': FocusNode(),
    },
    {
      'label': 'Password',
      'obscure': true,
      'focusNode': FocusNode(),
    },
    {
      'label': 'Re-Password',
      'obscure': true,
      'focusNode': FocusNode(),
    },
  ];

  void init() {
    formKey = GlobalKey<FormState>();

    textEditingControllerName = TextEditingController();
    inputs[0]['controller'] = textEditingControllerName;

    textEditingControllerEmail = TextEditingController();
    inputs[1]['controller'] = textEditingControllerEmail;

    textEditingControllerPass = TextEditingController();
    inputs[2]['controller'] = textEditingControllerPass;

    textEditingControllerRePass = TextEditingController();
    inputs[3]['controller'] = textEditingControllerRePass;
  }

  Future<bool> _signUpFunction() async {
    loading.value = true;
    final auth = Modular.get<FirebaseAuth>();

    final name = textEditingControllerName.text;
    final email = textEditingControllerEmail.text;
    final password = textEditingControllerPass.text;
    final rePassword = textEditingControllerRePass.text;

    try {
      if (rePassword == password) {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final uid = userCredential.user.uid;

        final repository = Modular.get<Repository>();
        final result =
            await repository.createUser(uid: uid, name: name, email: email);

        loading.value = false;
        return result;
      } else {
        loading.value = false;

        FoodPromiseUtils.foodPromiseDialog(
            'Error', 'The passwords don\'t match', false);
      }
    } on FirebaseAuthException catch (e) {
      print('ERRO SIGN UP ==> ${e.toString()}');
      loading.value = false;
      if (e.code == 'weak-password') {
        FoodPromiseUtils.foodPromiseDialog(
            'Error', 'The password provided is too weak.', false);
      } else if (e.code == 'email-already-in-use') {
        FoodPromiseUtils.foodPromiseDialog(
            'Error', 'The account already exists for that email.', false);
      } else if (e.code == 'invalid-email') {
        FoodPromiseUtils.foodPromiseDialog(
            'Error', 'The email provided is invalid', false);
      }
    } catch (e) {
      loading.value = false;
      FoodPromiseUtils.foodPromiseDialog('Error', e.toString(), false);
      print(e.toString());
    }
    return false;
  }

  void _onSignUpPressed() async {
    final success = await _signUpFunction();

    if (success) {
      print('Sign Up');
      await Modular.to.pushReplacementNamed('/home');
    } else {
      print('Sign up failed');
    }
  }

  void register() {
    if (formKey.currentState.validate()) _onSignUpPressed();
  }

  void close() {
    textEditingControllerEmail?.dispose();
    textEditingControllerPass?.dispose();
    textEditingControllerRePass?.dispose();
  }
}
