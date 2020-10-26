import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/pages/contacts/presenter/contacts_screen.dart';
import 'pages/contacts/presenter/contacts_screen.dart';
import 'pages/contacts/presenter/contacts_controller.dart';
import 'package:food_promise/app/modules/home/presenter/home_screen.dart';

import 'presenter/home_controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => ContactsController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, __) => HomeScreen(),
        ),
        ModularRouter(
          '/contacts',
          child: (_, __) => ContactsScreen(),
        )
      ];
}
