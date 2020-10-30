import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/models/promise_model.dart';
import 'package:food_promise/app/modules/home/models/user_model.dart';
import 'package:food_promise/app/modules/home/enums.dart';
import 'package:meta/meta.dart';

class Repository {
  final FirebaseFirestore client;

  Repository({@required this.client});

  Future<List<User>> getAllUsers() async {
    final _users_collection = await client.collection('users').get();

    return _users_collection.docs?.map((u) {
          return User.fromDoc(u);
        })?.toList() ??
        [];
  }

  Future<bool> addContact(User newContact) async {
    try {
      final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
      await client
          .collection('users')
          .doc(uid)
          .collection('contacts')
          .add(newContact.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getContacts() async {
    final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
    final _contacts =
        await client.collection('users').doc(uid).collection('contacts').get();

    return _contacts.docs.map((c) => User.fromDoc(c)).toList();
  }

  Future<List<Promise>> getPromises() async {
    final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
    final myPromises =
        await client.collection('users').doc(uid).collection('promises').get();

    return myPromises.docs?.map((p) => Promise.fromDoc(p))?.toList() ?? [];
  }

  Future<bool> createPromise(
      {User target, PromiseType type, int quantity}) async {
    final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
    final myName = Modular.get<f_auth.FirebaseAuth>().currentUser.displayName;
    try {
      await client
          .collection('users')
          .doc(target.uid)
          .collection('promises')
          .add({
        'quantity': quantity,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'cancelled': false,
        'performed': false,
        'promiseType': type.name,
        'promisedBy': myName,
        'destinyUserId': target.name
      }).then((value) async {
        await client
            .collection('users')
            .doc(uid)
            .collection('promises')
            .doc(value.id)
            .set({
          'quantity': quantity,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'cancelled': false,
          'performed': false,
          'promiseType': type.name,
          'promisedBy': uid,
          'destinyUserId': target.name
        });
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changePromise(Promise promise,
      {bool cancelled = false, bool performed = false}) async {
    final uid = Modular.get<f_auth.FirebaseAuth>().currentUser.uid;
    try {
      await client
          .collection('users')
          .doc(uid)
          .collection('promises')
          .doc(promise.uid)
          .update(cancelled
              ? {'cancelled': cancelled}
              : performed
                  ? {'performed': performed}
                  : {});
      await client
          .collection('users')
          .doc(promise.promisedBy)
          .collection('promises')
          .doc(promise.uid)
          .update(cancelled
              ? {'cancelled': cancelled}
              : performed
                  ? {'performed': performed}
                  : {});

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createUser({String uid, String name, String email}) async {
    try {
      await client.collection('users').doc(uid).set({
        'name': name,
        'email': email,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
