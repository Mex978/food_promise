import 'package:food_promise/app/shared/utils.dart';

import '../enums.dart';

class Promise {
  int quantity;
  double createdAt;
  bool performed;
  PromiseType promiseType;
  String destinyUserId;

  Promise({
    this.quantity,
    this.createdAt,
    this.performed,
    this.promiseType,
    this.destinyUserId,
  });

  Promise.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    performed = json['performed'];
    promiseType = FoodPromiseUtils.enumFromString(
        json['promiseType'], PromiseType.values);
    destinyUserId = json['destinyUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['performed'] = this.performed;
    data['promiseType'] = FoodPromiseUtils.enumToString(this.promiseType);
    data['destinyUserId'] = this.destinyUserId;
    return data;
  }
}
