import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/events.dart';
import '../models/user.dart';
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
        title: Text(
          'My Events',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 131, 9, 1),
        iconTheme: IconThemeData(color: Colors.white),
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
          Text(
            'Location: ${event.location}',
            style: TextStyle(
              color: Colors.blue,
            )
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Add logic to view attendees
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendeesPage(attendees: event.attendees)),
                  );
                },
                child: Text('View Attendees'),
              ),
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
        ],
      ),
    ),
  );
}
  void _viewAttendees(BuildContext context, List<Attendee> attendees) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attendees"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (var attendee in attendees)
                  ListTile(
                    title: Text(attendee.email),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

// Attendees Page
class AttendeesPage extends StatelessWidget {
  final List<Attendee> attendees;
  AttendeesPage({required this.attendees});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendees'),
      ),
      body: ListView.builder(
        itemCount: attendees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(attendees[index].email),
          );
        },
      ),
    );
  }
}