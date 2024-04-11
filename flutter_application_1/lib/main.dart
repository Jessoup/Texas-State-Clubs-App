import 'package:flutter/material.dart';
import 'api_services.dart'; // Make sure this is pointing correctly to your ApiService file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService(); // Add ApiService instance

  void _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    if (await apiService.loginUser(username, password)) { // Use ApiService for login
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),);
    } else {
      // Show an error message or handle invalid credentials here.
      final snackBar = SnackBar(content: Text('Invalid username or password!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/logo.png', // Replace this with your logo file path
                height: 100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyClubsPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'My Clubs',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('View your clubs'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Explore Clubs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(''),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Upcoming Events'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClubsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Clubs'),
      ),
      body: Align(
        alignment: Alignment.topCenter, // Aligns the card to the top center
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adds some space from the top
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Adds some padding inside the card
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use the smallest space
                children: <Widget>[
                  Text(
                    'TXST Running Club',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Meeting Monday at 5:30',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
