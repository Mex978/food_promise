import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_promise/app/modules/auth/presenter/register/register_controller.dart';
import 'package:mockito/mockito.dart';

import '../init_auth_module_helper.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  group('RegisterController test', () {
    RegisterController controller;
    FirebaseAuthMock auth;

    setUp(() {
      InitAuthModuleHelper().load(changeBinds: [
        Bind<FirebaseAuth>((i) => FirebaseAuthMock()),
      ]);
      controller = Modular.get<RegisterController>();
      auth = Modular.get<FirebaseAuthMock>();
    });

    test('Should have inputs', () {
      controller.init();

      expect(controller.inputs, isInstanceOf<List>());
      expect(controller.inputs[0], isInstanceOf<Map<String, dynamic>>());

      expect(controller.inputs.isNotEmpty, true);
    });

    test(
        'Should return true to obscure if the input is a password or a repeat password',
        () {
      controller.init();
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
      controller.init();
      final nameInput = controller.inputs
              .firstWhere((element) => (element as Map).containsValue('Name'))
          as Map<String, dynamic>;

      final emailInput = controller.inputs
              .firstWhere((element) => (element as Map).containsValue('E-mail'))
          as Map<String, dynamic>;

      expect(nameInput['obscure'], false);

      expect(emailInput['obscure'], false);
    });
  });
}
