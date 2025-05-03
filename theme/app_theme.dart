// --- theme/app_theme.dart ---

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6A1B9A); // Deep Purple
  static const Color primaryVariantColor = Color(0xFF4A148C); // Deeper Purple
  static const Color secondaryColor = Color(0xFFFBC02D); // Yellow/Gold
  static const Color accentColor = Color(0xFFF57F17); // Amber/Orange Accent
  static const Color backgroundColor = Color(0xFFF3E5F5); // Light Purple Background
  static const Color textColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFFFFFFFF); // For dark backgrounds


  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      onPrimary: lightTextColor, // Text on primary color
      onSecondary: textColor, // Text on secondary color
      background: backgroundColor,
      surface: Colors.white, // Card backgrounds etc.
      onBackground: textColor,
      onSurface: textColor,
      error: Colors.redAccent,
      onError: lightTextColor,
      primaryContainer: primaryVariantColor, 
      secondaryContainer: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryVariantColor, 
      foregroundColor: lightTextColor, 
      elevation: 4.0,
      iconTheme: IconThemeData(color: lightTextColor),
      titleTextStyle: TextStyle(
        color: lightTextColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto', 
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: primaryColor, fontFamily: 'Roboto'),
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: textColor, fontFamily: 'Roboto'),
      bodyMedium: TextStyle(fontSize: 16.0, color: textColor, fontFamily: 'Roboto'),
      labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: lightTextColor, fontFamily: 'Roboto'), 
    ).apply(
      bodyColor: textColor,
      displayColor: primaryColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: secondaryColor, 
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor, 
        foregroundColor: textColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), 
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none, 
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryColor, width: 2.0), 
      ),
      labelStyle: const TextStyle(color: primaryColor),
      hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    ),
    iconTheme: const IconThemeData(
      color: primaryColor, 
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, 
    ),
     fontFamily: 'Roboto', 
  );
}

