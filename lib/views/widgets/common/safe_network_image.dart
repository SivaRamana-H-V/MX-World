import 'package:flutter/material.dart';

import 'package:mxworld/core/theme/app_colors.dart';

/// An asset image wrapper with error fallback.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.onDark = true,
  });

  final String url;
  final BoxFit fit;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final Color placeholder =
        onDark ? AppColors.charcoal : AppColors.borderLight;

    return Image.asset(
      url,
      fit: fit,
      errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
        return ColoredBox(
          color: placeholder,
          child: Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: onDark
                  ? AppColors.textOnDarkTertiary
                  : AppColors.textTertiary,
              size: 32,
            ),
          ),
        );
      },
    );
  }
}
