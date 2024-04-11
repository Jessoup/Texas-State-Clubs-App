import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'pages/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => MyApp()),
      GetPage(name: '/login', page: () => LoginPage(), transition: Transition.rightToLeft),
      GetPage(name: '/homePage', page: () => HomePage()),
    ]
  ));
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}