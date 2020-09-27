import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_promise/app/screens/home/models/promise_model.dart';
import 'package:food_promise/app/shared/service/mocked_data.dart';
import 'package:meta/meta.dart';

class Repository {
  final FirebaseFirestore client;

  Repository({@required this.client});

  Future<List<Promise>> getPromises() async {
    final myPromises = await client
        .collection('users')
        .doc('Max Lima')
        .collection('promises')
        .get();

    return myPromises.docs?.map((p) => Promise.fromJson(p.data()))?.toList() ??
        [];
  }

  Future<bool> createPromise() async {
    try {
      await client
          .collection('users')
          .doc('Max Lima')
          .collection('promises')
          .add({
        "quantity": 1,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "performed": false,
        "promiseType": "BK",
        "destinyUserId": "Max Lima"
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createUser({String uid, String name}) async {
    try {
      client.collection('users').doc(uid).set({'name': name});
      await client
          .collection('users')
          .doc('Max Lima')
          .collection('promises')
          .add({
        "quantity": 1,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "performed": false,
        "promiseType": "BK",
        "destinyUserId": "Max Lima"
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
