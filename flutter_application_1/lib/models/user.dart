// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String email;
    String firstName;
    String lastName;
    String password;

    User({
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],        
        firstName: json["firstName"],
        lastName: json["lastName"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
    };
}
