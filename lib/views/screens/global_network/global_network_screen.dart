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

class GlobalNetworkScreen extends StatelessWidget {
  const GlobalNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      sections: <Widget>[
        _NetworkHero(),
        _StrategicHubs(),
        _MaritimeSection(),
        _DataAccessSection(),
        _QuickInquirySection(),
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

    return Container(
      color: const Color(0xFF060D18),
      constraints: BoxConstraints(minHeight: isMobile ? 360 : 480),
      child: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: SafeNetworkImage(url: ContentRepository.heroImage),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: AppSpacing.pageGutter(width).copyWith(
                    top: AppSpacing.section,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'OUR GLOBAL REACH.',
                        style:
                            (isMobile ? text.displayMedium : text.displayLarge)
                                ?.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Text(
                          'Navigating the complexity of international trade '
                          'with precision engineering and a monolithic '
                          'infrastructure network spanning every major trade '
                          'lane on the planet.',
                          style: text.bodyLarge?.copyWith(
                            color: AppColors.textOnDarkSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: AppSpacing.pageGutter(width)
                    .copyWith(top: AppSpacing.lg, bottom: AppSpacing.lg),
                color: AppColors.black.withValues(alpha: 0.6),
                child: const StatsStrip(
                  stats: ContentRepository.networkStats,
                  onDark: true,
                ),
              ),
            ],
          ),
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

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('STRATEGIC HUBS', style: text.headlineLarge),
                    const SizedBox(height: AppSpacing.sm),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Text(
                        'Our primary command centers are strategically positioned '
                        'at the nexus of global trade routes.',
                        style: text.bodyMedium,
                      ),
                    ),
                  ],
                ),
                if (!isMobile)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: const Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: AppColors.borderLight,
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: const Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
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
    final List<String> addressLines = hub.address.split('\n');

    return Container(
      color: const Color(0xFFF0F2F4),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EyebrowLabel(hub.region),
          const SizedBox(height: AppSpacing.sm),
          Text(hub.city, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          _HubDetail(label: 'REGION', value: hub.region),
          const SizedBox(height: AppSpacing.sm),
          _HubDetail(label: 'CITY', value: hub.city),
          const SizedBox(height: AppSpacing.sm),
          _HubDetail(label: 'ADDRESS', value: addressLines.first),
          if (addressLines.length > 1) ...[
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 72),
              child: Text(
                addressLines.sublist(1).join(', '),
                style: text.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          _HubDetail(label: 'CAPACITY', value: hub.capacity),
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
              const Icon(
                Icons.north_east,
                size: 13,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HubDetail extends StatelessWidget {
  const _HubDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 68,
          child: Text(
            label,
            style: text.labelMedium?.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: text.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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
      height: isMobile ? 280 : 420,
      child: SafeNetworkImage(url: ContentRepository.services[1].imageUrl),
    );

    final Widget detail = Container(
      color: AppColors.black,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const EyebrowLabel('MARITIME DOMINANCE'),
          const SizedBox(height: AppSpacing.md),
          Text(
            'DOMINANCE AT\nSCALE.',
            style: text.headlineLarge?.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Automated fleet management with real-time telemetry and AI-driven '
            'route optimization ensures our vessels operate at peak efficiency '
            'with minimal environmental impact.',
            style: text.bodyMedium?.copyWith(
              color: AppColors.textOnDarkSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Proprietary crane automation systems reduce vessel turnaround '
            'time by 22% compared to industry standards.',
            style: text.bodyMedium?.copyWith(
              color: AppColors.textOnDarkSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          MxButton(
            label: 'Explore Maritime Solutions',
            filled: false,
            onDark: true,
            onPressed: () {},
          ),
        ],
      ),
    );

    return Container(
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

class _DataAccessSection extends StatelessWidget {
  const _DataAccessSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    const Widget left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _AccordionPanel(
          title: '1. TRACK & TRACE API',
          body:
              'Integrate real-time shipment tracking directly into your '
              'enterprise ERP. Our RESTful API provides granular visibility '
              'across all transport modes with webhook notifications.',
        ),
        SizedBox(height: AppSpacing.md),
        _AccordionPanel(
          title: '2. INTEGRATION HUB',
          body:
              'Connect your logistics infrastructure through our unified '
              'integration layer. Supports EDI, API, and flat-file formats '
              'for seamless data interchange.',
        ),
      ],
    );

    final Widget right = AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        color: AppColors.black,
        child: Center(
          child: Text(
            '[ DEMO INTERFACE PREVIEW ]',
            style: text.labelMedium?.copyWith(
              color: AppColors.textOnDarkTertiary,
              letterSpacing: 1.6,
            ),
          ),
        ),
      ),
    );

    return Container(
      color: const Color(0xFFF0F2F4),
      child: ContentContainer(
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('REAL-TIME DATA ACCESS.', style: text.headlineLarge),
                  const SizedBox(height: AppSpacing.lg),
                  left,
                  const SizedBox(height: AppSpacing.xl),
                  right,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'REAL-TIME\nDATA ACCESS.',
                          style: text.headlineLarge,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        left,
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(child: right),
                ],
              ),
      ),
    );
  }
}

class _AccordionPanel extends StatefulWidget {
  const _AccordionPanel({required this.title, required this.body});

  final String title;
  final String body;

  @override
  State<_AccordionPanel> createState() => _AccordionPanelState();
}

class _AccordionPanelState extends State<_AccordionPanel> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.title,
                      style: text.labelLarge?.copyWith(
                        color: AppColors.textPrimary,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.remove
                        : Icons.add,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Text(
                widget.body,
                style: text.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _QuickInquirySection extends StatefulWidget {
  const _QuickInquirySection();

  @override
  State<_QuickInquirySection> createState() => _QuickInquirySectionState();
}

class _QuickInquirySectionState extends State<_QuickInquirySection> {
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
        _InquiryField(
          controller: _nameController,
          hint: 'Full Name',
        ),
        const SizedBox(height: AppSpacing.lg),
        _InquiryField(
          controller: _emailController,
          hint: 'Corporate Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.lg),
        _InquiryField(
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
              'SUBMIT REQUEST',
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
      color: AppColors.white,
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
                      'Connect with our logistics engineering team.',
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
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Connect with our logistics engineering team '
                              'for custom infrastructure solutions and global '
                              'trade lane optimization.',
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

class _InquiryField extends StatelessWidget {
  const _InquiryField({
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
      ),
    );
  }
}
