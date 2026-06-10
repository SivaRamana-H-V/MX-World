import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_button.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/reveal_on_scroll.dart';
import '../../widgets/common/safe_network_image.dart';

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
        _EngineeringReach(),
        _QuickInquiryForm(),
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
          style: text.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Our interconnected network operates across every major trade lane, '
          'powered by over 85,000 professionals at nearly 1,300 sites in close '
          'to 100 countries. We are the logistics partner of choice for '
          '400,000 worldwide customers, providing a seamless architecture '
          'for global trade.',
          style: text.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'From sea and air freight to complex 4PL integrated logistics, '
          'every touchpoint in the fulfillment cycle is optimized for '
          'visibility, speed, and reliability.',
          style: text.bodyMedium,
        ),
      ],
    );

    final Widget right = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.lg,
      mainAxisSpacing: AppSpacing.lg,
      childAspectRatio: 1.5,
      children: <Widget>[
        for (final StatItem stat in ContentRepository.whyChooseUsStats)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                stat.value,
                style: text.displayMedium?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                stat.label,
                style: text.labelMedium?.copyWith(
                  color: AppColors.textTertiary,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
      ],
    );

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        vertical: AppSpacing.section,
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
                  Expanded(flex: 5, child: left),
                  const SizedBox(width: AppSpacing.section),
                  Expanded(flex: 5, child: right),
                ],
              ),
      ),
    );
  }
}

class _CoreServices extends StatelessWidget {
  const _CoreServices();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;
    const List<ServiceItem> services = ContentRepository.services;

    return Container(
      color: const Color(0xFFF0F2F4),
      child: ContentContainer(
        vertical: AppSpacing.section,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const EyebrowLabel('CORE LOGISTICS'),
            const SizedBox(height: AppSpacing.md),
            Text('SERVICES', style: text.headlineLarge),
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
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      height: 340,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeNetworkImage(url: service.imageUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.88),
                  AppColors.black.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                service.title.toUpperCase(),
                style: text.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
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

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        vertical: AppSpacing.section,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const EyebrowLabel('STRATEGIC OPERATIONS'),
            const SizedBox(height: AppSpacing.md),
            if (isMobile)
              Column(
                children: <Widget>[
                  Text('PORTFOLIO OF SCALE', style: text.headlineLarge),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Our track record spans continents, managing the movement '
                    'of essential cargo through the world\'s most sophisticated '
                    'transit hubs.',
                    style: text.bodyMedium,
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'PORTFOLIO OF SCALE',
                      style: text.headlineLarge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Text(
                        'Our track record spans continents, managing the '
                        'movement of essential cargo through the world\'s most '
                        'sophisticated transit hubs with 4PL Integrated '
                        'Logistics.',
                        style: text.bodyMedium,
                      ),
                    ),
                  ),
                ],
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
              child: _PortfolioCard(item: items[i], height: 260),
            ),
        ],
      );
    }
    return Column(
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(flex: 3, child: _PortfolioCard(item: items[0])),
              const SizedBox(width: AppSpacing.md),
              Expanded(flex: 2, child: _PortfolioCard(item: items[1])),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _PortfolioCard(item: items[2])),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _PortfolioCard(item: items[3])),
            ],
          ),
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, this.height = 320});

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
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
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

class _EngineeringReach extends StatelessWidget {
  const _EngineeringReach();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget left = Padding(
      padding: EdgeInsets.only(right: isMobile ? 0 : AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const EyebrowLabel('ENGINEERING'),
          const SizedBox(height: AppSpacing.md),
          Text(
            'GLOBAL\nREACH.',
            style: text.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'We are architects of global infrastructure. Every hub, vessel, '
            'and sortation center is engineered for operational transparency '
            'at scale. Our integrated network moves over 12 million metric '
            'tons annually with 99.9% reliability.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'From predictive routing algorithms to automated customs '
            'clearance, our technology stack delivers end-to-end visibility '
            'across the entire fulfillment lifecycle.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xl),
          MxButton(
            label: 'Explore Global Network',
            filled: true,
            onPressed: () {},
          ),
        ],
      ),
    );

    final Widget right = AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRect(
        child: SafeNetworkImage(
          url: ContentRepository.services[1].imageUrl,
          onDark: false,
        ),
      ),
    );

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        vertical: AppSpacing.section,
        child: isMobile
            ? Column(
                children: <Widget>[
                  left,
                  const SizedBox(height: AppSpacing.xl),
                  right,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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

class _QuickInquiryForm extends StatefulWidget {
  const _QuickInquiryForm();

  @override
  State<_QuickInquiryForm> createState() => _QuickInquiryFormState();
}

class _QuickInquiryFormState extends State<_QuickInquiryForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          hint: 'Full Name',
        ),
        const SizedBox(height: AppSpacing.lg),
        _FormField(
          controller: _emailController,
          hint: 'Corporate Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.lg),
        _FormField(
          controller: _phoneController,
          hint: 'Phone',
          keyboardType: TextInputType.phone,
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
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: () {},
            child: Text(
              'SUBMIT ENQUIRY',
              style: text.labelLarge?.copyWith(
                color: AppColors.black,
                fontSize: 12,
                letterSpacing: 1.8,
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      color: AppColors.black,
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
                      'QUICK\nINQUIRY.',
                      style: text.displayMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Have a specific logistics challenge? Reach out to our '
                      'global team for a tailored solution.',
                      style: text.bodyMedium?.copyWith(
                        color: AppColors.textOnDarkSecondary,
                      ),
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
                              'QUICK\nINQUIRY.',
                              style: text.displayMedium?.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Have a specific logistics challenge? Reach out '
                              'to our global team for a tailored solution that '
                              'meets your scale and precision requirements.',
                              style: text.bodyMedium?.copyWith(
                                color: AppColors.textOnDarkSecondary,
                              ),
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
      style: text.bodyLarge?.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: text.bodyMedium?.copyWith(
          color: AppColors.textOnDarkTertiary,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 1),
        ),
      ),
    );
  }
}
