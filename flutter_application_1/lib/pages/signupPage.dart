import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/signup.dart';
import '../api/api.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // creating api class object
  api apiCalls = api();
  final _formKey = GlobalKey<FormState>();
  final _user = User(email: '', first_name: '', last_name: '', password: '');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _emailError;

  Future<void> _signup() async {
    User user = User(
      email: _emailController.text,
      first_name: _firstNameController.text,
      last_name: _lastNameController.text,
      password: _passwordController.text,
    );

    SignupResponseModel response; //= await apiCalls.signup(user);
    try {
      response = await apiCalls.signup(user);
      // Printing the response for demonstration
      print("Signup Response: ${signupResponseModelToJson(response)}");

      if (response.message == "User Created Successfully") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (response.errors != null) {
        setState(() {
          _emailError = response.errors![0];
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid Registration"),
              content: Text("Registration Failed."),
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
    } catch (e) {
      print("Error during signup: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An error occurred during registration."),
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
        title: Text('User Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email', errorText: _emailError),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // You can add more complex email validation here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _user.email = value!;
                  },
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _user.first_name = value!;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _user.last_name = value!;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _user.password = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // You can do something with the user data here, e.g., save to a database
                              print('User registered: $_user');
                              _signup();
                            }
                          },
                          child: Text('Register'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text('Already have an account? Sign in'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}