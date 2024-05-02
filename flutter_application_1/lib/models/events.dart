import 'dart:convert';

PaginatedEvents paginatedEventsFromJson(String str) => PaginatedEvents.fromJson(json.decode(str));
String paginatedEventsToJson(PaginatedEvents data) => json.encode(data.toJson());

class PaginatedEvents {
  int count;
  String? next;
  String? previous;
  List<Event> results;

  PaginatedEvents({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PaginatedEvents.fromJson(Map<String, dynamic> json) => PaginatedEvents(
    count: json['count'],
    next: json['next'],
    previous: json['previous'],
    results: List<Event>.from(json['results'].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Event {
  int id;
  String eventName;
  DateTime timeStart;
  DateTime timeEnd;
  String location;
  List<Attendee> attendees;

  Event({
    required this.id,
    required this.eventName,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.attendees,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    eventName: json['eventName'],
    timeStart: DateTime.parse(json['timeStart']),
    timeEnd: DateTime.parse(json['timeEnd']),
    location: json['location'],
    attendees: List<Attendee>.from(json['attendees'].map((x) => Attendee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'eventName': eventName,
    'timeStart': timeStart.toIso8601String(),
    'timeEnd': timeEnd.toIso8601String(),
    'location': location,
    'attendees': List<dynamic>.from(attendees.map((x) => x.toJson())),
  };
}

class Attendee {
  String email;

  Attendee({
    required this.email,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) => Attendee(
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}
