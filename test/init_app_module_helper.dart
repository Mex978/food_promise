import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:food_promise/app/app_module.dart';

class InitAppModuleHelper extends IModularTest {
  @override
  final ModularTestType modularTestType;

  InitAppModuleHelper({this.modularTestType = ModularTestType.resetModules});

  @override
  List<Bind> get binds => [];

  @override
  IModularTest get modulardependency => null;

  @override
  ChildModule get module => AppModule();
}
