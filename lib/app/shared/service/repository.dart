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

  Future<List<Promise>> getPromises(String uid) async {
    final myPromises =
        await client.collection('users').doc(uid).collection('promises').get();

    return myPromises.docs?.map((p) => Promise.fromJson(p.data()))?.toList() ??
        [];
  }

  Future<bool> createPromise(
      {User target, PromiseType type, int quantity}) async {
    try {
      await client
          .collection('users')
          .doc(target.uid)
          .collection('promises')
          .add({
        'quantity': quantity,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'performed': false,
        'promiseType': type.name,
        'destinyUserId': target.name
      });

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
