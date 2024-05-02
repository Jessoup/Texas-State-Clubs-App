import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/clubs.dart';
import '../pages/ThisClub.dart';  // Ensure this is the correct path

class MyClubsPage extends StatefulWidget {
  MyClubsPage();

  @override
  _MyClubsPageState createState() => _MyClubsPageState();
}

class _MyClubsPageState extends State<MyClubsPage> {
  api apiCalls = api(); // Correct the instance creation
  Future<List<Club>>? myClubs;

  @override
  void initState() {
    super.initState();
    myClubs = _fetchMyClubs();
  }

  Future<List<Club>> _fetchMyClubs() async {
    return apiCalls.getMyClubs();  // This assumes getMyClubs handles token retrieval internally
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Clubs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 131, 9, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Club>>(
        future: myClubs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ClubCard(snapshot.data![index]);
              },
            );
          } else {
            return Center(child: Text("No clubs found"));
          }
        },
      ),
    );
  }

  Widget ClubCard(Club club) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              club.clubName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              club.clubDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String? token = await apiCalls.getValidToken();
                      if (token != null) {
                        try {
                          bool left = await apiCalls.leaveClub(club.id, token);
                          if (left) {
                            setState(() {
                              myClubs = _fetchMyClubs();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully left the club')));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to leave club: ${e.toString()}')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Authentication needed')));
                      }
                    },
                    child: Text('Leave Club'),
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ThisClub(club: club)));
                    },
                    child: Text('View Club'),
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
