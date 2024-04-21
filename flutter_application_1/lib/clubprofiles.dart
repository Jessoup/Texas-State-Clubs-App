//clubprofiles.dart
import 'package:flutter/material.dart';

class ClubProfilePage extends StatelessWidget {
  // You can pass club data using the constructor
  final String clubName;
  final String clubDescription;
  final String clubImageUrl; // Optional image URL

  ClubProfilePage({ required this.clubName, required this.clubDescription, required this.clubImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          if (clubImageUrl != "")
            Image.network(clubImageUrl), // Display the image if available
          SizedBox(height: 20),
          Text(
            clubDescription,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add join functionality later
            },
            child: Text('Join Club'),
          ),
        ],
      ),
    );
  }
}
