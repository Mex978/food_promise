import 'package:flutter/material.dart';
import 'package:food_promise/app/shared/utils.dart';

import '../../../shared/utils.dart';
import '../models/promise_model.dart';

class PromiseItem extends StatelessWidget {
  final Promise promise;
  final Function onPressed;
  final double kBorderRadius = 10;

  const PromiseItem({Key key, this.promise, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          onTap: onPressed,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Icon(
                  Icons.fastfood,
                  size: 64,
                ),
                Spacer(),
                Text(
                  'Promised ${promise.quantity} ${FoodPromiseUtils.enumToString(promise.promiseType)}\nto ${promise.destinyUserId}',
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  FoodPromiseUtils.timestampToHuman(promise.createdAt),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
