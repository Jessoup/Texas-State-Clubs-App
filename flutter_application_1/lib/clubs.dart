import 'package:flutter/material.dart';

class Club extends StatelessWidget{
  final int clubID;
  final String clubName;
  final String clubDescrip;

  Club({
    required this.clubID,
    required this.clubName,
    required this.clubDescrip
  });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubName),
      ),
      body: Center(
        child: Text('welcome to this $clubName club page'),
      )
    );
  }
}