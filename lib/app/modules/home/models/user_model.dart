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

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
