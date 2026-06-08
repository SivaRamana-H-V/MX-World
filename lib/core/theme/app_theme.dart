import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the centralized [ThemeData] for the application.
///
/// Typography pairs a tight, heavy grotesque for display headlines with a
/// neutral sans for body copy, mirroring the editorial design language of the
/// MX WORLD brand.
abstract final class AppTheme {
  const AppTheme._();

  static TextTheme _textTheme(Color primary, Color secondary) {
    final TextTheme base = GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.archivo(
        fontSize: 56,
        height: 0.98,
        letterSpacing: -1.5,
        fontWeight: FontWeight.w800,
        color: primary,
      ),
      displayMedium: GoogleFonts.archivo(
        fontSize: 40,
        height: 1.0,
        letterSpacing: -1.0,
        fontWeight: FontWeight.w800,
        color: primary,
      ),
      headlineLarge: GoogleFonts.archivo(
        fontSize: 30,
        height: 1.05,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      headlineMedium: GoogleFonts.archivo(
        fontSize: 22,
        height: 1.1,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 15,
        height: 1.55,
        color: secondary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 13.5,
        height: 1.5,
        color: secondary,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 12,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 10.5,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w600,
        color: secondary,
      ),
    );
  }

  /// Light theme — the dominant presentation for content sections.
  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.offWhite,
      primary: AppColors.black,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.offWhite,
      textTheme: _textTheme(AppColors.textPrimary, AppColors.textSecondary),
      dividerColor: AppColors.borderLight,
      extensions: const <ThemeExtension<dynamic>>[
        AppPalette(
          eyebrow: AppColors.accent,
          inverseSurface: AppColors.black,
          onInverse: AppColors.textOnDarkPrimary,
          onInverseSecondary: AppColors.textOnDarkSecondary,
          border: AppColors.borderLight,
        ),
      ],
    );
  }

  /// Dark theme — used for hero bands, stats strips, and footers.
  static ThemeData get dark {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
    ).copyWith(
      surface: AppColors.black,
      primary: AppColors.white,
      onSurface: AppColors.textOnDarkPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: _textTheme(
        AppColors.textOnDarkPrimary,
        AppColors.textOnDarkSecondary,
      ),
      dividerColor: AppColors.borderDark,
      extensions: const <ThemeExtension<dynamic>>[
        AppPalette(
          eyebrow: AppColors.accent,
          inverseSurface: AppColors.offWhite,
          onInverse: AppColors.textPrimary,
          onInverseSecondary: AppColors.textSecondary,
          border: AppColors.borderDark,
        ),
      ],
    );
  }
}

/// Custom design tokens not covered by [ColorScheme].
///
/// Provides access to the accent "eyebrow" color and inverse-surface tokens
/// used when a section flips its background relative to its parent.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.eyebrow,
    required this.inverseSurface,
    required this.onInverse,
    required this.onInverseSecondary,
    required this.border,
  });

  final Color eyebrow;
  final Color inverseSurface;
  final Color onInverse;
  final Color onInverseSecondary;
  final Color border;

  @override
  AppPalette copyWith({
    Color? eyebrow,
    Color? inverseSurface,
    Color? onInverse,
    Color? onInverseSecondary,
    Color? border,
  }) {
    return AppPalette(
      eyebrow: eyebrow ?? this.eyebrow,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverse: onInverse ?? this.onInverse,
      onInverseSecondary: onInverseSecondary ?? this.onInverseSecondary,
      border: border ?? this.border,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      eyebrow: Color.lerp(eyebrow, other.eyebrow, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverse: Color.lerp(onInverse, other.onInverse, t)!,
      onInverseSecondary:
          Color.lerp(onInverseSecondary, other.onInverseSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
