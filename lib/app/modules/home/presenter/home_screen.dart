import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/widgets/home_body.dart';
import 'package:food_promise/app/modules/home/widgets/home_drawer.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.loading.value) {
        return SimpleLoader(
          withScaffold: true,
        );
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Promises'),
        ),
        drawer: HomeDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.makePromise();
          },
          child: Icon(
            Icons.add,
            size: 32,
          ),
        ),
        body: HomeBody(),
      );
    });
  }
}
