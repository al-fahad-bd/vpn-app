import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: const Color(0xff0D9488),
    // primary: Colors.red,
    secondary: const Color(0xffF7DC91),

    onSurface: Colors.black, // Default text color on surfaces
    onPrimary: Colors.white, // Text color on primary-colored widgets
    onSecondary: Colors.white,

    primaryContainer: const Color(0xff0D9488).withAlpha(50),
    secondaryContainer: Colors.white.withAlpha(50),
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(color: Colors.white),
    displayMedium: const TextStyle(color: Colors.white),

    // ... other text styles
    bodyLarge: TextStyle(color: Colors.white.withAlpha(200)),
    bodyMedium: TextStyle(color: Colors.white.withAlpha(180)),
    labelLarge: const TextStyle(color: Colors.white), // Button text
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // Match surfaceVariant or use your own
    selectedItemColor: Color(0xff0D9488),
    unselectedItemColor: Colors.black87,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);
