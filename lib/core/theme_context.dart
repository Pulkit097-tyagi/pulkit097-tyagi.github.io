import 'package:flutter/material.dart';
import 'colors.dart';

/// Theme-aware colour shortcuts, so widgets read brightness from the
/// active [Theme] instead of re-deriving it from providers.
extension ThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get textPrimary => isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  Color get textSecondary => isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  Color get glassBorder => isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder;
}
