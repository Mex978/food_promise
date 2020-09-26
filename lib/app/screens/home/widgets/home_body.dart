import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/simple_loader_widget.dart';

import '../home_controller.dart';
import 'promise_item_widget.dart';

class HomeBody extends StatelessWidget {
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _controller.loadPromises(),
      child: Obx(() {
        if (_controller.loading.value) return SimpleLoader();

        if (_controller.promises.isEmpty)
          return Stack(
            children: <Widget>[
              ListView(),
              Center(
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
              )
            ],
          );

        return GridView.count(
          padding: EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: _controller.promises
              .map((promise) => Center(
                    child: PromiseItem(
                      promise: promise,
                      onPressed: () {
                        Future.delayed(
                          Duration(milliseconds: 200),
                          () {},
                        );
                      },
                    ),
                  ))
              .toList(),
        );
      }),
    );
  }
}
