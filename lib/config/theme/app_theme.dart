import 'package:flutter/material.dart';
import 'package:flutter_mvvm_starter/config/app_constant.dart';
import 'package:flutter_mvvm_starter/config/theme/app_color.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';
import 'package:flutter_mvvm_starter/config/theme/app_text_style.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: AppConst.fontFamily,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: _colorScheme,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
      );

  // ─── Color scheme ────────────────────────────────────────────────────────────
  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
  ).copyWith(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    primaryFixed: AppColors.primaryFixed,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    surface: AppColors.surface,
    surfaceBright: AppColors.surfaceBright,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    surfaceDim: AppColors.surfaceDim,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    outline: AppColors.outline,
    shadow: AppColors.shadow,
  );

  // ─── Text theme ──────────────────────────────────────────────────────────────
  static final TextTheme _textTheme = TextTheme(
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
  );

  // ─── Buttons ─────────────────────────────────────────────────────────────────
  static final FloatingActionButtonThemeData _floatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    elevation: 1,
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(double.maxFinite, AppDimensions.buttonHeight),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
      disabledForegroundColor: AppColors.onSurfaceVariant,
      textStyle: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      fixedSize:
          const Size(double.maxFinite, AppDimensions.buttonHeight - 1.5),
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      disabledBackgroundColor: Colors.transparent,
      disabledForegroundColor: AppColors.primary.withValues(alpha: 0.25),
      textStyle: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w500),
      side: BorderSide(color: AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppTextStyles.bodyMedium,
    ),
  );

  // ─── AppBar ──────────────────────────────────────────────────────────────────
  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    centerTitle: true,
    elevation: 5,
    shadowColor: Colors.black.withValues(alpha: 0.2),
    titleTextStyle: AppTextStyles.titleMedium.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
    ),
  );

  // ─── Input ───────────────────────────────────────────────────────────────────
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceBright,
    isDense: true,
    labelStyle: AppTextStyles.bodyMedium,
    hintStyle: AppTextStyles.bodyMedium
        .copyWith(color: AppColors.onSurfaceVariant),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.outline),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: AppColors.error, width: 1.5),
    ),
  );
}
