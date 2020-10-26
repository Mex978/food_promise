import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:get/get.dart';
import 'package:asuka/asuka.dart' as asuka;

import '../../../models/user_model.dart';
import '../widgets/contacts_search.dart';

class ContactsController extends GetxController {
  final _repository = Modular.get<Repository>();

  final contacts = <User>[].obs;
  final loading = true.obs;

  void init() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    if (!loading.value) loading.value = true;
    try {
      final list = await _repository.getContacts();

      contacts.clear();
      contacts.addAll(list);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      FoodPromiseUtils.foodPromiseDialog('Error', '$e', false);
    }
  }

  void select(dynamic value) {
    switch (value) {
      case 0:
        showSearch(
                context: Modular.navigatorKey.currentContext,
                delegate: ContactsSearch(contacts.map((c) => c.uid).toList()))
            .then((result) {
          if (result != null) {
            asuka.showDialog(
              builder: (context) => AlertDialog(
                title: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'You want to add the user?\n\n\tName: ${result.name}\n\tE-mail: ${result.email}',
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        print(result.uid);
                        print(result.name);
                        print(result.email);
                        _repository.addContact(result);
                        print(result);
                        contacts.add(result);
                        Navigator.pop(context);
                      },
                      child: Text('Add')),
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            );
          }
        });
        break;
      case 1:
        FoodPromiseUtils.toast('Comming Soon');
        break;
      default:
    }
  }
}
