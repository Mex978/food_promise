import 'package:flutter/material.dart';
import 'package:food_promise/app/screens/home/home_controller.dart';
import 'package:food_promise/app/shared/widgets/promise_item_widget.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:get/get.dart';

class HomeBody extends StatelessWidget {
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _controller.loadPromises(),
      child: Obx(() {
        if (_controller.loading.value) return SimpleLoader();
        return GridView.count(
          padding: EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: _controller.promises
              .map((promise) => Center(
                    child: PromiseItem(
                      promise: promise,
                    ),
                  ))
              .toList(),
        );
      }),
    );
  }
}
