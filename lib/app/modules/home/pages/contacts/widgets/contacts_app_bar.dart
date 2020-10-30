import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/contacts_controller.dart';
import '../consts.dart';

class ContactsAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _ContactsAppBarState createState() => _ContactsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _ContactsAppBarState extends State<ContactsAppBar> {
  final _controller = Modular.get<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Contacts'),
      actions: _actions,
    );
  }

  List<Widget> get _actions => [
        PopupMenuButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.group_add),
          onSelected: _controller.select,
          itemBuilder: (BuildContext context) => MENU_CHOICES
              .map(
                (choice) => PopupMenuItem(
                  value: choice['value'],
                  child: Text(choice['content']),
                ),
              )
              .toList(),
        )
      ];
}
