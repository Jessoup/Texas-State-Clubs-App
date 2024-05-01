import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../urls.dart';
import '../models/login.dart';
import '../models/signup.dart';
import '../models/user.dart';
import '../models/clubs.dart';
import '../services/token_storage.dart'; 
import 'package:jwt_decode/jwt_decode.dart';
import '../models/events.dart';
class api {
  final TokenStorage _tokenStorage = TokenStorage();

  void checkToken(String token) {
    if (Jwt.isExpired(token)) {
      print("Token is expired");
      // Handle token expiration (e.g., refresh the token or prompt re-login)
    } else {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      print("Token payload: $payload");
      // Further actions depending on the token payload
    }
  }
  // Handles user login 

    Future<List<dynamic>> _fetchPaginatedData(String initialUrl) async {
    List<dynamic> allData = [];
    String? nextPageUrl = initialUrl;
    String? token = await getValidToken();
    if (token == null) {
      throw Exception('Authentication required');
    }

    while (nextPageUrl != null) {
      var response = await http.get(Uri.parse(nextPageUrl), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        allData.addAll(jsonData['results']);
        nextPageUrl = jsonData['next'];
      } else {
        throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
      }
    }

    return allData;
  }
  
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.loginEndpoint);
    var response = await http.post(uri, body: requestModel.toJson());

    print('Login Response: ${response.body}');
    print('Login Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody.containsKey('tokens')) {
        var tokens = responseBody['tokens'];
        var accessToken = tokens['access'];
        var refreshToken = tokens['refresh'];
        var expiry = DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000; // Assuming token expires in 2 hours
        await _tokenStorage.saveToken(accessToken, expiry);
        await _tokenStorage.saveRefreshToken(refreshToken);
        return LoginResponseModel.fromJson(responseBody);
      } else {
        throw Exception('Access token not found in response body');
      }
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode}');
    }
  }

// Handles user signup
Future<SignupResponseModel> signup(User requestModel) async {
  var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.signupEndpoint);
  var response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(requestModel.toJson()),
  );
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 201) {
    return SignupResponseModel.fromJson(json.decode(response.body));
  } else if (response.statusCode == 400) {
    return SignupResponseModel.fromJson(json.decode(response.body));
  } else {
    print("Failed to load data. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to load Data');
  }
}


  // Attempts to refresh the JWT token
  Future<bool> tryRefreshToken() async {
    var refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    var response = await http.post(
      Uri.parse('${ApiUrls.baseUrl}/api/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refresh': refreshToken})
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var accessToken = data['access'];
      var expiry = DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000; // Assuming token expires in 2 hours
      await _tokenStorage.saveToken(accessToken, expiry);
      return true;
    } else {
      print('Failed to refresh token: ${response.body}');
      return false;
    }
  }

  // Checks if the current token needs to be refreshed
  Future<bool> tokenNeedsRefresh() async {
    int? expiry = await _tokenStorage.getTokenExpiry();
    if (expiry == null) return true;

    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return currentTime >= expiry - 60;  // Refresh if less than 60 seconds left
  }

  // Ensures a valid token is always used for API calls
  Future<String?> getValidToken() async {
    String? token = await _tokenStorage.getToken();
    if (token == null || await tokenNeedsRefresh()) {
      bool refreshed = await tryRefreshToken();
      if (!refreshed) return null;
      token = await _tokenStorage.getToken();
    }
    return token;
  }

  // API call to fetch clubs
Future<List<Club>> getClubs() async {
  String? token = await getValidToken();
  if (token == null) {
    throw Exception('Authentication required');
  }
  var uri = Uri.parse(ApiUrls.baseUrl + ApiUrls.clubsEndpoint);
  var response = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    // Modify the parsing logic to handle "id" key
    List<dynamic> jsonData = json.decode(response.body);
    List<Club> clubs = jsonData.map((data) => Club.fromJson(data)).toList();
    return clubs;
  } else {
    throw Exception('Failed to load clubs. Status code: ${response.statusCode}');
  }
}

  // API call to join a club
  Future<bool> joinClub(int clubId, String token) async {
    var uri = Uri.parse('${ApiUrls.baseUrl}${ApiUrls.joinClubEndpoint}$clubId/');
    var response = await http.post(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to join club. Status code: ${response.statusCode}');
    }
  }

  // API call to leave a club
  Future<bool> leaveClub(int clubId, String token) async {
    var uri = Uri.parse('${ApiUrls.baseUrl}${ApiUrls.leaveClubEndpoint}$clubId/');
    var response = await http.delete(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to leave club. Status code: ${response.statusCode}');
    }
  }

// API call to fetch user's clubs
Future<List<Club>> getMyClubs() async {
  String? token = await getValidToken();
  if (token == null) {
    throw Exception('Authentication required');
  }

  List<Club> allClubs = [];
  String? nextUrl = ApiUrls.baseUrl + ApiUrls.myClubsEndpoint;

  while (nextUrl != null) {
    var uri = Uri.parse(nextUrl);
    var response = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Club> clubs = List<Club>.from(jsonData['results'].map((x) => Club.fromJson(x)));
      allClubs.addAll(clubs);
      nextUrl = jsonData['next']; // Update the nextUrl with the URL provided for the next page
    } else {
      throw Exception('Failed to load user clubs. Status code: ${response.statusCode}');
    }
  }

  return allClubs;
}


Future<List<Event>> getMyEvents() async {
  String? token = await getValidToken();
  if (token == null) {
    throw Exception('Authentication required');
  }

  List<Event> allEvents = [];
  String? nextUrl = ApiUrls.baseUrl + ApiUrls.myEventsEndpoint;

  while (nextUrl != null) {
    var uri = Uri.parse(nextUrl);
    var response = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Event> events = List<Event>.from(jsonData['results'].map((x) => Event.fromJson(x)));
      allEvents.addAll(events);
      nextUrl = jsonData['next']; // Update the nextUrl with the URL provided for the next page
    } else {
      throw Exception('Failed to load user events. Status code: ${response.statusCode}');
    }
  }

  return allEvents;
}

Future<List<Event>> getClubEvents(int clubId) async {
  String? token = await getValidToken();
  if (token == null) {
    throw Exception('Authentication required');
  }

  List<Event> allEvents = [];
  String? nextUrl = ApiUrls.baseUrl + ApiUrls.getClubEvents(clubId);

  while (nextUrl != null) {
    var uri = Uri.parse(nextUrl);
    var response = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Event> events = List<Event>.from(jsonData['results'].map((x) => Event.fromJson(x)));
      allEvents.addAll(events);
      nextUrl = jsonData['next']; // Update the nextUrl with the URL provided for the next page
    } else {
      throw Exception('Failed to load club events. Status code: ${response.statusCode}');
    }
  }

  return allEvents;
}

Future<bool> attendEvent(int eventId) async {
  String? token = await getValidToken();
  if (token == null) {
    throw Exception('Authentication required');
  }
  var uri = Uri.parse('${ApiUrls.baseUrl}${ApiUrls.attendEvent(eventId)}');
  var response = await http.post(uri, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });

  if (response.statusCode == 201) {
    return true;  // Correctly handling HTTP 201 as a success
  } else {
    print('Failed to attend event. Status code: ${response.statusCode}, Body: ${response.body}');
    throw Exception('Failed to attend event. Status code: ${response.statusCode}');
  }
}
}