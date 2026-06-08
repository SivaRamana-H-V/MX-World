import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Sharp-cornered, high-contrast call-to-action button.
///
/// The [filled] variant renders a solid surface (black on light, white on
/// dark); the outlined variant draws a border only. Both use uppercase,
/// letter-spaced labels to match the brand.
class MxButton extends StatelessWidget {
  const MxButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
    this.onDark = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool filled;
  final bool onDark;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final Color surface = onDark ? AppColors.white : AppColors.black;
    final Color onSurface = onDark ? AppColors.black : AppColors.white;
    final Color border = onDark ? AppColors.borderDark : AppColors.borderLight;

    final Widget child = Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 11.5,
            letterSpacing: 1.6,
            color: filled
                ? onSurface
                : (onDark ? AppColors.white : AppColors.black),
          ),
    );

    final ButtonStyle style = ButtonStyle(
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (!filled) return Colors.transparent;
        if (states.contains(WidgetState.hovered)) {
          return surface.withValues(alpha: 0.88);
        }
        return surface;
      }),
      side: filled
          ? null
          : WidgetStatePropertyAll<BorderSide>(
              BorderSide(color: border, width: 1),
            ),
      overlayColor: WidgetStatePropertyAll<Color>(
        (onDark ? AppColors.white : AppColors.black).withValues(alpha: 0.06),
      ),
    );

    final Widget button = filled
        ? FilledButton(onPressed: onPressed, style: style, child: child)
        : OutlinedButton(onPressed: onPressed, style: style, child: child);

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
