import 'package:flutter/material.dart';
import '../api/api.dart';  // Assuming 'api.dart' contains a class 'Api' with required methods
import '../models/events.dart';  // Ensure the Event model fits your data structure

class MyEventsPage extends StatefulWidget {
  MyEventsPage({Key? key}) : super(key: key);

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  late Future<List<Event>> _eventsFuture;
  late api apiCalls; // Define an instance of your API class

  @override
  void initState() {
    super.initState();
    apiCalls = api();  // Instantiate your API class
    _eventsFuture = apiCalls.getMyEvents();  // Fetch events on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshEvents(), // Refresh button to reload events
          )
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return eventCard(snapshot.data![index]);
              },
            );
          } else {
            return Center(child: Text("No events found"));
          }
        },
      ),
    );
  }

  void _refreshEvents() {
    setState(() {
      _eventsFuture = apiCalls.getMyEvents();
    });
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
          ],
        ),
      ),
    );
  }
}
