import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const bgPrimary = Color(0xFF0B0C10);
  const bgSecondary = Color(0xFF1C1512);
  const mobRed = Color(0xFFB32222);
  const gold = Color(0xFFD9A441);
  const textPrimary = Color(0xFFF5F3EC);
  const textSecondary = Color(0xFFC0B8A8);

  final colorScheme = ColorScheme.fromSeed(
    seedColor: gold,
    brightness: Brightness.dark,
    primary: gold,
    secondary: mobRed,
    background: bgPrimary,
    surface: bgSecondary,
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bgPrimary,
    cardColor: bgSecondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: bgPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontWeight: FontWeight.w800,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w800, color: textPrimary),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
      bodyMedium: TextStyle(color: textSecondary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0x191C1512),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: gold, width: 1.4),
      ),
      hintStyle: const TextStyle(color: textSecondary),
      labelStyle: const TextStyle(color: textSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: bgPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: gold,
        side: const BorderSide(color: gold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

