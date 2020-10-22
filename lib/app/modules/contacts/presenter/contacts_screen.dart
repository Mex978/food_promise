import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/contacts/widgets/contacts_app_bar.dart';
import 'package:food_promise/app/modules/contacts/widgets/contacts_body.dart';

import 'contacts_controller.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _controller = Modular.get<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(),
      body: ContactsBody(),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
