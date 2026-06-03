/// Keys used by [SessionManager] (flutter_secure_storage).
class SessionKeys {
  SessionKeys._();

  static const String token = 'session_token';
  static const String refreshToken = 'session_refresh_token';
  static const String userJson = 'session_user_json';
}

/// Keys used by [LocalDataSource] (shared_preferences).
class LocalDataKeys {
  LocalDataKeys._();

  static const String isOnboardingComplete = 'is_onboarding_complete';
  static const String appLanguage = 'app_language';
}
