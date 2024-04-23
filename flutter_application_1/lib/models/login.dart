import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String message;
    Tokens? tokens;

    LoginResponseModel({
        required this.message,
        this.tokens,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json["message"],
        tokens: json.containsKey("tokens") ? Tokens.fromJson(json["tokens"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "tokens": tokens?.toJson(),
    };
}

class Tokens {
    String access;
    String refresh;

    Tokens({
        required this.access,
        required this.refresh,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"],
        refresh: json["refresh"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
    };
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}