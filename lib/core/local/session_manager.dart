import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_mvvm_starter/core/local/session_keys.dart';

/// Manages sensitive session data (token, refresh token, user JSON)
/// using [FlutterSecureStorage].
///
/// Inject this as a lazySingleton via GetIt.
/// Call [init] in [ServiceLocator] before any feature code runs.
class SessionManager {
  final FlutterSecureStorage _storage;

  SessionManager({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  // ─── Token ────────────────────────────────────────────────────────────────

  Future<void> setToken(String token) =>
      _storage.write(key: SessionKeys.token, value: token);

  Future<String?> getToken() =>
      _storage.read(key: SessionKeys.token);

  // ─── Refresh token ────────────────────────────────────────────────────────

  Future<void> setRefreshToken(String token) =>
      _storage.write(key: SessionKeys.refreshToken, value: token);

  Future<String?> getRefreshToken() =>
      _storage.read(key: SessionKeys.refreshToken);

  // ─── User JSON ────────────────────────────────────────────────────────────

  /// Store the serialized user model as a JSON string.
  /// The auth feature is responsible for serialization / deserialization.
  Future<void> setUserJson(String json) =>
      _storage.write(key: SessionKeys.userJson, value: json);

  Future<String?> getUserJson() =>
      _storage.read(key: SessionKeys.userJson);

  // ─── Helpers ─────────────────────────────────────────────────────────────

  /// Returns true when a token is present (user is logged in).
  Future<bool> get isLoggedIn async =>
      (await getToken()) != null;

  /// Removes all session data (call on logout or 403 force-logout).
  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(key: SessionKeys.token),
      _storage.delete(key: SessionKeys.refreshToken),
      _storage.delete(key: SessionKeys.userJson),
    ]);
  }
}
