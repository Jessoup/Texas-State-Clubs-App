import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/login.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../urls.dart';
import '../models/signup.dart';
import '../models/user.dart';

class api {

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
  
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.loginEndpoint);
    var response = await http.post(uri, body: requestModel.toJson());
    if(response.statusCode == 200){
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load Data');
    }
  }

  Future<SignupResponseModel> signup(User requestModel) async {
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.signupEndpoint);
    var response = await http.post(uri, body: requestModel.toJson());
    if(response.statusCode == 200){
      return SignupResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load Data');
    }
  }
}