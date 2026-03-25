import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions:
                  IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _emailKey = 'remembered_email';
  static const _userKey = 'cached_user';

  // Token
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userKey);
  }

  Future<bool> get hasToken async => (await getToken()) != null;

  // Refresh Token
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  // Remember Me
  Future<void> saveRememberedEmail(String email) =>
      _storage.write(key: _emailKey, value: email);

  Future<String?> getRememberedEmail() => _storage.read(key: _emailKey);

  Future<void> clearRememberedEmail() => _storage.delete(key: _emailKey);

  // Cached User (for offline login)
  Future<void> saveUserData(Map<String, dynamic> user) =>
      _storage.write(key: _userKey, value: jsonEncode(user));

  Future<Map<String, dynamic>?> getUserData() async {
    final data = await _storage.read(key: _userKey);
    if (data == null) return null;
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> clearUserData() => _storage.delete(key: _userKey);

  // Clear all
  Future<void> clearAll() => _storage.deleteAll();
}
