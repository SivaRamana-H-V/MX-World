import 'package:flutter/material.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/models/content_models.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/mx_button.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';
import 'package:mxworld/views/widgets/common/reveal_on_scroll.dart';
import 'package:mxworld/views/widgets/common/safe_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      // Top Navigation Header included inside Scaffold layer if not handled globally,
      // or injected explicitly as the first item if using a scrolling layout container.
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

class _HeaderLink extends StatelessWidget {
  final String label;
  const _HeaderLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              fontSize: 13,
            ),
      ),
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
                  duration: const Duration(milliseconds: 800),
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
                        'End-to-end visibility and world-class freight solutions. Mastering the complexity of global infrastructure through high-fidelity operational transparency.',
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
          'Our interconnected network operates across every major trade lane, powered by over 85,000 professionals at nearly 1,300 sites in close to 100 countries.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.5),
        ),
        const SizedBox(height: AppSpacing.md),
        const _HeaderLink(label: 'DISCOVER MORE →'),
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
              Text(
                stat.value,
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

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        vertical: AppSpacing.section,
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
      color: const Color(0xFFF5F7F9),
      child: ContentContainer(
        vertical: AppSpacing.section,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EyebrowLabel('REAL-TIME CAPABILITIES'),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'CORE LOGISTICS\nSERVICES',
                      style: text.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                if (!isMobile) const _HeaderLink(label: 'VIEW ALL SERVICES'),
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
      height: 420,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeNetworkImage(url: service.imageUrl),
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
              child: Text(
                service.title.toUpperCase(),
                style: text.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
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
            const EyebrowLabel('OPERATIONAL SHOWCASE'),
            const SizedBox(height: AppSpacing.md),
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'PORTFOLIO OF SCALE',
                        style: text.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Our track record spans continents, managing the movement of essential cargo through the world\'s most sophisticated transit hubs.',
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
                          'PORTFOLIO OF SCALE',
                          style: text.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        child: Text(
                          'Our track record spans continents, managing the movement of essential cargo through the world\'s most sophisticated transit hubs with 4PL Integrated Logistics.',
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

class _EngineeringReach extends StatelessWidget {
  const _EngineeringReach();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const EyebrowLabel('ENGINEERING'),
        const SizedBox(height: AppSpacing.md),
        Text(
          'ENGINEERING GLOBAL\nREACH.',
          style: text.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'We are architects of global infrastructure. Every hub, vessel, and sortation center is engineered for operational transparency at scale. Our integrated network moves over 12 million metric tons annually with 99.9% reliability.',
          style: text.bodyMedium
              ?.copyWith(color: AppColors.textTertiary, height: 1.5),
        ),
        const SizedBox(height: AppSpacing.xl),
        MxButton(
          label: 'EXPLORE GLOBAL NETWORK',
          filled: true,
          onPressed: () {},
        ),
      ],
    );

    final Widget right = AspectRatio(
      aspectRatio: 4 / 3,
      child: SafeNetworkImage(
        url: ContentRepository.services[1].imageUrl,
        onDark: false,
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
                  const SizedBox(height: AppSpacing.xxl),
                  right,
                ],
              )
            : Row(
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

    final Widget formFields = Column(
      children: <Widget>[
        _FormField(controller: _nameController, hint: 'Full Name'),
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
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: () {},
            child: Text(
              'SUBMIT ENQUIRY',
              style: text.labelLarge?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      color: AppColors.black,
      child: ContentContainer(
        vertical: AppSpacing.section,
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'QUICK\nINQUIRY.',
                    style: text.displayMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Have a logistics challenge? Reach out for a tailored solution.',
                    style: text.bodyMedium
                        ?.copyWith(color: AppColors.textOnDarkSecondary),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  formFields,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'QUICK\nINQUIRY.',
                          style: text.displayMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Have a specific logistics challenge? Reach out to our global team for a tailored solution that meets your scale and precision requirements.',
                          style: text.bodyMedium?.copyWith(
                            color: AppColors.textOnDarkSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.section),
                  Expanded(flex: 6, child: formFields),
                ],
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
      style: text.bodyLarge?.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            text.bodyMedium?.copyWith(color: AppColors.textOnDarkTertiary),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 1.5),
        ),
      ),
    );
  }
}

// Minimal missing component definitions contextually injected helper fallback layout constraints:
class ContentContainer extends StatelessWidget {
  final Widget child;
  final double vertical;
  const ContentContainer({super.key, required this.child, this.vertical = 0.0});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: Padding(
          padding: AppSpacing.pageGutter(width)
              .copyWith(top: vertical, bottom: vertical),
          child: child,
        ),
      ),
    );
  }
}

class AppBreakpoints {
  static bool isMobile(double width) => width < 840;
}
