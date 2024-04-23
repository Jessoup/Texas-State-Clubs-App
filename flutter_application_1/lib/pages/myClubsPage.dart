import 'package:flutter/material.dart';

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