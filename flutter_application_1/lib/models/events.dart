import 'dart:convert';

// Adjusted to handle paginated API response
List<Event> eventFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Event>.from(jsonData['results'].map((x) => Event.fromJson(x)));
}

String EventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  int    id; // Change the variable name to id
  String eventName;
  String timeStart;
  String timeEnd;
  String location;
  int    clubID;
  bool   reoccurring;

  Event({
    required this.id,
    required this.eventName,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.clubID,
    required this.reoccurring,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json.containsKey('eventID') ? json['eventID'] : json['id'], // Use conditional operator to handle both cases
        eventName: json['eventName'],
        timeStart: json['timeStart'],
        timeEnd: json['timeEnd'],
        location: json['location'],
        clubID: json['clubID'],
        reoccurring: json['reoccurring'],
      );

  Map<String, dynamic> toJson() => {
        'id':              id,
        'eventName':       eventName,
        'timeStart':       timeStart,
        'timeEnd':         timeEnd,
        'location':        location,
        'clubID':          clubID,
        'reoccurring':     reoccurring,
      };
}

