import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home/home_screen.dart';

import 'presenter/contacts/contacts_controller.dart';
import 'presenter/contacts/contacts_screen.dart';
import 'presenter/home/cubit/home_cubit.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ContactsController()),
        Bind((i) => HomeCubit()),
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
