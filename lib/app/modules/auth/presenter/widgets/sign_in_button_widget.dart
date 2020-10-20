import 'package:flutter/material.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:get/get.dart';

class SignInButton extends StatelessWidget {
  final controller;

  const SignInButton({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: Obx(() {
        if (controller.loading.value) return SimpleLoader();

        return RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => controller.mainFunction(),
          child: Text(
            'SIGN IN',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }),
    );
  }
}
