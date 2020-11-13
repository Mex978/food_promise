import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'contacts_controller.dart';
import 'widgets/contacts_app_bar.dart';
import 'widgets/contacts_body.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _controller = Modular.get<ContactsController>();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(),
      body: ContactsBody(),
    );
  }
}
