import 'package:flutter/material.dart';
import '../pages/homePage.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    // Here you can add your login logic, such as checking credentials.
    // For simplicity, let's assume a successful login for any non-empty username/password.
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      Get.toNamed('homePage');
    } else {
      // Show an error message or handle invalid credentials here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              maxLines: 1, // Limit input to one line
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}