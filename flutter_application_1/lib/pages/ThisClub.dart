import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/clubs.dart';
import '../models/events.dart'; // Ensure this import is correct
import 'package:intl/intl.dart';

class ThisClub extends StatefulWidget {
  final Club club;

  ThisClub({required this.club});

  @override
  _ThisClubState createState() => _ThisClubState();
}

class _ThisClubState extends State<ThisClub> {
  late Future<List<Event>> clubEvents;
  api apiCalls = api();

  @override
  void initState() {
    super.initState();
    clubEvents = apiCalls.getClubEvents(widget.club.id);
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        widget.club.clubName,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 131, 9, 1),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    body: FutureBuilder<List<Event>>(
      future: clubEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Event event = snapshot.data![index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 10),  // Provides space between rows
                child: InkWell(
                  onTap: () {},  // Optionally handle tap
                  child: Padding(
                    padding: EdgeInsets.all(16),  // Adjust padding for aesthetics
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.eventName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,  // Slightly larger text for the event name
                          ),
                        ),
                        SizedBox(height: 5),  // Space between text lines
                        Text(
                          "Starts: ${DateFormat('yyyy-MM-dd – kk:mm').format(event.timeStart.toLocal())}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Location: ${event.location}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              bool attended = await apiCalls.attendEvent(event.id);
                              if (attended) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('You are now attending ${event.eventName}!'))
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to attend event: $e'))
                              );
                            }
                          },
                          child: Text('Attend'),
                          style: ElevatedButton.styleFrom(
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No events found"));
        }
      },
    ),
  );
}
}