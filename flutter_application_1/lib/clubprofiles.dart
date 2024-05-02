import 'package:flutter/material.dart';

class ClubProfilePage extends StatelessWidget {
  final String clubName;
  final String clubDescription;
  final String clubImageUrl;

  ClubProfilePage(
      {required this.clubName,
      required this.clubDescription,
      required this.clubImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubName),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              if (clubImageUrl != "")
                Image.network(clubImageUrl), // Display the image if available
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    clubDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Add join functionality later
              },
              child: Text('Join Club'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
