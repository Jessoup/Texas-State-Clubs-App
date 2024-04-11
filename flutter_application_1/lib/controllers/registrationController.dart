import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController{
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> register() async{
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiUrls.baseUrl + ApiUrls.createEndpoint);
      Map body = {
        'firstName': firstnameController.text,
        'lastName': lastnameController.text,
        'userName': usernameController.text,
        'password': passwordController.text,
        'email': emailController.text
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200){
        final json = jsonDecode(response.body);
      }
    } catch (e) {}
  }
}