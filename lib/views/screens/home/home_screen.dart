import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/reveal_on_scroll.dart';
import '../../widgets/common/safe_network_image.dart';
import '../../widgets/common/stats_strip.dart';

/// Landing screen presenting the hero statement and a portfolio grid of
/// flagship logistics capabilities, closing with headline metrics.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      currentRoute: '/home',
      navOnDark: false,
      sections: <Widget>[
        _HeroSection(),
        _PortfolioSection(),
        _StatsSection(),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      height: isMobile ? 480 : 560,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const SafeNetworkImage(url: ContentRepository.heroImage),
          // Darkening gradient for legibility of the overlaid headline.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.85),
                  AppColors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.pageGutter(width)
                .copyWith(bottom: AppSpacing.xxl),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: RevealOnScroll(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'GLOBAL LOGISTICS\nREDEFINED.',
                        style:
                            (isMobile ? text.displayMedium : text.displayLarge)
                                ?.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Container(width: 48, height: 2, color: AppColors.white),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'End-to-end visibility and world-class freight '
                        'solutions. Mastering the complexity of global '
                        'infrastructure through high-fidelity operational '
                        'transparency.',
                        style: text.bodyLarge?.copyWith(
                          color: AppColors.textOnDarkSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioSection extends StatelessWidget {
  const _PortfolioSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.offWhite,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RevealOnScroll(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const EyebrowLabel('STRATEGIC OPERATIONS'),
                  const SizedBox(height: AppSpacing.md),
                  if (isMobile) ...<Widget>[
                    Text('PORTFOLIO OF SCALE', style: text.headlineLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Our track record spans continents, managing the movement '
                      'of essential cargo through the world\'s most '
                      'sophisticated transit hubs with 4PL Integrated Logistics.',
                      style: text.bodyMedium,
                    ),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text('PORTFOLIO OF SCALE',
                              style: text.headlineLarge,),
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            child: Text(
                              'Our track record spans continents, managing the '
                              'movement of essential cargo through the world\'s '
                              'most sophisticated transit hubs with 4PL '
                              'Integrated Logistics.',
                              style: text.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _PortfolioGrid(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _PortfolioGrid extends StatelessWidget {
  const _PortfolioGrid({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    const List<PortfolioItem> items = ContentRepository.portfolio;
    if (isMobile) {
      return Column(
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: RevealOnScroll(
                delay: Duration(milliseconds: 80 * i),
                child: _PortfolioCard(item: items[i], height: 280),
              ),
            ),
        ],
      );
    }
    // Two staggered rows mirroring the design: large+small, then small+large.
    return Column(
      children: <Widget>[
        RevealOnScroll(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(flex: 3, child: _PortfolioCard(item: items[0])),
                const SizedBox(width: AppSpacing.md),
                Expanded(flex: 2, child: _PortfolioCard(item: items[1])),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        RevealOnScroll(
          delay: const Duration(milliseconds: 120),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(flex: 2, child: _PortfolioCard(item: items[2])),
                const SizedBox(width: AppSpacing.md),
                Expanded(flex: 3, child: _PortfolioCard(item: items[3])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, this.height = 340});

  final PortfolioItem item;
  final double height;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeNetworkImage(url: item.imageUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.82),
                  AppColors.black.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: 4,),
                  color: AppColors.accent,
                  child: Text(
                    item.tag,
                    style: text.labelMedium?.copyWith(
                      color: AppColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm + 2),
                Text(
                  item.title,
                  style: text.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.description,
                  style: text.bodyMedium?.copyWith(
                    color: AppColors.textOnDarkSecondary,
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

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.offWhite,
      child: ContentContainer(
        vertical: AppSpacing.xl,
        child: Column(
          children: <Widget>[
            Divider(color: Theme.of(context).dividerColor),
            const SizedBox(height: AppSpacing.xl),
            const RevealOnScroll(
              child: StatsStrip(stats: ContentRepository.homeStats),
            ),
            const SizedBox(height: AppSpacing.xl),
            Divider(color: Theme.of(context).dividerColor),
          ],
        ),
      ),
    );
  }
}
