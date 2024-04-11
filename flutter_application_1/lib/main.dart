import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter/material.dart';
import 'pages/homePage.dart';

void main() {
  runApp(MyApp());
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
      home: const HomePage(),
    );
  }
}