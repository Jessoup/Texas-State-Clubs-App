import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/events.dart';

void main() {
  group('PaginatedEvents', () {
    test('fromJson creates a valid PaginatedEvents', () {
      final Map<String, dynamic> jsonData = {
        "count": 2,
        "next": null,
        "previous": null,
        "results": [
          {
            "id": 1,
            "eventName": "Event 1",
            "timeStart": "2024-05-01T10:00:00Z",
            "timeEnd": "2024-05-01T12:00:00Z",
            "location": "Location 1",
            "attendees": [{"email": "attendee1@example.com"}]
          },
          {
            "id": 2,
            "eventName": "Event 2",
            "timeStart": "2024-05-02T10:00:00Z",
            "timeEnd": "2024-05-02T12:00:00Z",
            "location": "Location 2",
            "attendees": [{"email": "attendee2@example.com"}]
          }
        ]
      };

      final paginatedEvents = PaginatedEvents.fromJson(jsonData);

      expect(paginatedEvents.count, 2);
      expect(paginatedEvents.next, null);
      expect(paginatedEvents.previous, null);
      expect(paginatedEvents.results.length, 2);

      final event1 = paginatedEvents.results[0];
      expect(event1.id, 1);
      expect(event1.eventName, "Event 1");
      expect(event1.timeStart, DateTime.utc(2024, 5, 1, 10, 0, 0));
      expect(event1.timeEnd, DateTime.utc(2024, 5, 1, 12, 0, 0));
      expect(event1.location, "Location 1");
      expect(event1.attendees.length, 1);
      expect(event1.attendees[0].email, "attendee1@example.com");

      final event2 = paginatedEvents.results[1];
      expect(event2.id, 2);
      expect(event2.eventName, "Event 2");
      expect(event2.timeStart, DateTime.utc(2024, 5, 2, 10, 0, 0));
      expect(event2.timeEnd, DateTime.utc(2024, 5, 2, 12, 0, 0));
      expect(event2.location, "Location 2");
      expect(event2.attendees.length, 1);
      expect(event2.attendees[0].email, "attendee2@example.com");
    });

    test('toJson returns valid JSON', () {
      final paginatedEvents = PaginatedEvents(
        count: 2,
        next: null,
        previous: null,
        results: [
          Event(
            id: 1,
            eventName: "Event 1",
            timeStart: DateTime.utc(2024, 5, 1, 10, 0, 0),
            timeEnd: DateTime.utc(2024, 5, 1, 12, 0, 0),
            location: "Location 1",
            attendees: [Attendee(email: "attendee1@example.com")],
          ),
          Event(
            id: 2,
            eventName: "Event 2",
            timeStart: DateTime.utc(2024, 5, 2, 10, 0, 0),
            timeEnd: DateTime.utc(2024, 5, 2, 12, 0, 0),
            location: "Location 2",
            attendees: [Attendee(email: "attendee2@example.com")],
          ),
        ],
      );

      final jsonData = paginatedEvents.toJson();

      expect(jsonData['count'], 2);
      expect(jsonData['next'], null);
      expect(jsonData['previous'], null);
      expect(jsonData['results'].length, 2);

      final event1 = jsonData['results'][0];
      expect(event1['id'], 1);
      expect(event1['eventName'], "Event 1");
      expect(event1['timeStart'], "2024-05-01T10:00:00.000Z");
      expect(event1['timeEnd'], "2024-05-01T12:00:00.000Z");
      expect(event1['location'], "Location 1");
      expect(event1['attendees'].length, 1);
      expect(event1['attendees'][0]['email'], "attendee1@example.com");

      final event2 = jsonData['results'][1];
      expect(event2['id'], 2);
      expect(event2['eventName'], "Event 2");
      expect(event2['timeStart'], "2024-05-02T10:00:00.000Z");
      expect(event2['timeEnd'], "2024-05-02T12:00:00.000Z");
      expect(event2['location'], "Location 2");
      expect(event2['attendees'].length, 1);
      expect(event2['attendees'][0]['email'], "attendee2@example.com");
    });
  });
}