// clubs.dart
import 'dart:convert';
// Assuming API returns a list of clubs directly
List<Club> clubFromJson(String str) => List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  int id;
  String clubName;
  String clubDescription;

  Club({
    required this.id,
    required this.clubName,
    required this.clubDescription,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json['id'],
        clubName: json['clubName'],
        clubDescription: json['clubDescription'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubName': clubName,
        'clubDescription': clubDescription,
      };
}
