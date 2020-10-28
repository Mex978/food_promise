import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_promise/app/shared/utils.dart';

import '../enums.dart';

class Promise {
  String uid;
  int quantity;
  int createdAt;
  bool performed;
  bool cancelled;
  PromiseType promiseType;
  String promisedBy;
  String destinyUserId;

  Promise({
    this.quantity,
    this.createdAt,
    this.performed,
    this.promiseType,
    this.promisedBy,
    this.destinyUserId,
    this.cancelled,
  });

  Promise.fromDoc(QueryDocumentSnapshot doc) {
    uid = doc.id;
    cancelled = doc.data()['cancelled'];
    promisedBy = doc.data()['promisedBy'];
    quantity = doc.data()['quantity'];
    createdAt = doc.data()['createdAt'];
    performed = doc.data()['performed'];
    promiseType = FoodPromiseUtils.enumFromString(
        doc.data()['promiseType'], PromiseType.values);
    destinyUserId = doc.data()['destinyUserId'];
  }

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
    data['uid'] = uid;
    data['promisedBy'] = promisedBy;
    data['cancelled'] = cancelled;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['performed'] = performed;
    data['promiseType'] = FoodPromiseUtils.enumToString(promiseType);
    data['destinyUserId'] = destinyUserId;
    return data;
  }
}
