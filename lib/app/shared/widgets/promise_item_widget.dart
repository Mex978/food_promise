import 'package:flutter/material.dart';
import 'package:food_promise/app/shared/models/promise_model.dart';
import 'package:food_promise/app/shared/utils.dart';

class PromiseItem extends StatelessWidget {
  final Promise promise;
  final double kBorderRadius = 10;

  const PromiseItem({Key key, this.promise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {},
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
                  "Promised ${promise.quantity} ${FoodPromiseUtils.enumToString(promise.promiseType)}\nto ${promise.destinyUserId}",
                  textAlign: TextAlign.center,
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
