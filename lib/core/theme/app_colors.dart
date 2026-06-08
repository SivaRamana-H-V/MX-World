import 'package:flutter/material.dart';

/// Centralized color tokens for the MX WORLD logistics app.
///
/// The brand identity is a high-contrast editorial palette: near-black
/// surfaces, off-white backgrounds, and a single electric-blue accent used
/// sparingly for labels and interactive highlights.
abstract final class AppColors {
  const AppColors._();

  // Core neutrals.
  static const Color black = Color(0xFF0A0A0B);
  static const Color nearBlack = Color(0xFF121214);
  static const Color charcoal = Color(0xFF1C1C1F);
  static const Color offWhite = Color(0xFFF4F6F8);
  static const Color white = Color(0xFFFFFFFF);

  // Accent — electric blue used for eyebrow labels and active states.
  static const Color accent = Color(0xFF2E6BFF);
  static const Color accentMuted = Color(0xFF6E8BC4);

  // Text on light surfaces.
  static const Color textPrimary = Color(0xFF0A0A0B);
  static const Color textSecondary = Color(0xFF55585E);
  static const Color textTertiary = Color(0xFF8A8D93);

  // Text on dark surfaces.
  static const Color textOnDarkPrimary = Color(0xFFFFFFFF);
  static const Color textOnDarkSecondary = Color(0xFFB4B6BB);
  static const Color textOnDarkTertiary = Color(0xFF6E7176);

  // Lines and dividers.
  static const Color borderLight = Color(0xFFE2E5E9);
  static const Color borderDark = Color(0xFF2A2A2E);

  // Status.
  static const Color operational = Color(0xFF3FCF8E);
}
