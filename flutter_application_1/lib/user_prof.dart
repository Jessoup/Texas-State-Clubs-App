import 'package:flutter/material.dart';

class UserP extends StatelessWidget {
  final String firstname = '';
  final String lastname = '';
  final String username;
  final String email = '';
  final String userDescrip = '';

  UserP({
    this.username = 'ael88',
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Center(
        child: Text('this is your user profile: $username'),
      ),
    );
  }
}