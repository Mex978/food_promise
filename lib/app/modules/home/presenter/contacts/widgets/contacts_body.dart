import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/models/user_model.dart';
import 'package:food_promise/app/modules/home/presenter/home/cubit/home_cubit.dart';
import 'package:food_promise/app/shared/widgets/avatar_widget.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:get/get.dart';

import '../contacts_controller.dart';

class ContactsBody extends StatelessWidget {
  final _controller = Modular.get<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _controller.loadContacts(),
      child: Obx(() {
        if (_controller.loading.value) return SimpleLoader();

        if (_controller.contacts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  size: 100,
                ),
                Text('Nothing here yet!'),
              ],
            ),
          );
        }

        return Obx(() {
          return ListView(
            children: _controller.contacts
                .map(
                  (User user) => ListTile(
                    leading: AvatarWidget(
                      name: user.name,
                      imageUrl: user.imageUrl,
                      width: 55,
                      height: 55,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () async {
                      await Modular.get<HomeCubit>()
                          .makePromise(preSelectedPromiseTarget: user);
                    },
                  ),
                )
                .toList(),
          );
        });
      }),
    );
  }
}
