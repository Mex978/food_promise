import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/login/login_controller.dart';
import 'package:get/get.dart';

class LoginTextField extends StatelessWidget {
  final int index;
  final _controller = Get.find<LoginController>();

  LoginTextField({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nextInput =
        index < (_controller.inputs.length - 1) ? index + 1 : null;

    return TextFormField(
      controller: _controller.inputs[index]["controller"],
      obscureText: _controller.inputs[index]["obscure"],
      focusNode: _controller.inputs[index]["focusNode"],
      decoration: InputDecoration(
        hintText:
            'Type your ${_controller.inputs[index]["label"].toLowerCase()}',
        border: OutlineInputBorder(),
        labelText: _controller.inputs[index]["label"],
      ),
      onFieldSubmitted: (_) => nextInput != null
          ? FocusScope.of(context)
              .requestFocus(_controller.inputs[nextInput]["focusNode"])
          : _controller.onSignInPressed(),
    );
  }
}
