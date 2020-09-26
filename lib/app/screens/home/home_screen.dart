import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'home_controller.dart';
import 'widgets/home_body.dart';
import 'widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Promises"),
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
  }
}
