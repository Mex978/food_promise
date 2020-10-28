import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/models/promise_model.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:get/get.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/utils.dart';

import '../models/user_model.dart';
import '../widgets/make_new_promise_widget.dart';

class HomeController extends GetxController {
  final loading = true.obs;
  final user = User().obs;
  final _repository = Modular.get<Repository>();
  final _auth = Modular.get<FirebaseAuth>();

  final promises = <Promise>[].obs;

  HomeController() {
    _init();
  }

  void _init() {
    getUserInfo().then((_) => loadPromises());
  }

  Future getUserInfo() async {
    final newUid = _auth.currentUser.uid;
    final newEmail = _auth.currentUser.email;
    final userData =
        await _repository.client.collection('users').doc(newUid).get();
    final newName = userData.data()['name'];

    user.update((user) {
      user.uid = newUid;
      user.name = newName;
      user.email = newEmail;
    });
  }

  Future<void> loadPromises() async {
    if (!loading.value) loading.value = true;
    try {
      final list = await _repository.getPromises();
      promises.clear();
      promises.addAll(list);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      FoodPromiseUtils.foodPromiseDialog('Error', '$e', false);
    }
  }

  void makePromise({User preSelectedPromiseTarget}) async {
    final newPromise = await asuka.showDialog(
      builder: (context) => MakeNewPromiseDialog(
        preSelectedPromiseTarget: preSelectedPromiseTarget,
      ),
    );

    if (newPromise == null) {
      return;
    }

    final success = await _repository.createPromise(
        target: newPromise['selectedPromiseTarget'],
        type: newPromise['selectedPromiseType'],
        quantity: newPromise['quantity']);

    if (success) {
      FoodPromiseUtils.foodPromiseDialog(
          'Success', 'Promise created with success!', true);
      await loadPromises();
    } else {
      FoodPromiseUtils.foodPromiseDialog(
          'Error', 'Some error ocurred :(', false);
    }
  }

  void changePromiseStatus(Promise promise, Function onPerformAction) {
    asuka.showBottomSheet((context) => Container(
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
        ));
  }

  void signOut() {
    final auth = Modular.get<FirebaseAuth>();
    auth.signOut().then((value) => Modular.to.pushReplacementNamed('/login'));
  }
}
