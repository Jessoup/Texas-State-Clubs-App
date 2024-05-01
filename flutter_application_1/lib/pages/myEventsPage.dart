import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/events.dart';

class MyEventsPage extends StatefulWidget {
  MyEventsPage();

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  api apiCalls = api();

  Future<List<Event>> _authenticate() async {
    String? token = await apiCalls.getValidToken();
    if (token == null) {
      throw Exception('Authentication required');
    }
    return apiCalls.getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
      ),
      body: FutureBuilder<List<Event>>(
        future: _authenticate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return eventCard(snapshot.data![index]);
              },
            );
          } else {
            return Text("No events found");
          }
        },
      ),
    );
  }

  Widget eventCard(Event event) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.eventName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(event.timeStart),
            Text(event.timeEnd),
            Text(event.location),
            SizedBox(height: 20),
            /*
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
            */
          ],
        ),
      ),
    );
  }
}
