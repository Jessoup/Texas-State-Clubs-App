import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/events.dart';  // Make sure the Event model fits your data structure

class MyEventsPage extends StatefulWidget {
  MyEventsPage();

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  api apiCalls = api();

  Future<List<Event>> _fetchEvents() async {
    return apiCalls.getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
      ),
      body: FutureBuilder<List<Event>>(
        future: _fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
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
            Text('Start: ${event.timeStart.toLocal()}'),
            Text('End: ${event.timeEnd.toLocal()}'),
            Text('Location: ${event.location}'),
            Text('Attendees: ${event.attendees.map((a) => a.email).join(', ')}'),
            SizedBox(height: 20),
            // Additional widgets for event handling can be added here
          ],
        ),
      ),
    );
  }
}
