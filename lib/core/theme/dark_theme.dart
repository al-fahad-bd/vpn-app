import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color(0xff010C0B),
    primary: const Color(0xff07CCBA),
    secondary: const Color(0xffF7DC91),

    onSurface: Colors.white, // Default text color on surfaces
    onPrimary: Colors.black, // Text color on primary-colored widgets
    onSecondary: Colors.black, // Text color on secondary-colored widgets

    primaryContainer: const Color(0xff07CCBA).withAlpha(50),
    secondaryContainer: const Color(0xff3f3f3f).withAlpha(100),
    
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
    backgroundColor: Color(0xFF021F1C), // Match surfaceVariant or use your own
    selectedItemColor: Color(0xff07CCBA),
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);