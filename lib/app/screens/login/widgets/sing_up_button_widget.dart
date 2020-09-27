import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/register/register_controller.dart';
import 'package:food_promise/app/screens/register/register_screen.dart';
import 'package:get/get.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: RaisedButton(
        onPressed: () => Get.to(RegisterScreen())
            .then((value) => Get.delete<RegisterController>()),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
