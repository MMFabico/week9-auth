import 'dart:convert';

class User {
  String? email;
  String? fname;
  String? lname;

  User({required this.email, required this.fname, required this.lname});

  // Factory constructor to instantiate object from json format
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'], fname: json['fname'], lname: json['lname']);
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'email': user.email,
      'fname': user.fname,
      'lname': user.lname,
    };
  }
}
