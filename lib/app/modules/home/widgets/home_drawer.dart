import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home_controller.dart';
import 'package:food_promise/app/shared/widgets/avatar_widget.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Obx(() {
                  final imageUrl = controller.user.value.imageUrl;

                  return AvatarWidget(
                    name: controller.user.value.name,
                    imageUrl: imageUrl,
                  );
                }),
                Spacer(),
                Obx(() => Text(controller.user.value.name ?? '')),
                Spacer(),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () => Modular.to.pushNamed('/contacts'),
            leading: Icon(Icons.people),
            title: Text('Contacts'),
          )
        ]
          ..add(Spacer())
          ..add(ListTile(
            leading: Icon(Icons.close, color: Theme.of(context).primaryColor),
            tileColor: Colors.white,
            title: Text(
              'Sign Out',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900),
            ),
            onTap: () => controller.signOut(),
          )),
      ),
    );
  }
}
