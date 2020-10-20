import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/screens/contacts/contacts_screen.dart';
import 'package:food_promise/app/modules/home/presenter/home_controller.dart';
import 'package:food_promise/app/shared/utils.dart';
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
                ClipOval(
                  child: Obx(() {
                    final imageUrl = controller.user.value.imageUrl;

                    if (imageUrl == null || imageUrl.isEmpty)
                      return Container(
                          color: Theme.of(context).canvasColor,
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Text(
                              FoodPromiseUtils.getInitials(
                                      controller.user.value.name) ??
                                  '',
                              style: TextStyle(fontSize: 32),
                            ),
                          ));

                    return CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        color: Theme.of(context).canvasColor,
                        width: 100,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                      ),
                      errorWidget: (context, url, error) => Text('Error'),
                    );
                  }),
                ),
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
            onTap: () => Get.to(ContactsScreen()),
            leading: Icon(Icons.people),
            title: Text('Contacts'),
          )
        ]
          ..add(Spacer())
          ..add(ListTile(
            leading: Icon(Icons.close, color: Colors.red),
            title: Text(
              'Sign Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            onTap: () => controller.signOut(),
          )),
      ),
    );
  }
}
