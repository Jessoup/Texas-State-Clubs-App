import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../urls.dart';

class api {

  

  Future<List<User>?> getUsers() async {
    var client = http.Client();

    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.usersEndpoint);
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return userFromJson(json);
    }
  }

  Future<

}
