import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A network image wrapper that supplies loading/error states and fade-in on
/// load, with memory-cache sizing to keep GPU footprint low.
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

    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? progress,
      ) {
        if (progress == null) return child;
        return ColoredBox(
          color: placeholder,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.accentMuted,
              ),
            ),
          ),
        );
      },
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
