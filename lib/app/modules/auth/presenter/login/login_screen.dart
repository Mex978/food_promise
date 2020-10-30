import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/auth/presenter/login/login_controller.dart';
import 'package:food_promise/app/modules/auth/presenter/widgets/custom_button_widget.dart';
import 'package:food_promise/app/shared/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ModularState<LoginScreen, LoginController> {
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
                        _divider(context, 3),
                        ...buildTextFields(),
                        _divider(context, 3),
                        Obx(
                          () => CustomButton(
                            onPressed: controller.login,
                            text: 'SIGN IN',
                            isLoading: controller.loading.value,
                            darkColor: true,
                          ),
                        ),
                        _divider(context, 1),
                        Obx(
                          () => Visibility(
                            visible: !controller.loading.value,
                            child: CustomButton(
                              onPressed: () =>
                                  Modular.link.pushNamed('/register'),
                              text: 'SIGN UP',
                            ),
                          ),
                        ),
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

  List<Widget> buildTextFields() {
    return controller.inputs
        .asMap()
        .map((index, input) {
          final isLast = controller.inputs.last == input;

          return MapEntry(
              index,
              Column(
                children: [
                  CustomTextField(
                    fieldInfo: controller.inputs[index],
                    nextFieldInfo: index < (controller.inputs.length - 1)
                        ? controller.inputs[index + 1]
                        : null,
                    onSubmit: isLast ? () => controller.login() : null,
                  ),
                  isLast ? Container() : _divider(context, 2),
                ],
              ));
        })
        .values
        .toList();
  }

  Widget _divider(BuildContext context, double factor) => Divider(
      height: (MediaQuery.of(context).size.height * 0.02) * factor,
      color: Colors.transparent);
}
