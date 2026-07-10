import 'package:flutter/material.dart';

class AppColors {
  // Common Colors (Mockup Palette)
  static const Color primary = Color(0xFF3B82F6); // Royal Blue
  static const Color secondary = Color(0xFF8B5CF6); // Purple/Violet
  static const Color accent = Color(0xFF10B981); // Emerald Green/Teal (Flutter Developer subtitle)
  static const Color success = Color(0xFF10B981); // Success Emerald Green
  
  // Dark Theme Colors
  static const Color darkBg = Color(0xFF03001C); // Extra deep dark blue-purple
  static const Color darkCard = Color(0xFF0D0B21); // Slate/Dark card
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // White/Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkGlassBg = Color(0x0FFFFFFF); // Semi-transparent white
  static const Color darkGlassBorder = Color(0x1BFFFFFF);
  static const Color darkBlobColor1 = Color(0x1A3B82F6); // Glow 1 (Royal Blue with opacity)
  static const Color darkBlobColor2 = Color(0x158B5CF6); // Glow 2 (Purple with opacity)
  static const Color darkBlobColor3 = Color(0x1510B981); // Glow 3 (Teal with opacity)

  // Light Theme Colors
  static const Color lightBg = Color(0xFFF8FAFC); // Slate 50
  static const Color lightCard = Colors.white;
  static const Color lightTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color lightTextSecondary = Color(0xFF475569); // Slate 600
  static const Color lightGlassBg = Color(0x10000000); // Semi-transparent black
  static const Color lightGlassBorder = Color(0x15000000);
  static const Color lightBlobColor1 = Color(0x0C3B82F6); // Subtle Glow 1
  static const Color lightBlobColor2 = Color(0x0C8B5CF6); // Subtle Glow 2
  static const Color lightBlobColor3 = Color(0x0C10B981); // Subtle Glow 3

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient accentGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient textGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)], // Royal Blue to Purple
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient darkBlobGradient = LinearGradient(
    colors: [darkBlobColor1, darkBlobColor2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
