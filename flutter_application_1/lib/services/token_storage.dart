import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Saves the access token and its expiry in secure storage
  Future<void> saveToken(String token, int expiry) async {
    await _storage.write(key: "jwt_token", value: token);
    await _storage.write(key: "token_expiry", value: expiry.toString());
  }

  // Retrieves the access token from secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: "jwt_token");
  }

  // Retrieves the token expiry from secure storage
  Future<int?> getTokenExpiry() async {
    String? expiry = await _storage.read(key: "token_expiry");
    return expiry != null ? int.tryParse(expiry) : null;
  }

  // Saves the refresh token in secure storage
  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: "refresh_token", value: refreshToken);
  }

  // Retrieves the refresh token from secure storage
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: "refresh_token");
  }

  // Deletes all tokens from secure storage
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: "jwt_token");
    await _storage.delete(key: "refresh_token");
    await _storage.delete(key: "token_expiry");
  }
}
