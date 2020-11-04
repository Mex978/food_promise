import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_promise/app/modules/auth/presenter/login/login_controller.dart';
import 'package:mockito/mockito.dart';

import 'package:asuka/asuka.dart' as asuka;

import '../init_auth_module_helper.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

void main() {
  Widget materialWidget() => MaterialApp(
        builder: asuka.builder,
        home: Scaffold(
          body: Container(),
        ),
      );

  LoginController controller;
  FirebaseAuthMock auth;

  group('LoginController test', () {
    setUp(() async {
      InitAuthModuleHelper().load(changeBinds: [
        Bind<FirebaseAuth>((i) => FirebaseAuthMock()),
      ]);

      controller = Modular.get<LoginController>();
      auth = Modular.get<FirebaseAuth>();
      controller.init();
    });

    test('Loading should be false when init', () {
      expect(controller.loading.value, false);
    });

    test('Should have two inputs', () {
      expect(controller.inputs, isInstanceOf<List>());
      expect(controller.inputs[0], isInstanceOf<Map<String, dynamic>>());

      expect(controller.inputs.isNotEmpty, true);
      expect(controller.inputs.length, 2);
    });

    test(
        'Should return true to obscure if the input is a password or a repeat password',
        () {
      final passwordInput = controller.inputs.firstWhere(
              (element) => (element as Map).containsValue('Password'))
          as Map<String, dynamic>;

      expect(passwordInput['obscure'], true);
    });

    test('Controllers should be disposed', () {
      controller.close();

      expect(controller.textEditingControllerPass, isNull);
      expect(controller.textEditingControllerUser, isNull);
    });
  });
}
