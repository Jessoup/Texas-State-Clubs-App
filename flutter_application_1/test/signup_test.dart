import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/signup.dart';

void main() {
  group('SignupResponseModel', () {
    test('fromJson should return SignupResponseModel instance', () {
      // Arrange
      final jsonData = {
        "message": "Success",
        "data": {"email": "example@example.com", "first_name": "John", "last_name": "Doe"}
      };

      // Act
      final response = SignupResponseModel.fromJson(jsonData);

      // Assert
      expect(response.message, "Success");
      expect(response.errors, isNull);
      expect(response.data, isNotNull);
      expect(response.data!.email, "example@example.com");
      expect(response.data!.first_name, "John");
      expect(response.data!.last_name, "Doe");
    });

    test('fromJson should return SignupResponseModel instance with errors', () {
      // Arrange
      final jsonData = {
        "errors": ["Email is already in use"]
      };

      // Act
      final response = SignupResponseModel.fromJson(jsonData);

      // Assert
      expect(response.message, isNull);
      expect(response.errors, isNotNull);
      expect(response.errors!.length, 1);
      expect(response.errors![0], "Email is already in use");
      expect(response.data, isNull);
    });

    test('toJson should return json string', () {
      // Arrange
      final response = SignupResponseModel(
        message: "Success",
        data: Data(email: "example@example.com", first_name: "John", last_name: "Doe"),
      );

      // Act
      final jsonString = signupResponseModelToJson(response);

      // Assert
      expect(jsonString, '{"message":"Success","data":{"email":"example@example.com","first_name":"John","last_name":"Doe"},"errors":null}');
    });

    test('toJson should return json string with errors', () {
      // Arrange
      final response = SignupResponseModel(
        errors: ["Email is already in use"],
      );

      // Act
      final jsonString = signupResponseModelToJson(response);

      // Assert
      expect(jsonString, '{"message":null,"data":null,"errors":["Email is already in use"]}');
    });
  });

  group('Data', () {
    test('fromJson should return Data instance', () {
      // Arrange
      final jsonData = {"email": "example@example.com", "first_name": "John", "last_name": "Doe"};

      // Act
      final data = Data.fromJson(jsonData);

      // Assert
      expect(data.email, "example@example.com");
      expect(data.first_name, "John");
      expect(data.last_name, "Doe");
    });

    test('toJson should return Map<String, dynamic>', () {
      // Arrange
      final data = Data(email: "example@example.com", first_name: "John", last_name: "Doe");

      // Act
      final jsonMap = data.toJson();

      // Assert
      expect(jsonMap, {"email":"example@example.com","first_name":"John","last_name":"Doe"});
    });
  });
}