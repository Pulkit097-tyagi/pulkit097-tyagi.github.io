import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.darkCard,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
        displayMedium: GoogleFonts.outfit(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        titleLarge: GoogleFonts.outfit(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.darkTextSecondary,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.darkTextSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkGlassBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        hintStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.darkTextPrimary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.lightCard,
        error: Colors.red,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
        displayMedium: GoogleFonts.outfit(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        titleLarge: GoogleFonts.outfit(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.lightTextSecondary,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.lightTextSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightGlassBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.03),
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.lightTextPrimary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
