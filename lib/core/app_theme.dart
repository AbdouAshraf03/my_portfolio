import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const primaryPurple = Color(0xFF8B5CF6);
  static const deepPurple = Color(0xFF6D28D9);
  static const electricCyan = Color(0xFF06B6D4);
  static const softPink = Color(0xFFEC4899);
  static const darkBg = Color(0xFF0F172A);
  static const terminalBg = Color(0xFF1E293B);
  static const borderColor = Color(0xFF334155);

  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: primaryPurple,
    textTheme: GoogleFonts.firaCodeTextTheme(ThemeData.dark().textTheme),
    colorScheme: const ColorScheme.dark(
      primary: primaryPurple,
      secondary: electricCyan,
      tertiary: softPink,
      surface: terminalBg,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(color: Colors.white.withAlpha(0.3 * 255 ~/ 1)),
    ),
  );

  static BoxDecoration get terminalDecoration => BoxDecoration(
    color: terminalBg,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: primaryPurple.withAlpha(0.3 * 255 ~/ 1),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: primaryPurple.withAlpha(0.2 * 255 ~/ 1),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  );

  static BoxDecoration get glassDecoration => BoxDecoration(
    color: Colors.white.withAlpha(0.05 * 255 ~/ 1),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.white.withAlpha(0.1 * 255 ~/ 1)),
  );

  static BoxDecoration neonGlow(Color color) => BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: color.withAlpha(0.5 * 255 ~/ 1),
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  );
}
