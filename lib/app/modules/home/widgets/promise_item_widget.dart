import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/enums.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;

import '../../../shared/utils.dart';
import '../models/promise_model.dart';

class PromiseItem extends StatelessWidget {
  final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
  final Promise promise;
  final Function onPressed;
  final double kBorderRadius = 10;

  PromiseItem({Key key, this.promise, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Material(
        color: promise.cancelled
            ? Colors.red
            : promise.performed
                ? Colors.green
                : Theme.of(context).primaryColor,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          onTap: (uid == promise.promisedBy ||
                  promise.cancelled ||
                  promise.performed)
              ? null
              : onPressed,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Icon(
                  promise.promiseType == PromiseType.BK
                      ? Icons.fastfood
                      : Icons.error_outlined,
                  size: 64,
                ),
                Spacer(),
                Text(
                  'Promised ${promise.quantity} ${FoodPromiseUtils.enumToString(promise.promiseType)}\n ${uid == promise.promisedBy ? 'to' : 'by'} ${uid == promise.promisedBy ? promise.destinyUserId : promise.promisedBy}',
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  FoodPromiseUtils.timestampToHuman(promise.createdAt),
                  style: TextStyle(
                    color: Colors.white54,
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
