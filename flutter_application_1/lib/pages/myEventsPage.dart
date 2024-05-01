import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/events.dart';  // Make sure the Event model fits your data structure
import 'package:intl/intl.dart';

class MyEventsPage extends StatefulWidget {
  MyEventsPage({Key? key}) : super(key: key);

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  api apiCalls = api();
  Future<List<Event>>? myEvents;

  @override
  void initState() {
    super.initState();
    myEvents = _fetchMyEvents().catchError((error) {
      print('Error fetching events: $error');
    });
  }

  Future<List<Event>> _fetchMyEvents() async {
    return apiCalls.getMyEvents();
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
        future: _fetchMyEvents(),
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
      myEvents = apiCalls.getMyEvents();
    });
  }

  Widget eventCard(Event event) {
    DateFormat timeFormat = DateFormat('MMM dd h:mm a');
    String formattedStartTime = timeFormat.format(event.timeStart.toLocal());
    String formattedEndTime = timeFormat.format(event.timeEnd.toLocal());

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
            Text('Start: $formattedStartTime'),
            Text('End: $formattedEndTime'),
            Text('Location: ${event.location}'),
            Text('Attendees: ${event.attendees.map((a) => a.email).join(', ')}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String? token = await apiCalls.getValidToken();
                if (token != null) {
                  try {
                    bool removed = await apiCalls.removeEvent(event.id, token);
                    if (removed) {
                      setState(() {
                        myEvents = _fetchMyEvents();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully removed event')));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove event')));
                    print(e.toString());
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Authentication needed')));
                }
              },
              child: Text('Remove Event'),
            ),
          ],
        ),
      ),
    );
  }
}
