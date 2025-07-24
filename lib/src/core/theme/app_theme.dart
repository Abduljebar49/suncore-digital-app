import 'package:flutter/material.dart';

class AppTheme {
  // Updated bright color palette
  static const Color primaryColor = Color(0xFF2962FF); // Vibrant blue
  static const Color secondaryColor = Color(0xFFFF6D00); // Bright orange
  static const Color accentColor = Color(0xFF00BFA5); // Teal
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light grey background
  static const Color cardColor = Colors.white; // White cards
  static const Color textPrimary = Color(0xFF212121); // Dark grey for text
  static const Color textSecondary = Color(0xFF757575); // Medium grey for secondary text

  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF2962FF);
  static const Color _lightSecondary = Color(0xFFFF6D00);
  static const Color _lightBackground = Color(0xFFF5F5F5);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF1A237E);
  static const Color _darkSecondary = Color(0xFFFFA000);
  static const Color _darkBackground = Color(0xFF121212);

  // Onboarding Colors
  static const Color onboardingColor1 = Color(0xFFFFA500);
  static const Color onboardingColor2 = Color(0xFF1E40AF);
  static const Color onboardingColor3 = Color(0xFF6B46C1);

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light().copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: cardColor,
          background: backgroundColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        cardColor: cardColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 2,
          titleTextStyle: TextStyle(
            color: Colors.white, // White text on primary color app bar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimary,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primaryColor: _darkPrimary,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: _darkPrimary,
          secondary: _darkSecondary,
        ),
        scaffoldBackgroundColor: _darkBackground,
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkPrimary,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
}