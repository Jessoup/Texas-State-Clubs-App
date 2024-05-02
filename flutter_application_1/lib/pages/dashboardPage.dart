import 'package:flutter/material.dart';
import './myClubsPage.dart';
import './myEventsPage.dart';
import 'ExploreClubsPage.dart';
import '../api/api.dart';  // Ensure the API class is imported
import '../services/token_storage.dart';

class Dashboard extends StatelessWidget {
  final TokenStorage _tokenStorage = TokenStorage();
  final api _api = api();  // Create an instance of Api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 131, 9, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/logo.png',  // Replace this with your logo file path
                height: 100,
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, MyClubsPage()),
              child: dashboardCard('My Clubs', 'View your clubs'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => navigateToPage(context, ExploreClubsPage()),
              child: dashboardCard('Explore Clubs', 'Discover new clubs'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => navigateToPage(context, MyEventsPage()),
              child: dashboardCard('My Events', 'View all attending events'),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(String title, String subtitle) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(subtitle),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToPage(BuildContext context, Widget page) async {
    String? token = await _api.getValidToken();
    if (token != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    } else {
      _showLoginPrompt(context);
    }
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session Expired'),
        content: Text('Please log in again to continue.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();  // Dismiss the dialog and potentially navigate to the login page
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
