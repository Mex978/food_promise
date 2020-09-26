import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/login/login_controller.dart';
import 'package:food_promise/app/screens/login/widgets/sign_in_button_widget.dart';
import 'package:food_promise/app/screens/login/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome to Food Promise!',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        _divider(context, 6),
                        LoginTextField(index: 0),
                        _divider(context, 2),
                        LoginTextField(index: 1),
                        _divider(context, 6),
                        SignInButton(),
                        _divider(context, 1),
                        SignInButton(),
                        _divider(context, 1),
                        SignInButton(),
                        // SignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _divider(BuildContext context, double factor) => Divider(
      height: (MediaQuery.of(context).size.height * 0.02) * factor,
      color: Colors.transparent);
}
