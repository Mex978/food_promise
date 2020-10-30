import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home_controller.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:get/get.dart';

import '../models/promise_model.dart';

class HomeBottomSheet extends StatelessWidget {
  final controller = Modular.get<HomeController>();
  final Promise promise;
  final Function onPerformAction;

  HomeBottomSheet(
      {Key key, @required this.promise, @required this.onPerformAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                if (controller.loadingBottomSheet.value) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SimpleLoader(
                        indicatorColor: Theme.of(context).primaryColor,
                      )
                    ],
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('COMPLETED'),
                      onPressed: () {
                        controller.performPromise(promise).then((_) {
                          onPerformAction();
                          Navigator.pop(context);
                        });
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.close),
                      label: Text('CANCELED'),
                      onPressed: () {
                        controller.cancelPromise(promise).then((_) {
                          onPerformAction();
                          Navigator.pop(context);
                        });
                      },
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
