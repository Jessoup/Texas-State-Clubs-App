import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/login.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../urls.dart';
import '../models/signup.dart';
import '../models/user.dart';
import '../models/clubs.dart'; 

class api {

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.loginEndpoint);
    var response = await http.post(uri, body: requestModel.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<SignupResponseModel> signup(User requestModel) async {
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.signupEndpoint);
    var response = await http.post(uri, body: requestModel.toJson());
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      return SignupResponseModel.fromJson(json.decode(response.body));
    }
    else if (response.statusCode == 400){
      return SignupResponseModel.fromJson(json.decode(response.body));
    } else {
      print("Failed to load data. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Club>> getClubs() async {
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.clubsEndpoint);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return clubFromJson(response.body); // This line has been updated
    } else {
      throw Exception('Failed to load clubs');
    }
  }
}