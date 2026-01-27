import 'package:flutter/material.dart';


class AppTheme {
  // Palette
  static const Color background = Color(0xFF121214);
  static const Color surface = Color(0xFF1E1E24);
  static const Color surfaceElevated = Color(0xFF2C2C35);
  static const Color primary = Color(0xFFFF9F43); // Soft Amber/Orange
  static const Color primaryDark = Color(0xFFD68028); 
  static const Color secondary = Color(0xFF6C5CE7); // Muted Violet
  static const Color error = Color(0xFFFF6B6B);
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFFAAAAAA);

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Outfit',
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      cardColor: surface,
      canvasColor: background,
      
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: error,
        onPrimary: Colors.black, // Dark text on Amber
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
        ),
        labelLarge: TextStyle( // Button text
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black, // Text on primary
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: TextStyle(color: textSecondary.withValues(alpha: 0.5)),
        contentPadding: const EdgeInsets.all(20),
      ),
      
      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24,
      ),
      
      dividerColor: Colors.white.withValues(alpha: 0.08),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
