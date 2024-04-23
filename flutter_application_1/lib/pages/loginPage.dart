import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/login.dart';
import 'dashboardPage.dart';
import 'signupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // creating api class object
  api apiCalls = api();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  LoginRequestModel request = LoginRequestModel(
    email: _emailController.text,
    password: _passwordController.text,
  );

  // using login call to get response
  LoginResponseModel response = await apiCalls.login(request);

  // Printing the response for demonstration
  print("Login Response: ${loginResponseModelToJson(response)}");

  if (response.message == "Login Successfull") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  } else {
    // Show invalid email or password message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Credentials"),
          content: Text("The email or password you entered is incorrect."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text('Create an account'),
            )
          ],
        ),
      ),
    );
  }
}