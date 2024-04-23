import 'package:flutter/material.dart';
import '../api/api.dart'; // Ensure this import path is correct
import '../models/clubs.dart'; // Ensure this import path is correct

class ExploreClubsPage extends StatefulWidget {
  @override
  _ExploreClubsPageState createState() => _ExploreClubsPageState();
}

class _ExploreClubsPageState extends State<ExploreClubsPage> {
  api apiCalls = api();

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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return clubCard(snapshot.data![index]);
              },
            );
          } else {
            return Text("No clubs found");
          }
        },
      ),
    );
  }

  Widget clubCard(Club club) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              club.clubName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(club.clubDescription),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here you could implement functionality to add this club
                print("Add Club: ${club.clubName}");
              },
              child: Text('Join Club'),
            )
          ],
        ),
      ),
    );
  }
}