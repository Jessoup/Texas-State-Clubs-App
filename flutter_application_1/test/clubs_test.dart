import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/clubs.dart';
import 'dart:convert';

void main() {
  group('Club', () {
    test('fromJson creates a valid Club', () {
      final Map<String, dynamic> jsonData = {
        "id": 1,
        "clubName": "Club 1",
        "clubDescription": "Description for Club 1"
      };

      final club = Club.fromJson(jsonData);

      expect(club.id, 1);
      expect(club.clubName, "Club 1");
      expect(club.clubDescription, "Description for Club 1");
    });

    test('toJson returns valid JSON', () {
      final club = Club(
        id: 1,
        clubName: "Club 1",
        clubDescription: "Description for Club 1",
      );

      final jsonData = club.toJson();

      expect(jsonData['id'], 1);
      expect(jsonData['clubName'], "Club 1");
      expect(jsonData['clubDescription'], "Description for Club 1");
    });

    test('fromJson handles clubID field', () {
      final Map<String, dynamic> jsonData = {
        "clubID": 1,
        "clubName": "Club 1",
        "clubDescription": "Description for Club 1"
      };

      final club = Club.fromJson(jsonData);

      expect(club.id, 1);
      expect(club.clubName, "Club 1");
      expect(club.clubDescription, "Description for Club 1");
    });
  });

  group('clubFromJson', () {
    test('parses JSON list to list of Club objects', () {
      final jsonString = '''
        {
          "results": [
            {"id": 1, "clubName": "Club 1", "clubDescription": "Description for Club 1"},
            {"id": 2, "clubName": "Club 2", "clubDescription": "Description for Club 2"}
          ]
        }
      ''';

      final clubs = clubFromJson(jsonString);

      expect(clubs.length, 2);
      expect(clubs[0].id, 1);
      expect(clubs[0].clubName, "Club 1");
      expect(clubs[0].clubDescription, "Description for Club 1");
      expect(clubs[1].id, 2);
      expect(clubs[1].clubName, "Club 2");
      expect(clubs[1].clubDescription, "Description for Club 2");
    });
  });

  test('clubToJson converts list of Club objects to JSON', () {
    final clubs = [
      Club(id: 1, clubName: "Club 1", clubDescription: "Description for Club 1"),
      Club(id: 2, clubName: "Club 2", clubDescription: "Description for Club 2")
    ];

    final jsonString = clubToJson(clubs);

    final List<dynamic> jsonData = json.decode(jsonString);
    expect(jsonData.length, 2);
    expect(jsonData[0]['id'], 1);
    expect(jsonData[0]['clubName'], "Club 1");
    expect(jsonData[0]['clubDescription'], "Description for Club 1");
    expect(jsonData[1]['id'], 2);
    expect(jsonData[1]['clubName'], "Club 2");
    expect(jsonData[1]['clubDescription'], "Description for Club 2");
  });
}