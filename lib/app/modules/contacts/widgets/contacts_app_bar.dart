import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/contacts/presenter/contacts_controller.dart';

import '../consts.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
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

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
