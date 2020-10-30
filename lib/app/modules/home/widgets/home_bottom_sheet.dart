import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/promise_model.dart';
import 'package:food_promise/app/shared/service/repository.dart';

class HomeBottomSheet extends StatelessWidget {
  final _repository = Modular.get<Repository>();
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton.icon(
                    icon: Icon(Icons.check),
                    label: Text('COMPLETED'),
                    onPressed: () {
                      _repository
                          .changePromise(promise, performed: true)
                          .then((value) {
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
                      _repository
                          .changePromise(promise, cancelled: true)
                          .then((value) {
                        onPerformAction();
                        Navigator.pop(context);
                      });
                    },
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
