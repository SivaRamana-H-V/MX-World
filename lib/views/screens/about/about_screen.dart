import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/models/content_models.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/mx_button.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';
import 'package:mxworld/views/widgets/common/stats_strip.dart';

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
        _QuickInquiryForm(),
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
      color: const Color(0xFF0F1720),
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
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 640,
            minHeight: 300,
          ),
          child: ClipRect(
            child: Stack(
              children: <Widget>[
                const Positioned.fill(
                  child: Opacity(
                    opacity: 0.2,
                    child: SafeNetworkImage(
                      url: ContentRepository.heroImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'READY TO NAVIGATE?',
                        style: text.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Text(
                          'Discover how our global network and expertise can '
                          'transform your supply chain into a competitive '
                          'advantage.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickInquiryForm extends StatefulWidget {
  const _QuickInquiryForm();

  @override
  State<_QuickInquiryForm> createState() => _QuickInquiryFormState();
}

class _QuickInquiryFormState extends State<_QuickInquiryForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget form = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _FormField(
          controller: _nameController,
          hint: 'Your Name',
        ),
        const SizedBox(height: AppSpacing.lg),
        _FormField(
          controller: _emailController,
          hint: 'Your Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.lg),
        _FormField(
          controller: _messageController,
          hint: 'Message',
          maxLines: 3,
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: 52,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: () {},
            child: Text(
              'SUBMIT NOW',
              style: text.labelLarge?.copyWith(
                color: AppColors.white,
                fontSize: 12,
                letterSpacing: 1.8,
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      color: const Color(0xFFD9E2EC),
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Quick Inquiry',
                      style: text.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Have a specific logistics challenge? Reach out to our '
                      'global team for a tailored solution.',
                      style: text.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    form,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quick Inquiry',
                              style: text.headlineLarge,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Have a specific logistics challenge? Reach out '
                              'to our global team for a tailored solution that '
                              'meets your scale and precision requirements.',
                              style: text.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.section),
                    Expanded(flex: 5, child: form),
                  ],
                ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: maxLines > 1
          ? TextCapitalization.sentences
          : TextCapitalization.words,
      style: text.bodyLarge?.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: text.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1),
        ),
        fillColor: AppColors.white,
        filled: true,
      ),
    );
  }
}
