import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Shows a brief snack-bar indicating a feature is under development.
///
/// Call this anywhere you have a [BuildContext] with a [Scaffold] ancestor —
/// typically from button [onPressed] callbacks that are not yet implemented.
void showUnderDevelopment(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      const SnackBar(
        content: Text(
          'COMING SOON — FEATURE UNDER DEVELOPMENT',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.nearBlack,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        margin: EdgeInsets.all(16),
      ),
    );
}
