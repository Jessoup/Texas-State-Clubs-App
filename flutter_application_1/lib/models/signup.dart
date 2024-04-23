import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) => SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) => json.encode(data.toJson());

class SignupResponseModel {
    String message;
    Data? data;

    SignupResponseModel({
        required this.message,
        this.data,
    });

    factory SignupResponseModel.fromJson(Map<String, dynamic> json) => SignupResponseModel(
        message: json["message"],
        data: json.containsKey("data") ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "tokens": data?.toJson(),
    };
}

class Data {
    String email;
    String first_name;
    String last_name;

    Data({
        required this.email,
        required this.first_name,
        required this.last_name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        first_name: json["first_name"],
        last_name: json["last_name"]
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
    };
}