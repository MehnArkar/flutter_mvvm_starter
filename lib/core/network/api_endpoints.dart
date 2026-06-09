/// All API endpoint constants for the app.
///
/// Replace [baseUrl] when targeting a different environment.
/// Feature-specific endpoints are grouped by region.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://your-api.example.com/api/v1';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String signIn = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';

  // ─── Push notifications ───────────────────────────────────────────────────
  static const String pushDevices = '/push/devices';

  // ─── TODO: Add feature endpoints below ───────────────────────────────────
  // static const String products = '/products';
}
