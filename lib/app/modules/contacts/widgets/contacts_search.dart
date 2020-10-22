import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/contacts/presenter/contacts_controller.dart';
import 'package:food_promise/app/modules/contacts/repository/contacts_shared_preferences.dart';
import 'package:food_promise/app/modules/home/models/user_model.dart' as model;
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:asuka/asuka.dart' as asuka;

class ContactsSearch extends SearchDelegate {
  final List<String> currentContacts;
  final _repository = Modular.get<Repository>();
  final _auth = Modular.get<FirebaseAuth>();
  final _controller = Modular.get<ContactsController>();
  model.User selectedResult;

  ContactsSearch(this.currentContacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    asuka.showDialog(
      builder: (context) => Dialog(
        child: Text(selectedResult.name),
      ),
    );

    return Container(
      child: Center(
        child: Text(selectedResult.name),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<model.User>>(
      future: _repository.getAllUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return SimpleLoader();
          case ConnectionState.none:
          case ConnectionState.done:
            final suggestionList = [];
            final list = snapshot.data.where((element) =>
                !currentContacts.contains(element.uid) &&
                element.uid != _auth.currentUser.uid);
            suggestionList.addAll(list.where((item) =>
                item.name.toLowerCase().contains(query.toLowerCase()) ||
                item.email.toLowerCase().contains(query.toLowerCase())));

            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(suggestionList[index].name),
                subtitle: Text(suggestionList[index].email),
                onTap: () {
                  Navigator.pop(context, suggestionList[index]);
                },
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
