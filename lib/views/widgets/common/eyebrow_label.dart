import 'package:flutter/material.dart';

import 'package:mxworld/core/theme/app_theme.dart';

/// A small uppercase accent label that sits above section headlines.
///
/// Renders in the theme's [AppPalette.eyebrow] accent color with wide letter
/// spacing, matching the "ABOUT MX WORLD" / "CORE PRINCIPLES" labels in the
/// design.
class EyebrowLabel extends StatelessWidget {
  const EyebrowLabel(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final AppPalette palette = Theme.of(context).extension<AppPalette>()!;
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color ?? palette.eyebrow,
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
