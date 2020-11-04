import 'package:asuka/asuka.dart' as asuka;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_promise/app/modules/auth/presenter/register/register_controller.dart';
import 'package:mockito/mockito.dart';

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

  group('RegisterController test', () {
    RegisterController controller;
    FirebaseAuthMock auth;

    setUp(() async {
      InitAuthModuleHelper().load(changeBinds: [
        Bind<FirebaseAuth>((i) => FirebaseAuthMock()),
      ]);

      controller = Modular.get<RegisterController>();
      auth = Modular.get<FirebaseAuthMock>();
      controller.init();
    });

    test('Should have inputs', () {
      expect(controller.inputs, isInstanceOf<List>());
      expect(controller.inputs[0], isInstanceOf<Map<String, dynamic>>());

      expect(controller.inputs.isNotEmpty, true);
    });

    test(
        'Should return true to obscure if the input is a password or a repeat password',
        () {
      final passwordInput = controller.inputs.firstWhere(
              (element) => (element as Map).containsValue('Password'))
          as Map<String, dynamic>;

      final rePasswordInput = controller.inputs.firstWhere(
              (element) => (element as Map).containsValue('Re-Password'))
          as Map<String, dynamic>;

      expect(passwordInput['obscure'], true);

      expect(rePasswordInput['obscure'], true);
    });

    test('Should return false to obscure if the input is a name or a e-mail',
        () {
      final nameInput = controller.inputs
              .firstWhere((element) => (element as Map).containsValue('Name'))
          as Map<String, dynamic>;

      final emailInput = controller.inputs
              .firstWhere((element) => (element as Map).containsValue('E-mail'))
          as Map<String, dynamic>;

      expect(nameInput['obscure'], false);

      expect(emailInput['obscure'], false);
    });

    testWidgets(
        'Should return false if passwords don\'t match and loading is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(materialWidget());

      controller.textEditingControllerPass.text = 'test';
      controller.textEditingControllerRePass.text = 'not-tested';

      final result = await controller.signUpFunction();

      expect(result, false);
      expect(controller.loading.value, false);
      await tester.pump();
      expect(find.text('The passwords don\'t match'), findsOneWidget);
    });

    testWidgets('Should display a error message', (WidgetTester tester) async {
      await tester.pumpWidget(materialWidget());

      final email = 'foodpromise@gmail.com';
      final password = 'somepassword';

      when(auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((_) async => throw FirebaseAuthException(
              email: email, code: 'weak-password', message: ''));

      final result = await controller.signUpFunction();

      expect(result, false);
      expect(controller.loading.value, false);
      await tester.pump();
      expect(find.text('The password provided is too weak.'), findsOneWidget);
    });
  });
}
