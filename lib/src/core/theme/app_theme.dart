import 'package:flutter/material.dart';

class AppTheme {
  // New harmonious color palette
  static const Color primaryColor = Color(0xFF4361EE); // Softer vibrant blue
  static const Color secondaryColor = Color(0xFF3A0CA3); // Deep purple-blue
  static const Color accentColor = Color(0xFF4CC9F0); // Light sky blue
  static const Color successColor = Color(
    0xFF2ECC71,
  ); // Green for success states
  static const Color warningColor = Color(0xFFFF9F1C); // Amber for warnings
  static const Color errorColor = Color(0xFFE71D36); // Red for errors

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFF8F9FA); // Very light grey
  static const Color _lightSurface = Colors.white;
  static const Color _lightTextPrimary = Color(0xFF212529); // Almost black
  static const Color _lightTextSecondary = Color(0xFF495057); // Dark grey

  // Card colors
  static const Color lightCardColor = Colors.white;
  static const Color darkCardColor = Color(0xFF1E1E1E);

  // AppBar colors
  static const Color lightAppBarColor = primaryColor;
  static const Color darkAppBarColor = Color(0xFF1E1E1E);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF3A86FF); // Bright blue
  static const Color _darkSecondary = Color(0xFF8338EC); // Purple
  static const Color _darkBackground = Color(0xFF121212); // True dark
  static const Color _darkSurface = Color(
    0xFF1E1E1E,
  ); // Slightly lighter than background
  static const Color _darkTextPrimary = Color(0xFFE9ECEF); // Off-white
  static const Color _darkTextSecondary = Color(0xFFADB5BD); // Light grey

  // Onboarding Colors
  static const Color onboardingColor1 = Color(0xFF4895EF); // Blue
  static const Color onboardingColor2 = Color(0xFF560BAD); // Purple
  static const Color onboardingColor3 = Color(0xFFB5179E); // Pink

  // Text colors
  static const Color lightTextPrimary = Color(0xFF212529);
  static const Color lightTextSecondary = Color(0xFF495057);
  static const Color darkTextPrimary = Color(0xFFE9ECEF);
  static const Color darkTextSecondary = Color(0xFFADB5BD);

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightAppBarColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: const CardThemeData(
      color: lightCardColor,
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: _lightSurface,
      background: _lightBackground,
      error: errorColor,
    ),
    scaffoldBackgroundColor: _lightBackground,
    cardColor: _lightSurface,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: _lightTextPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: _lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: _lightTextPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: _lightTextSecondary, fontSize: 14),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _lightTextPrimary,
      ),
      labelLarge: TextStyle(
        color: Colors.white, // For buttons
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDEE2E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDEE2E6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE9ECEF),
      thickness: 1,
      space: 1,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkAppBarColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: darkTextPrimary),
    ),

    cardTheme: const CardThemeData(
      color: darkCardColor,
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: _darkSurface,
      background: _darkBackground,
      error: errorColor,
    ),
    scaffoldBackgroundColor: _darkBackground,
    cardColor: _darkSurface,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: _darkTextPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: _darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: _darkTextPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: _darkTextSecondary, fontSize: 14),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _darkTextPrimary,
      ),
      labelLarge: TextStyle(
        color: _darkTextPrimary, // For buttons
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimary,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkPrimary,
        side: const BorderSide(color: _darkPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF343A40)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF343A40)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF343A40),
      thickness: 1,
      space: 1,
    ),
  );
}
