import 'package:food_promise/app/shared/utils.dart';

import '../../../shared/enums.dart';

class Promise {
  int quantity;
  int createdAt;
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
    final data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['performed'] = performed;
    data['promiseType'] = FoodPromiseUtils.enumToString(promiseType);
    data['destinyUserId'] = destinyUserId;
    return data;
  }
}
