import 'package:flutter/material.dart';

class AppColors {
  // ─── Primary ────────────────────────────────────────────────────────────────
  static Color primary = const Color(0xFF0071BB);
  static Color onPrimary = Colors.white;
  static Color primaryFixed = const Color(0xFF0071BB);
  static Color primaryContainer = const Color(0xFFEBF3FF);
  static Color onPrimaryContainer = const Color(0xFF0071BB);

  // ─── Secondary ──────────────────────────────────────────────────────────────
  static Color secondary = const Color(0xFF3DC100);
  static Color onSecondary = const Color(0xFFFFFFFF);

  // ─── Surface ────────────────────────────────────────────────────────────────
  static Color surface = const Color(0xFFF6F6F4);
  static Color surfaceBright = const Color(0xFFFFFFFF);
  static Color onSurface = const Color(0xFF111111);
  static Color onSurfaceVariant = const Color(0xFF6A7282);
  static Color surfaceDim = const Color(0xFFF4F4F5);
  static Color scaffoldBackgroundColor = Colors.transparent;

  // ─── Error ──────────────────────────────────────────────────────────────────
  static Color error = Colors.red;
  static Color onError = Colors.white;
  static Color errorContainer = Colors.red.withValues(alpha: 0.2);
  static Color onErrorContainer = Colors.red;

  // ─── Misc ───────────────────────────────────────────────────────────────────
  static Color outline = const Color(0xFFE4E4E7);
  static Color shadow = Colors.grey;
}
