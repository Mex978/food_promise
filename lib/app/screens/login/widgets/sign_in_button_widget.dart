import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/login/login_controller.dart';
import 'package:get/get.dart';

class SignInButton extends StatelessWidget {
  final _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () => _controller.onSignInPressed(),
        child: Text(
          'SIGN IN',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
