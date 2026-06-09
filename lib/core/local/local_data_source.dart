import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mvvm_starter/core/local/session_keys.dart';

/// Manages non-sensitive app preferences using [SharedPreferences].
///
/// For sensitive data (tokens, user info) use [SessionManager] instead.
///
/// Inject as a lazySingleton via GetIt. [SharedPreferences] must be
/// initialized and registered before this class is resolved.
class LocalDataSource {
  final SharedPreferences _prefs;

  const LocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  // ─── Onboarding ───────────────────────────────────────────────────────────

  bool get isOnboardingComplete =>
      _prefs.getBool(LocalDataKeys.isOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete(bool value) =>
      _prefs.setBool(LocalDataKeys.isOnboardingComplete, value);

  // ─── Language ─────────────────────────────────────────────────────────────

  String? get appLanguage => _prefs.getString(LocalDataKeys.appLanguage);

  Future<void> setAppLanguage(String languageCode) =>
      _prefs.setString(LocalDataKeys.appLanguage, languageCode);

  // ─── Clear ────────────────────────────────────────────────────────────────

  /// Clears all stored preferences (does NOT touch [SessionManager]).
  Future<void> clearPreferences() => _prefs.clear();
}
