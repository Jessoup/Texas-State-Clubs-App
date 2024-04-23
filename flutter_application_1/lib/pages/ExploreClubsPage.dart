import 'package:flutter/material.dart';
import '../api/api.dart'; // Ensure this import path is correct
import '../models/clubs.dart'; // Ensure this import path is correct

class ExploreClubsPage extends StatefulWidget {
  @override
  _ExploreClubsPageState createState() => _ExploreClubsPageState();
}

class _ExploreClubsPageState extends State<ExploreClubsPage> {
  // Create an instance of the API class
  api apiCalls = api();  // Note: Make sure the class name matches what's in api.dart

  // Updated to handle a list of clubs
  Future<List<Club>> _fetchClubs() {
    return apiCalls.getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Clubs'),
      ),
      body: FutureBuilder<List<Club>>(
        future: _fetchClubs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,  // Updated to use length of list directly
              itemBuilder: (context, index) {
                Club club = snapshot.data![index];  // Accessing clubs directly from list
                return ListTile(
                  title: Text(club.clubName),
                  subtitle: Text(club.clubDescription),
                );
              },
            );
          } else {
            return Text("No clubs found");
          }
        },
      ),
    );
  }
}
