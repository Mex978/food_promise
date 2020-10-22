// import 'package:shared_preferences/shared_preferences.dart';

// class ContactsSharedPreferences {
//   void addContact(String new_contact_key) async {
//     final _instance = await SharedPreferences.getInstance();
//     final my_contacts = await loadContacts();

//     await _instance.setStringList(
//         'my_contacts', my_contacts..add(new_contact_key));
//   }

//   Future<List<String>> loadContacts() async {
//     final _instance = await SharedPreferences.getInstance();
//     final my_contacts = _instance.getStringList('my_contacts') ?? [];

//     return my_contacts;
//   }

//   void clear() async {
//     final _instance = await SharedPreferences.getInstance();
//     await _instance.setStringList('my_contacts', null);
//   }
// }
