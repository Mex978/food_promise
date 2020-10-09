import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/auth/presenter/register/register_controller.dart';
import 'package:food_promise/app/modules/auth/presenter/widgets/sign_up_button_widget.dart';
import 'package:food_promise/app/shared/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends ModularState<RegisterScreen, RegisterController> {
  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

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
                    key: controller.formKey,
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
                        _divider(context, 4),
                        CustomTextField(
                          index: 0,
                          controller: controller,
                        ),
                        _divider(context, 2),
                        CustomTextField(
                          index: 1,
                          controller: controller,
                        ),
                        _divider(context, 2),
                        CustomTextField(
                          index: 2,
                          controller: controller,
                        ),
                        _divider(context, 2),
                        CustomTextField(
                          index: 3,
                          controller: controller,
                        ),
                        _divider(context, 4),
                        SignUpButton(controller: controller),
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
