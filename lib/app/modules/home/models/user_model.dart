import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String imageUrl;

  User({
    this.uid,
    this.name,
    this.email,
    this.imageUrl,
  });

  User.fromDoc(QueryDocumentSnapshot doc) {
    uid = doc.id;
    name = doc.data()['name'];
    email = doc.data()['email'];
    imageUrl = doc.data()['imageUrl'];
  }

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['imageUrl'] = imageUrl;

    return data;
  }
}
