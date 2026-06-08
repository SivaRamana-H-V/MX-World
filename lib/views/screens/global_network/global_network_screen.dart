import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_button.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/safe_network_image.dart';
import '../../widgets/common/stats_strip.dart';

/// Global network screen: reach statement and metrics, strategic hub cards,
/// a maritime-dominance feature, and a real-time data-access panel.
class GlobalNetworkScreen extends StatelessWidget {
  const GlobalNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      currentRoute: '/services',
      navOnDark: true,
      sections: <Widget>[
        _NetworkHero(),
        _NetworkStatsBand(),
        _StrategicHubs(),
        _MaritimeSection(),
        _DataAccessSection(),
      ],
    );
  }
}

class _NetworkHero extends StatelessWidget {
  const _NetworkHero();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.black,
      child: Padding(
        padding: AppSpacing.pageGutter(width).copyWith(
          top: AppSpacing.section,
          bottom: AppSpacing.section,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 5,),
              color: AppColors.accent,
              child: Text(
                'NETWORK CAPACITY 2024',
                style: text.labelMedium?.copyWith(
                  color: AppColors.white,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'OUR GLOBAL REACH.',
              style: (isMobile ? text.displayMedium : text.displayLarge)
                  ?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'Navigating the complexity of international trade with precision '
                'engineering and a monolithic infrastructure network spanning '
                'every major trade lane on the planet.',
                style: text.bodyLarge?.copyWith(
                  color: AppColors.textOnDarkSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkStatsBand extends StatelessWidget {
  const _NetworkStatsBand();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Container(
      color: AppColors.black,
      padding: AppSpacing.pageGutter(width)
          .copyWith(top: AppSpacing.lg, bottom: AppSpacing.lg),
      child: Column(
        children: <Widget>[
          const Divider(color: AppColors.borderDark, height: 1),
          const SizedBox(height: AppSpacing.lg),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: AppColors.borderDark,
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: AppColors.white,
                    displayColor: AppColors.white,
                  ),
            ),
            child: const StatsStrip(
              stats: ContentRepository.networkStats,
              onDark: true,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(color: AppColors.borderDark, height: 1),
        ],
      ),
    );
  }
}

class _StrategicHubs extends StatelessWidget {
  const _StrategicHubs();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;
    const List<HubItem> hubs = ContentRepository.hubs;

    return ColoredBox(
      color: AppColors.offWhite,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('STRATEGIC HUBS', style: text.headlineLarge),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'Our primary command centers are strategically positioned at '
                'the nexus of global trade routes, ensuring continuous movement '
                'of assets through high-efficiency industrial gateways.',
                style: text.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (isMobile)
              Column(
                children: <Widget>[
                  for (final HubItem hub in hubs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _HubCard(hub: hub),
                    ),
                ],
              )
            else
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (int i = 0; i < hubs.length; i++) ...<Widget>[
                      Expanded(child: _HubCard(hub: hubs[i])),
                      if (i < hubs.length - 1)
                        const SizedBox(width: AppSpacing.md),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  const _HubCard({required this.hub});

  final HubItem hub;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: const Color(0xFFE9ECEF),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EyebrowLabel(hub.region),
          const SizedBox(height: AppSpacing.sm),
          Text(hub.city, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          _LabelledValue(label: 'ADDRESS', value: hub.address),
          const SizedBox(height: AppSpacing.md),
          _LabelledValue(label: 'CAPACITY', value: hub.capacity),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: <Widget>[
              Text(
                'TERMINAL DETAILS',
                style: text.labelMedium?.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.north_east,
                  size: 13, color: AppColors.textPrimary,),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabelledValue extends StatelessWidget {
  const _LabelledValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: text.labelMedium?.copyWith(color: AppColors.textTertiary),),
        const SizedBox(height: 4),
        Text(value, style: text.bodyMedium?.copyWith(height: 1.4)),
      ],
    );
  }
}

class _MaritimeSection extends StatelessWidget {
  const _MaritimeSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget image = SizedBox(
      height: isMobile ? 260 : 420,
      child: SafeNetworkImage(url: ContentRepository.services[1].imageUrl),
    );

    final Widget detail = Container(
      color: AppColors.black,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const EyebrowLabel('SCALE & PRECISION'),
          const SizedBox(height: AppSpacing.md),
          Text('MARITIME\nDOMINANCE AT\nSCALE.',
              style: text.headlineLarge?.copyWith(color: AppColors.white),),
          const SizedBox(height: AppSpacing.lg),
          const _FeatureRow(
            icon: Icons.directions_boat_outlined,
            title: 'Automated Fleet Management',
            body: 'Real-time telemetry and AI-driven route optimization ensure '
                'our vessels operate at peak efficiency with minimal '
                'environmental impact.',
          ),
          const SizedBox(height: AppSpacing.lg),
          const _FeatureRow(
            icon: Icons.precision_manufacturing_outlined,
            title: 'Technical Port Infrastructure',
            body: 'Proprietary crane automation systems reduce vessel '
                'turnaround time by 22% compared to industry standards.',
          ),
          const SizedBox(height: AppSpacing.xl),
          MxButton(
            label: 'Download Network Report',
            filled: false,
            onDark: true,
            onPressed: () {},
          ),
        ],
      ),
    );

    return ColoredBox(
      color: AppColors.black,
      child: isMobile
          ? Column(children: <Widget>[image, detail])
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: image),
                  Expanded(child: detail),
                ],
              ),
            ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 18, color: AppColors.accentMuted),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: text.titleMedium?.copyWith(color: AppColors.white),),
              const SizedBox(height: 4),
              Text(body,
                  style: text.bodyMedium
                      ?.copyWith(color: AppColors.textOnDarkSecondary),),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataAccessSection extends StatelessWidget {
  const _DataAccessSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('REAL-TIME\nDATA ACCESS.', style: text.headlineLarge),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Text(
            'Connect to our global API to integrate real-time tracking and '
            'logistics infrastructure data directly into your enterprise ERP.',
            style: text.bodyMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _ApiRow(label: 'API DOCUMENTATION', trailing: '< >'),
        const SizedBox(height: AppSpacing.sm),
        const _ApiRow(label: 'NETWORK LATENCY', trailing: '14ms'),
      ],
    );

    final Widget right = Container(
      height: isMobile ? 220 : 260,
      color: AppColors.black,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'LIVE NETWORK STATUS: OPERATIONAL',
              style: text.labelMedium?.copyWith(
                color: AppColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );

    return ColoredBox(
      color: const Color(0xFFE9ECEF),
      child: ContentContainer(
        child: isMobile
            ? Column(children: <Widget>[
                left,
                const SizedBox(height: AppSpacing.lg),
                right,
              ],)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(child: right),
                ],
              ),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.label, required this.trailing});

  final String label;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label,
              style: text.labelMedium
                  ?.copyWith(color: AppColors.textPrimary, letterSpacing: 1.2),),
          Text(trailing,
              style: text.bodyMedium?.copyWith(color: AppColors.textTertiary),),
        ],
      ),
    );
  }
}
