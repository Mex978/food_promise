import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/models/promise_model.dart';

import 'package:food_promise/app/modules/home/models/user_model.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/widgets/feedback_dialog_widget.dart';
import 'package:get/get.dart';

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

  loadPromises() async {
    if (!loading.value) loading.value = true;

    _repository.getPromises(user.value.uid).then((list) {
      promises.clear();
      promises.addAll(list);
      loading.value = false;
    });
  }

  makePromise() async {
    final success = await _repository.createPromise(user.value.uid);

    if (success)
      successDialog(
        "Success",
        "Promise created with success!",
      );
    else
      errorDialog(
        "Error",
        "Some error ocurred :(",
      );
  }

  signOut() async {
    final auth = Modular.get<FirebaseAuth>();
    auth.signOut().then((value) => Modular.to.pushReplacementNamed('/login'));
  }
}
