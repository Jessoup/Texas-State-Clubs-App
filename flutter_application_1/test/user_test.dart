import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/user.dart'; // Import your User model class

void main() {
  group('User Serialization/Deserialization:', () {
    test('User serialization', () {
      // Create a sample User object
      User user = User(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password123',
      );

      // Convert the User object to JSON
      Map<String, dynamic> json = user.toJson();

      // Check if the JSON contains the correct values
      expect(json['email'], 'test@example.com');
      expect(json['first_name'], 'John');
      expect(json['last_name'], 'Doe');
      expect(json['password'], 'password123');
    });

    test('User deserialization', () {
      // Sample JSON data representing a User
      Map<String, dynamic> jsonData = {
        "email": "test@example.com",
        "first_name": "John",
        "last_name": "Doe",
        "password": "password123"
      };

      // Deserialize the JSON into a User object
      User user = User.fromJson(jsonData);

      // Check if the User object has the correct properties
      expect(user.email, 'test@example.com');
      expect(user.first_name, 'John');
      expect(user.last_name, 'Doe');
      expect(user.password, 'password123');
    });
  });
}