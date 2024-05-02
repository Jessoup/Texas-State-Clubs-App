import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/clubs.dart';

class ExploreClubsPage extends StatefulWidget {
  ExploreClubsPage();

  @override
  _ExploreClubsPageState createState() => _ExploreClubsPageState();
}

class _ExploreClubsPageState extends State<ExploreClubsPage> {
  api apiCalls = api();

  Future<List<Club>> _fetchClubs() async {
    String? token = await apiCalls.getValidToken();
    if (token == null) {
      throw Exception('Authentication required');
    }
    return apiCalls.getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Clubs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 131, 9, 1),
        iconTheme: IconThemeData(color: Colors.white),
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
              onPressed: () async {
                try {
                  String? token = await apiCalls.getValidToken();
                  if (token != null) {
                    bool joined = await apiCalls.joinClub(club.id, token);
                    if (joined) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully joined ${club.clubName}')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Authentication needed')));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to join club: ${e.toString()}')));
                }
              },
              child: Text('Join Club'),
            )
          ],
        ),
      ),
    );
  }
}
