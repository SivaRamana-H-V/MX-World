import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/models/content_models.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/animated_counter.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/inquiry_form.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';
import 'package:mxworld/views/widgets/common/reveal_on_scroll.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';
import 'package:mxworld/views/widgets/common/under_development.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      sections: <Widget>[
        _HeroSection(),
        _WhyChooseUs(),
        _CoreServices(),
        _PortfolioSection(),
        InquiryForm(),
      ],
    );
  }
}

// ── Hero ─────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      height: isMobile ? 520 : 640,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const SafeNetworkImage(url: ContentRepository.heroImage),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.9),
                  AppColors.black.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                AppSpacing.pageGutter(width).copyWith(bottom: AppSpacing.xxl),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: RevealOnScroll(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'GLOBAL LOGISTICS\nREDEFINED.',
                        style:
                            (isMobile ? text.displayMedium : text.displayLarge)
                                ?.copyWith(
                          color: AppColors.white,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Container(width: 64, height: 2, color: AppColors.white),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'End-to-end visibility and world-class freight solutions. '
                        'Mastering the complexity of global infrastructure through '
                        'high-fidelity operational transparency.',
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
          ),
        ],
      ),
    );
  }
}

// ── Why Choose Us ─────────────────────────────────────────────────────────────

class _WhyChooseUs extends StatelessWidget {
  const _WhyChooseUs();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const EyebrowLabel('WHY CHOOSE US'),
        const SizedBox(height: AppSpacing.md),
        Text(
          'A GLOBAL NETWORK\nBUILT FOR SCALE.',
          style: text.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Our interconnected network operates across every major trade lane, '
          'powered by over 85,000 professionals at nearly 1,300 sites in close '
          'to 100 countries.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.5),
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: () => showUnderDevelopment(context),
          child: Text(
            'DISCOVER MORE →',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontSize: 13,
                ),
          ),
        ),
      ],
    );

    final Widget right = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.xl,
      mainAxisSpacing: AppSpacing.xl,
      childAspectRatio: 1.8,
      children: <Widget>[
        for (final StatItem stat in ContentRepository.whyChooseUsStats)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedCounter(
                value: stat.value,
                style: text.displayMedium?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                stat.label.toUpperCase(),
                style: text.labelMedium?.copyWith(
                  color: AppColors.textTertiary,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
      ],
    );

    return RevealOnScroll(
      child: ColoredBox(
        color: AppColors.white,
        child: ContentContainer(
          child: isMobile
              ? Column(
                  children: <Widget>[
                    left,
                    const SizedBox(height: AppSpacing.xxl),
                    right,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 5, child: left),
                    const SizedBox(width: AppSpacing.section),
                    Expanded(flex: 5, child: right),
                  ],
                ),
        ),
      ),
    );
  }
}

// ── Core Services ─────────────────────────────────────────────────────────────

class _CoreServices extends StatelessWidget {
  const _CoreServices();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;
    const List<ServiceItem> services = ContentRepository.services;

    return RevealOnScroll(
      child: ColoredBox(
        color: const Color(0xFFF5F7F9),
        child: ContentContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const EyebrowLabel('REAL-TIME CAPABILITIES'),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'CORE LOGISTICS\nSERVICES',
                        style: text.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  if (!isMobile)
                    GestureDetector(
                      onTap: () => context.go('/services'),
                      child: Text(
                        'VIEW ALL SERVICES →',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              fontSize: 13,
                            ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              if (isMobile)
                Column(
                  children: <Widget>[
                    for (final ServiceItem service in services)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _ServiceCard(service: service),
                      ),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    for (int i = 0; i < services.length; i++) ...<Widget>[
                      Expanded(child: _ServiceCard(service: services[i])),
                      if (i < services.length - 1)
                        const SizedBox(width: AppSpacing.md),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({required this.service});
  final ServiceItem service;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: _hovered ? 440 : 420,
          child: GestureDetector(
            onTap: () => context.go('/services'),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SafeNetworkImage(url: widget.service.imageUrl),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        AppColors.black.withValues(alpha: 0.85),
                        AppColors.black.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: text.titleMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: _hovered ? 1.8 : 1.2,
                        fontSize: _hovered ? 24 : 20,
                      ),
                      child: Text(
                        widget.service.title.toUpperCase(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Home Showcase ────────────────────────────────────────────────────────────

class _PortfolioSection extends StatelessWidget {
  const _PortfolioSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return RevealOnScroll(
      child: ColoredBox(
        color: AppColors.white,
        child: ContentContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EyebrowLabel('OPERATIONAL SHOWCASE'),
              const SizedBox(height: AppSpacing.md),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'HOME OF SCALE',
                          style: text.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Our track record spans continents, managing the movement '
                          'of essential cargo through the world\'s most sophisticated '
                          'transit hubs.',
                          style: text.bodyMedium
                              ?.copyWith(color: AppColors.textTertiary),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'HOME OF SCALE',
                            style: text.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(
                          child: Text(
                            'Our track record spans continents, managing the movement '
                            'of essential cargo through the world\'s most sophisticated '
                            'transit hubs with 4PL Integrated Logistics.',
                            style: text.bodyMedium?.copyWith(
                              color: AppColors.textTertiary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: AppSpacing.xxl),
              _PortfolioGrid(isMobile: isMobile),
            ],
          ),
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
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: _PortfolioCard(item: items[i], height: 280),
            ),
        ],
      );
    }
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: _PortfolioCard(item: items[0], height: 460),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              flex: 2,
              child: _PortfolioCard(item: items[1], height: 460),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _PortfolioCard(item: items[2], height: 320)),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: _PortfolioCard(item: items[3], height: 320)),
          ],
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, required this.height});
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
                end: Alignment.topCenter,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.85),
                  AppColors.black.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  color: AppColors.accent,
                  child: Text(
                    item.tag.toUpperCase(),
                    style: text.labelMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  item.title,
                  style: text.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.description,
                  style: text.bodyMedium
                      ?.copyWith(color: AppColors.textOnDarkSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
