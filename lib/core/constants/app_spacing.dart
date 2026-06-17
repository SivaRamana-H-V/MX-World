import 'package:flutter/widgets.dart';

/// Layout spacing scale used across the app for consistent rhythm.
abstract final class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;
  static const double xxl = 64;
  static const double section = 96;

  /// Horizontal page gutter, responsive to width.
  static EdgeInsets pageGutter(double width) {
    if (width >= 1200) return const EdgeInsets.symmetric(horizontal: 80);
    if (width >= 768) return const EdgeInsets.symmetric(horizontal: 48);
    return const EdgeInsets.symmetric(horizontal: 24);
  }

  /// Maximum content width to keep line lengths readable on wide screens.
  static const double maxContentWidth = 1280;
}

/// Responsive breakpoints.
abstract final class AppBreakpoints {
  const AppBreakpoints._();

  static const double mobile = 840;
  static const double tablet = 1200;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}
