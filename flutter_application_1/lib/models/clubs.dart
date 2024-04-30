// clubs.dart
import 'dart:convert';

// Adjusted to handle paginated API response
List<Club> clubFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Club>.from(jsonData['results'].map((x) => Club.fromJson(x)));
}

String clubToJson(List<Club> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  int id; // Change the variable name to id
  String clubName;
  String clubDescription;

  Club({
    required this.id,
    required this.clubName,
    required this.clubDescription,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json.containsKey('clubID') ? json['clubID'] : json['id'], // Use conditional operator to handle both cases
        clubName: json['clubName'],
        clubDescription: json['clubDescription'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubName': clubName,
        'clubDescription': clubDescription,
      };
}



