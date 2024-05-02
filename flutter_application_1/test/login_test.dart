import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/login.dart';

void main() {
  group('LoginResponseModel', () {
    test('fromJson() correctly parses JSON', () {
      // Arrange
      final json = {
        "message": "Login successful",
        "tokens": {"access": "access_token", "refresh": "refresh_token"}
      };

      // Act
      final model = LoginResponseModel.fromJson(json);

      // Assert
      expect(model.message, "Login successful");
      expect(model.tokens!.access, "access_token");
      expect(model.tokens!.refresh, "refresh_token");
    });

    test('toJson() correctly converts to JSON', () {
      // Arrange
      final model = LoginResponseModel(
        message: "Login successful",
        tokens: Tokens(access: "access_token", refresh: "refresh_token"),
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json["message"], "Login successful");
      expect(json["tokens"]["access"], "access_token");
      expect(json["tokens"]["refresh"], "refresh_token");
    });
  });

  group('Tokens', () {
    test('fromJson() correctly parses JSON', () {
      // Arrange
      final json = {"access": "access_token", "refresh": "refresh_token"};

      // Act
      final model = Tokens.fromJson(json);

      // Assert
      expect(model.access, "access_token");
      expect(model.refresh, "refresh_token");
    });

    test('toJson() correctly converts to JSON', () {
      // Arrange
      final model = Tokens(access: "access_token", refresh: "refresh_token");

      // Act
      final json = model.toJson();

      // Assert
      expect(json["access"], "access_token");
      expect(json["refresh"], "refresh_token");
    });
  });

  group('LoginRequestModel', () {
    test('toJson() correctly converts to JSON', () {
      // Arrange
      final model = LoginRequestModel(email: "test@example.com", password: "password");

      // Act
      final json = model.toJson();

      // Assert
      expect(json["email"], "test@example.com");
      expect(json["password"], "password");
    });
  });
}