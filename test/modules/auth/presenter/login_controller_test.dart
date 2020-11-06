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
      controller.textEditingControllerPass.text = 'somepassword';
      controller.textEditingControllerUser.text = 'foodpromise@gmail.com';
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

    test('Should return true to result', () async {
      final result = await controller.signInFunction();
      expect(controller.loading.value, false);

      expect(result, true);
    });

    testWidgets('Shouldn\'t display a error message for weak password',
        (WidgetTester tester) async {
      await tester.pumpWidget(materialWidget());
      const error = 'Error';

      when(auth.signInWithEmailAndPassword(
              email: controller.textEditingControllerUser.text,
              password: controller.textEditingControllerPass.text))
          .thenAnswer((_) => throw FirebaseAuthException(
              email: controller.textEditingControllerUser.text,
              code: 'weak-password',
              message: ''));

      final result = await controller.signInFunction();

      await tester.pump();
      expect(find.text(error), findsOneWidget);
      expect(controller.loading.value, false);

      expect(result, false);
    });
  });
}
