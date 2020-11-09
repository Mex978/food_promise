import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_modular/src/interfaces/child_module.dart';
import 'package:flutter_modular/src/inject/bind.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:food_promise/app/modules/auth/auth_module.dart';
import '../../init_app_module_helper.dart';

class InitAuthModuleHelper extends IModularTest {
  @override
  List<Bind> get binds => [];

  @override
  ChildModule get module => AuthModule();

  @override
  IModularTest get modulardependency => InitAppModuleHelper();
}
