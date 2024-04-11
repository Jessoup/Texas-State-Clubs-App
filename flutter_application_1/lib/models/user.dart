// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    int id;
    String firstName;
    String lastName;
    String userName;
    String password;
    bool isAdmin;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.userName,
        required this.password,
        required this.isAdmin,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        password: json["password"],
        isAdmin: json["isAdmin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "password": password,
        "isAdmin": isAdmin,
    };
}