import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/auth/presenter/login/login_controller.dart';
import 'package:food_promise/app/modules/auth/presenter/login/login_screen.dart';
import 'package:food_promise/app/modules/auth/presenter/register/register_controller.dart';
import 'package:food_promise/app/modules/auth/presenter/register/register_screen.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
        Bind((i) => RegisterController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, __) => LoginScreen(),
        ),
        ModularRouter(
          '/register',
          child: (_, __) => RegisterScreen(),
        ),
      ];
}
