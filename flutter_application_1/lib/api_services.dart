import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:8000"; // Replace with your actual Django backend URL

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users/'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/create/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode == 201) {
      print('User created successfully');
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(String pk, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$pk/update/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String pk) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$pk/delete/'),
    );
    if (response.statusCode == 204) { // Adjust based on your API's response
      print('User deleted successfully');
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<dynamic> getUser(String pk) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$pk/'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }
Future<bool> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Login failed with status: ${response.statusCode} and reason: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Login exception: $e');
      return false;
    }
}

}
