import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme() {
  // Palette from new_design.md
  const mobBlack = Color(0xFF0F0F0F);
  const gangsterGold = Color(0xFFC6A667);
  const bootlegBurgundy = Color(0xFF7A1F1F);
  const ivory = Color(0xFFF5E8C7);
  const whiskeyBrown = Color(0xFF6B4F2C);
  const oliveMafia = Color(0xFF52604E);
  const hitmanRed = Color(0xFFC12727);
  const silentSlate = Color(0xFF878787);

  final colorScheme = ColorScheme.fromSeed(
    seedColor: gangsterGold,
    brightness: Brightness.light,
    primary: gangsterGold,
    secondary: bootlegBurgundy,
    background: ivory,
    surface: whiskeyBrown,
  );

  final baseText = GoogleFonts.interTextTheme(
    const TextTheme(
      bodyMedium: TextStyle(color: mobBlack),
      bodySmall: TextStyle(color: mobBlack),
    ),
  ).copyWith(
    headlineSmall: GoogleFonts.cinzel(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        color: mobBlack,
        letterSpacing: 0.2,
      ),
    ),
    titleLarge: GoogleFonts.cinzel(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        color: mobBlack,
      ),
    ),
    titleMedium: GoogleFonts.inter(
      textStyle: const TextStyle(fontWeight: FontWeight.w700, color: mobBlack),
    ),
    bodyMedium: GoogleFonts.inter(
      textStyle: const TextStyle(color: mobBlack),
    ),
    bodySmall: GoogleFonts.inter(
      textStyle: const TextStyle(color: mobBlack),
    ),
  );

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: ivory,
    cardColor: whiskeyBrown,
    textTheme: baseText,
    appBarTheme: AppBarTheme(
      backgroundColor: mobBlack,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.cinzel(
        textStyle: const TextStyle(
          color: gangsterGold,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ivory,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: silentSlate),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: silentSlate),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: gangsterGold, width: 1.4),
      ),
      hintStyle: const TextStyle(color: silentSlate),
      labelStyle: const TextStyle(color: mobBlack),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mobBlack,
        foregroundColor: gangsterGold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: bootlegBurgundy,
        side: const BorderSide(color: bootlegBurgundy),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: oliveMafia.withOpacity(0.1),
      labelStyle: const TextStyle(color: mobBlack, fontWeight: FontWeight.w700),
      side: const BorderSide(color: silentSlate),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    dividerColor: silentSlate.withOpacity(0.6),
    primaryTextTheme: baseText,
    iconTheme: const IconThemeData(color: mobBlack),
  );
}

