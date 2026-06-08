import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_button.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/safe_network_image.dart';
import '../../widgets/common/stats_strip.dart';

/// Company narrative screen: brand statement, operational-excellence detail,
/// value-driven solution list, performance metrics, and a closing CTA band.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      currentRoute: '/about',
      navOnDark: true,
      sections: <Widget>[
        _AboutHero(),
        _OperationalExcellence(),
        _AboutStatsBand(),
        _CtaBand(),
      ],
    );
  }
}

class _AboutHero extends StatelessWidget {
  const _AboutHero();

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
          bottom: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const EyebrowLabel('ABOUT MX WORLD'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'AUTOMATED\nINTELLIGENCE. GLOBAL\nSCALE.',
              style: (isMobile ? text.displayMedium : text.displayLarge)
                  ?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.lg),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                'We provide complete supply chain solutions across all '
                'transport modes for customers of every size. Using our global '
                'network, expertise, and data-based insights, we deliver '
                'value-driven supply chain management that powers modern '
                'commerce.',
                style: text.bodyLarge?.copyWith(
                  color: AppColors.textOnDarkSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              height: isMobile ? 160 : 220,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const SafeNetworkImage(url: ContentRepository.heroImage),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 24,
                            height: 1,
                            color: AppColors.textOnDarkTertiary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Flexible(
                            child: Text(
                              'GLOBAL LOGISTICS HUB // REAL-TIME OPS',
                              style: text.labelMedium?.copyWith(
                                color: AppColors.textOnDarkSecondary,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OperationalExcellence extends StatelessWidget {
  const _OperationalExcellence();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);

    final Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const EyebrowLabel(
          'CORE PRINCIPLES',
          color: AppColors.textTertiary,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'OPERATIONAL\nEXCELLENCE.',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Our global network is fueled by over 85,000 professionals worldwide '
          'at almost 1,300 sites in close to 100 countries. We are the '
          'logistics partner of choice for 400,000 worldwide customers, '
          'providing a seamless architecture for global trade.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'We focus on value-driven supply chain management, ensuring that '
          'every touchpoint in the fulfillment cycle is optimized for '
          'visibility, speed, and reliability. From sea and air freight to '
          'complex 4PL integrated logistics, we imagine more for your supply '
          'chain.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        const StatsStrip(
          stats: <StatItem>[
            StatItem(value: '85,000', label: 'GLOBAL PROFESSIONALS'),
            StatItem(value: '100+', label: 'COUNTRIES'),
          ],
          showDividers: false,
        ),
      ],
    );

    final Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 4 / 3,
          child: SafeNetworkImage(
            url: ContentRepository.portfolio.first.imageUrl,
            onDark: false,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _SolutionsCard(),
      ],
    );

    return ColoredBox(
      color: AppColors.offWhite,
      child: ContentContainer(
        child: isMobile
            ? Column(
                children: <Widget>[
                  left,
                  const SizedBox(height: AppSpacing.xl),
                  right,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: AppSpacing.section),
                  Expanded(child: right),
                ],
              ),
      ),
    );
  }
}

class _SolutionsCard extends StatelessWidget {
  const _SolutionsCard();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: const Color(0xFFE9ECEF),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'VALUE-DRIVEN SOLUTIONS',
            style: text.titleLarge?.copyWith(letterSpacing: 0.4),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final SolutionItem solution in ContentRepository.solutions)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm + 2),
                  Flexible(
                    child: Text(
                      solution.label,
                      style: text.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _AboutStatsBand extends StatelessWidget {
  const _AboutStatsBand();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.black,
      child: Theme(
        // Force dark text styling inside the dark band.
        data: Theme.of(context).copyWith(
          dividerColor: AppColors.borderDark,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppColors.white,
                displayColor: AppColors.white,
              ),
        ),
        child: const ContentContainer(
          vertical: AppSpacing.xxl,
          child: StatsStrip(
            stats: ContentRepository.aboutStats,
            onDark: true,
            showDividers: false,
          ),
        ),
      ),
    );
  }
}

class _CtaBand extends StatelessWidget {
  const _CtaBand();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: const Color(0xFFD9DDE2),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('READY TO NAVIGATE?', style: text.headlineLarge),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Text(
                'Discover how our global network and expertise can transform '
                'your supply chain into a competitive advantage.',
                textAlign: TextAlign.center,
                style: text.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MxButton(
                  label: 'Get a Quote',
                  onPressed: () => context.go('/contact'),
                ),
                const SizedBox(width: AppSpacing.md),
                MxButton(
                  label: 'Global Network',
                  filled: false,
                  onPressed: () => context.go('/network'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
