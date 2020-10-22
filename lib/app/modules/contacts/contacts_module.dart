import 'package:flutter_modular/flutter_modular.dart';
import 'presenter/contacts_controller.dart';
import 'presenter/contacts_screen.dart';
import 'repository/contacts_shared_preferences.dart';

class ContactsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ContactsController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, __) => ContactsScreen(),
        ),
      ];

  static Inject get to => Inject<ContactsModule>.of();
}
