import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Palette from YOUTH GKKD BP Fire Movement logo
// Dove + wordmark → deep violet-purple #6B2C8A
// Wing gradient   → mid purple         #8B3DAF
// Flame core      → crimson            #D92F1A
// Flame outer     → orange             #F06B1A
// Glory rays      → gold               #F5C518

class AppColors {
  AppColors._();
  static const Color brand      = Color(0xFF6B2C8A);
  static const Color brandMid   = Color(0xFF8B3DAF);
  static const Color brandDark  = Color(0xFF521F6E);
  static const Color brandLight = Color(0xFFF0E6F6);
  static const Color flameRed   = Color(0xFFD92F1A);
  static const Color flameOrange= Color(0xFFF06B1A);
  static const Color gold       = Color(0xFFF5C518);
  static const Color navy       = Color(0xFF1A1230);
  static const Color navyMid    = Color(0xFF3D2A56);
  static const Color gray       = Color(0xFF8B8499);
  static const Color grayLight  = Color(0xFFE4DEF0);
  static const Color grayXLight = Color(0xFFF2EFF8);
  static const Color bg         = Color(0xFFF5F3F8);
  static const Color border     = Color(0xFFE0D8EC);
  static const Color green      = Color(0xFF22C55E);
  static const Color red        = Color(0xFFEF4444);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      primary: AppColors.brand,
      secondary: AppColors.brandMid,
      surface: AppColors.bg,
      onPrimary: Colors.white,
      onSurface: AppColors.navy,
    ),
    scaffoldBackgroundColor: AppColors.bg,
  );
  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grayXLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.brand, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 0),
  );
}
