import 'package:flutter/material.dart';

/// Centralized color management for the entire app
/// This class provides consistent colors across all screens and components
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFB74D);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);

  // Error Colors
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gray Scale (only used ones)
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF424242);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFE0E0E0);

  // Shadow Colors
  static const Color shadow = Color(0x1F000000);

  // Snackbar Colors
  static const Color snackbarSuccess = success;
  static const Color snackbarError = error;
  static const Color snackbarWarning = warning;
  static const Color snackbarInfo = info;

  // Theme-aware Colors
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: textOnPrimary,
    secondary: secondary,
    onSecondary: black,
    error: error,
    onError: textOnPrimary,
    background: background,
    onBackground: textPrimary,
    surface: surface,
    onSurface: textPrimary,
    surfaceVariant: gray100,
    onSurfaceVariant: textSecondary,
    outline: border,
    outlineVariant: borderLight,
    shadow: shadow,
    scrim: Color(0x80000000),
    inverseSurface: gray900,
    onInverseSurface: white,
    inversePrimary: primaryLight,
    tertiary: success,
    onTertiary: textOnPrimary,
    tertiaryContainer: successLight,
    onTertiaryContainer: black,
    errorContainer: errorLight,
    onErrorContainer: black,
    primaryContainer: primaryLight,
    onPrimaryContainer: black,
    secondaryContainer: secondaryLight,
    onSecondaryContainer: black,
    surfaceTint: primary,
  );

  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryLight,
    onPrimary: textOnPrimary,
    secondary: secondaryLight,
    onSecondary: black,
    error: errorLight,
    onError: textOnPrimary,
    background: gray900,
    onBackground: white,
    surface: gray800,
    onSurface: white,
    surfaceVariant: gray700,
    onSurfaceVariant: gray300,
    outline: gray600,
    outlineVariant: gray700,
    shadow: Color(0x33000000),
    scrim: Color(0xCC000000),
    inverseSurface: white,
    onInverseSurface: gray900,
    inversePrimary: primaryDark,
    tertiary: successLight,
    onTertiary: textOnPrimary,
    tertiaryContainer: Color(0xFF388E3C),
    onTertiaryContainer: white,
    errorContainer: Color(0xFFD32F2F),
    onErrorContainer: white,
    primaryContainer: primaryDark,
    onPrimaryContainer: white,
    secondaryContainer: Color(0xFFF57C00),
    onSecondaryContainer: white,
    surfaceTint: primaryLight,
  );
}
