// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String email;
    String first_name;
    String last_name;
    String password;

    User({
        required this.email,
        required this.first_name,
        required this.last_name,
        required this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],        
        first_name: json["first_name"],
        last_name: json["last_name"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
        "password": password,
    };
}
