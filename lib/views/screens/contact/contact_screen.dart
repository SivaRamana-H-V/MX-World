import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/animated_counter.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/inquiry_form.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';

import 'package:mxworld/views/widgets/common/reveal_on_scroll.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MxPageScaffold(
      sections: <Widget>[
        _NetworkHeroSection(),
        _MetricsBand(),
        InquiryForm(),
      ],
    );
  }
}

class _NetworkHeroSection extends StatelessWidget {
  const _NetworkHeroSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      height: isMobile ? 420 : 540,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const SafeNetworkImage(
            url: ContentRepository.importExportImage,
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.65),
            ),
          ),
          Padding(
            padding:
                AppSpacing.pageGutter(width).copyWith(bottom: AppSpacing.xxl),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const EyebrowLabel('ROUTING INFRASTRUCTURE'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'OUR GLOBAL REACH.',
                      style: (isMobile ? text.displayMedium : text.displayLarge)
                          ?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Managing cross-border terminal networks with predictive edge routing. Overcoming infrastructural complexity dynamically to secure fluid international trade lane pathways.',
                      style: text.bodyLarge?.copyWith(
                        color: AppColors.textOnDarkSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsBand extends StatelessWidget {
  const _MetricsBand();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final List<Map<String, String>> metrics = [
      {'val': '142', 'lbl': 'CONNECTED TERMINALS'},
      {'val': 'Global', 'lbl': 'COVERAGE SCOPE'},
      {'val': '850+', 'lbl': 'FREIGHT CHANNELS'},
      {'val': '12.4M', 'lbl': 'ANNUAL METRIC TONS'},
    ];

    return RevealOnScroll(
      duration: const Duration(milliseconds: 800),
      offset: 40,
      visibleFraction: 0.05,
      child: Container(
        color: AppColors.black,
        child: ContentContainer(
          child: isMobile
              ? Column(
                  children: metrics
                      .map(
                        (m) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: _buildMetricItem(text, m['val']!, m['lbl']!),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: metrics
                      .map(
                        (m) => Expanded(
                          child: _buildMetricItem(text, m['val']!, m['lbl']!),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(TextTheme text, String val, String lbl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedCounter(
          value: val,
          style: text.headlineMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          lbl,
          style: text.labelSmall?.copyWith(
            color: AppColors.textOnDarkTertiary,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}
