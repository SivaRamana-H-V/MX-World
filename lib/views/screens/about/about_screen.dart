import 'package:flutter/material.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/models/content_models.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/animated_counter.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/inquiry_form.dart';
import 'package:mxworld/views/widgets/common/mx_button.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';
import 'package:mxworld/views/widgets/common/reveal_on_scroll.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';
import 'package:mxworld/views/widgets/common/under_development.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      sections: <Widget>[
        _AboutHero(),
        _OperationalExcellence(),
        _AboutStatsBand(),
        _CtaBand(),
        InquiryForm(),
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

    return SizedBox(
      height: isMobile ? 540 : 680,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const SafeNetworkImage(
            url: ContentRepository.aboutHeroImage,
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.95),
                  AppColors.black.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.pageGutter(width).copyWith(
              top: AppSpacing.section,
              bottom: AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const EyebrowLabel('ABOUT MX WORLD'),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'AUTOMATED\nINTELLIGENCE. GLOBAL\nSCALE.',
                  style: (isMobile ? text.displayMedium : text.displayLarge)
                      ?.copyWith(
                    color: AppColors.white,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    'We provide complete supply chain solutions across all transport '
                    'modes for customers of every size. Using our global network, '
                    'expertise, and data-based insights, we deliver value-driven supply '
                    'chain management that powers modern commerce.',
                    style: text.bodyLarge?.copyWith(
                      color: AppColors.textOnDarkSecondary,
                      height: 1.6,
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

class _OperationalExcellence extends StatelessWidget {
  const _OperationalExcellence();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const EyebrowLabel('CORE PRINCIPLES', color: AppColors.textTertiary),
        const SizedBox(height: AppSpacing.md),
        Text(
          'OPERATIONAL\nEXCELLENCE.',
          style: text.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Our global network is fueled by over 85,000 professionals worldwide '
          'at almost 1,300 sites in close to 100 countries. We are the logistics '
          'partner of choice for 400,000 worldwide customers, providing a seamless '
          'architecture for global trade.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.6),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'We focus on value-driven supply chain management, ensuring that every '
          'touchpoint in the fulfillment cycle is optimized for visibility, speed, '
          'and reliability. From sea and air freight to complex 4PL integrated '
          'logistics, we imagine more for your supply chain.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.6),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedCounter(
                  value: '85,000',
                  style: text.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'GLOBAL PROFESSIONALS',
                  style: text.labelSmall?.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.xxl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedCounter(
                  value: '100+',
                  style: text.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'COUNTRIES',
                  style: text.labelSmall?.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    const Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 10,
          child: SafeNetworkImage(
            url: ContentRepository.heroImage,
            onDark: false,
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        _SolutionsCard(),
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
                    const Expanded(flex: 5, child: right),
                  ],
                ),
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
    return ColoredBox(
      color: const Color(0xFFF1F3F5),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'VALUE-DRIVEN SOLUTIONS',
              style: text.titleMedium?.copyWith(
                letterSpacing: 0.8,
                fontWeight: FontWeight.w800,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final SolutionItem solution in ContentRepository.solutions)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 16,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        solution.label.toUpperCase(),
                        style: text.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
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

class _AboutStatsBand extends StatelessWidget {
  const _AboutStatsBand();

  static const List<Map<String, String>> _stats = <Map<String, String>>[
    <String, String>{'val': '400K', 'lbl': 'WORLDWIDE CUSTOMERS'},
    <String, String>{'val': '1.3K', 'lbl': 'OPERATIONAL SITES'},
    <String, String>{'val': '24/7', 'lbl': 'GLOBAL SUPPORT'},
    <String, String>{'val': '365', 'lbl': 'DAYS A YEAR'},
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);

    return RevealOnScroll(
      child: ColoredBox(
        color: AppColors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
          child: ContentContainer(
            vertical: 0,
            child: isMobile
                ? Column(
                    children: _stats
                        .map(
                          (Map<String, String> s) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: _StatItem(
                              text: text,
                              val: s['val']!,
                              lbl: s['lbl']!,
                            ),
                          ),
                        )
                        .toList(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _stats
                        .map(
                          (Map<String, String> s) => Expanded(
                            child: _StatItem(
                              text: text,
                              val: s['val']!,
                              lbl: s['lbl']!,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.text,
    required this.val,
    required this.lbl,
  });

  final TextTheme text;
  final String val;
  final String lbl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedCounter(
          value: val,
          style: text.displayMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
            fontSize: 38,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          lbl,
          style: text.labelSmall?.copyWith(
            color: AppColors.textOnDarkTertiary,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CtaBand extends StatelessWidget {
  const _CtaBand();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);

    return RevealOnScroll(
      child: ColoredBox(
        color: const Color(0xFFE9ECEF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
          child: ContentContainer(
            vertical: 0,
            child: ColoredBox(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(
                  isMobile ? AppSpacing.lg : AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'About Us',
                          style: text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: AppColors.textTertiary,
                            ),
                            SizedBox(width: AppSpacing.md),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      'READY TO NAVIGATE?',
                      style: text.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.black,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Text(
                        'Discover how our global network and expertise can transform '
                        'your supply chain into a competitive advantage.',
                        textAlign: TextAlign.center,
                        style: text.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.sm,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        MxButton(
                          label: 'GET A QUOTE',
                          onPressed: () => showUnderDevelopment(context),
                        ),
                        MxButton(
                          label: 'GLOBAL NETWORK',
                          filled: false,
                          onPressed: () => showUnderDevelopment(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
