import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/animated_counter.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';
import 'package:mxworld/views/widgets/common/inquiry_form.dart';
import 'package:mxworld/views/widgets/common/reveal_on_scroll.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';
import 'package:mxworld/views/widgets/common/under_development.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MxPageScaffold(
      sections: <Widget>[
        _NetworkHeroSection(),
        _MetricsBand(),
        _StrategicHubsSection(),
        _MaritimeDominanceSection(),
        _RealTimeDataAccessSection(),
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
            url: ContentRepository.heroImage,
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
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
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

class _StrategicHubsSection extends StatelessWidget {
  const _StrategicHubsSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return RevealOnScroll(
      duration: const Duration(milliseconds: 800),
      offset: 40,
      visibleFraction: 0.05,
      child: Container(
        color: AppColors.white,
        child: ContentContainer(
          vertical: AppSpacing.section,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HEADQUARTERS',
                          style: text.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 540),
                          child: Text(
                            'Our headquarters is located in Coimbatore, India — the operational nerve center driving global logistics coordination and customer engagement.',
                            style: text.bodyMedium?.copyWith(
                              color: AppColors.textTertiary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile)
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.black,
                      size: 28,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              isMobile
                  ? const Column(
                      children: [
                        _HubCard(
                          city: 'COIMBATORE',
                          region: 'HEADQUARTERS',
                          address:
                              '141, EB Colony Ponnairajpuram,\nPalaniappa Nagar, Coimbatore-641001',
                          phone: '+91 83004 47268',
                          email: 'lokeshkiran@mxworld.in',
                        ),
                      ],
                    )
                  : const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _HubCard(
                            city: 'COIMBATORE',
                            region: 'HEADQUARTERS',
                            address:
                                '141, EB Colony Ponnairajpuram,\nPalaniappa Nagar, Coimbatore-641001',
                            phone: '+91 83004 47268',
                            email: 'lokeshkiran@mxworld.in',
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final String city;
  final String region;
  final String address;
  final String phone;
  final String? email;

  const _HubCard({
    required this.city,
    required this.region,
    required this.address,
    required this.phone,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: const Color(0xFFF1F3F5),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            region,
            style: text.labelSmall?.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            city,
            style: text.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'ADDRESS',
            style: text.labelSmall?.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            address,
            style: text.bodyMedium
                ?.copyWith(height: 1.4, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          if (email != null) ...[
            Text(
              'EMAIL US',
              style: text.labelSmall?.copyWith(
                color: AppColors.textTertiary,
                fontSize: 10,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              email!,
              style: text.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text(
            'CALL US',
            style: text.labelSmall?.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            phone,
            style: text.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _MaritimeDominanceSection extends StatelessWidget {
  const _MaritimeDominanceSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    const Widget leftImage = AspectRatio(
      aspectRatio: 1,
      child: SafeNetworkImage(
        url: ContentRepository.seaFreightImage,
        fit: BoxFit.cover,
      ),
    );

    final Widget rightContent = Container(
      color: AppColors.black,
      padding: EdgeInsets.all(isMobile ? AppSpacing.xl : AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OCEAN MATRIX',
            style: text.labelSmall?.copyWith(
              color: AppColors.textOnDarkTertiary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'MARITIME DOMINANCE AT SCALE.',
            style: text.headlineLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildFeatureRow(
            text,
            Icons.anchor,
            'Automated Fleet Management',
            'Real-time telemetry and optimized speed control arrays running on all active carrier assets to minimize operational latency.',
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildFeatureRow(
            text,
            Icons.lan_outlined,
            'Intermodal Port Infrastructure',
            'Deep integration links connected seamlessly between vessel arriving lanes and inland rail network infrastructure modules.',
          ),
          const SizedBox(height: AppSpacing.xxl),
          SizedBox(
            width: isMobile ? double.infinity : double.infinity,
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.white, width: 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () => showUnderDevelopment(context),
              child: Text(
                'DOWNLOAD NETWORK REPORT',
                style: text.labelMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return RevealOnScroll(
      duration: const Duration(milliseconds: 800),
      offset: 40,
      visibleFraction: 0.05,
      child: Container(
        color: AppColors.white,
        child: ContentContainer(
          child: isMobile
              ? Column(
                  children: [
                    leftImage,
                    rightContent,
                  ],
                )
              : Row(
                  children: [
                    const Expanded(child: leftImage),
                    Expanded(child: rightContent),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(
    TextTheme text,
    IconData icon,
    String title,
    String desc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.white, size: 20),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: text.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: text.bodyMedium?.copyWith(
                  color: AppColors.textOnDarkSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RealTimeDataAccessSection extends StatelessWidget {
  const _RealTimeDataAccessSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget leftAccordions = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'REAL-TIME\nDATA ACCESS.',
          style: text.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.black,
            height: 1.1,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Connect your global B2B endpoints securely into our central management layer for real-time visibility metrics and live operational infrastructure telemetry.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.5),
        ),
        const SizedBox(height: AppSpacing.xl),
        _buildUnderlineAccordion(text, 'API INTEGRATION ENGINE', true),
        _buildUnderlineAccordion(text, 'LIVE ROUTE TELEMETRY', false),
      ],
    );

    final Widget rightMockup = Container(
      // aspectRatio: 16 / 10,
      color: AppColors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: SafeNetworkImage(
                url: ContentRepository.heroImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.greenAccent),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'LIVE OPERATIONAL STREAM ACTIVED',
                style: text.labelSmall?.copyWith(
                  color: AppColors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return RevealOnScroll(
      duration: const Duration(milliseconds: 800),
      offset: 40,
      visibleFraction: 0.05,
      child: Container(
        color: const Color(0xFFE9ECEF),
        child: ContentContainer(
          vertical: AppSpacing.section,
          child: isMobile
              ? Column(
                  children: [
                    leftAccordions,
                    const SizedBox(height: AppSpacing.xxl),
                    rightMockup,
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 5, child: leftAccordions),
                    const SizedBox(width: AppSpacing.section),
                    Expanded(flex: 5, child: rightMockup),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildUnderlineAccordion(TextTheme text, String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFCED4DA), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: text.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: active ? AppColors.black : AppColors.textTertiary,
            ),
          ),
          Icon(
            active ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: active ? AppColors.black : AppColors.textTertiary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

