import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_button.dart';
import '../../widgets/common/mx_page_scaffold.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      sections: <Widget>[
        _HeroSection(),
        _WhyChooseUs(),
        _ServicesSummary(),
        _DetailedServices(),
        _ProcessSection(),
        _IndustriesSection(),
        _ClientSection(),
        _AboutSection(),
        _CtaSection(),
        _FinalCta(),
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

    return Container(
      color: AppColors.black,
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const EyebrowLabel('FREIGHT FORWARDING & LOGISTICS'),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Global Freight Forwarding\nWith Reliable Execution.',
            style: (isMobile ? text.displayMedium : text.displayLarge)
                ?.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'End-to-end logistics solutions for air freight, ocean freight, '
              'customs clearance, transportation, and warehousing \u2014 '
              'supported by responsive coordination and global partner networks.',
              style: text.bodyLarge?.copyWith(
                color: AppColors.textOnDarkSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: <Widget>[
              MxButton(
                label: 'Request a Quote',
                onPressed: () {},
              ),
              const SizedBox(width: AppSpacing.md),
              MxButton(
                label: 'Track Shipment',
                filled: false,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: isMobile ? double.infinity : 480,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            color: AppColors.charcoal,
            child: Text(
              'Supporting importers and exporters with efficient cargo movement '
              'across international trade lanes.',
              style: text.bodySmall?.copyWith(
                color: AppColors.textOnDarkSecondary,
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

  static const List<_WhyItem> _items = <_WhyItem>[
    _WhyItem(
      'Responsive Communication',
      'Fast quotation support and proactive shipment updates.',
    ),
    _WhyItem(
      'Global Network',
      'Reliable overseas agent partnerships across major trade routes.',
    ),
    _WhyItem(
      'Operational Transparency',
      'Clear coordination from booking to final delivery.',
    ),
    _WhyItem(
      'Flexible Logistics Solutions',
      'Customized freight planning based on cargo requirements and timelines.',
    ),
    _WhyItem(
      'Dedicated Shipment Support',
      'Single point of contact for complete shipment coordination.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Why Businesses Work With Us',
              style: text.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (isMobile)
              Column(
                children: <Widget>[
                  for (final _WhyItem item in _items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _WhyCard(item: item),
                    ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < _items.length; i++) ...[
                    Expanded(child: _WhyCard(item: _items[i])),
                    if (i < _items.length - 1)
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

class _WhyItem {
  const _WhyItem(this.title, this.body);
  final String title;
  final String body;
}

class _WhyCard extends StatelessWidget {
  const _WhyCard({required this.item});
  final _WhyItem item;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title,
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          item.body,
          style: text.bodyMedium,
        ),
      ],
    );
  }
}

class _ServicesSummary extends StatelessWidget {
  const _ServicesSummary();

  static const List<_ServiceCardData> _services = <_ServiceCardData>[
    _ServiceCardData(
      'Ocean Freight',
      'Reliable FCL and LCL solutions with competitive routing and shipment coordination across global ports.',
    ),
    _ServiceCardData(
      'Air Freight',
      'Fast and secure air cargo solutions for urgent and time-sensitive shipments.',
    ),
    _ServiceCardData(
      'Customs Clearance',
      'Accurate documentation and customs support to ensure smooth cargo movement.',
    ),
    _ServiceCardData(
      'Transportation',
      'Efficient inland transportation and last-mile delivery coordination.',
    ),
    _ServiceCardData(
      'Warehousing',
      'Flexible storage, cargo handling, and inventory support solutions.',
    ),
    _ServiceCardData(
      'Project Cargo',
      'Specialized logistics handling for oversized and industrial cargo movements.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: const Color(0xFFF4F6F8),
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Comprehensive Freight & Logistics Services',
              style: text.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (isMobile)
              Column(
                children: <Widget>[
                  for (final _ServiceCardData svc in _services)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _SummaryCard(data: svc),
                    ),
                ],
              )
            else
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: <Widget>[
                  for (final _ServiceCardData svc in _services)
                    SizedBox(
                      width: (AppSpacing.maxContentWidth - AppSpacing.md * 2) / 3,
                      child: _SummaryCard(data: svc),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCardData {
  const _ServiceCardData(this.title, this.body);
  final String title;
  final String body;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.data});
  final _ServiceCardData data;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.title,
            style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(data.body, style: text.bodyMedium),
        ],
      ),
    );
  }
}

class _DetailedServices extends StatelessWidget {
  const _DetailedServices();

  static const List<_DetailService> _services = <_DetailService>[
    _DetailService(
      'OCEAN FREIGHT',
      'Ocean Freight Services',
      'We provide reliable FCL and LCL shipping solutions through trusted '
      'carrier partnerships and international logistics networks. Our team '
      'coordinates cargo movement from origin to destination with complete '
      'shipment visibility and operational support.',
      <String>[
        'Full Container Load (FCL)',
        'Less than Container Load (LCL)',
        'Import & Export Handling',
        "Buyer's Consolidation",
        'Port Coordination',
        'Documentation Support',
        'Door-to-Door Solutions',
      ],
    ),
    _DetailService(
      'AIR FREIGHT',
      'Air Freight Services',
      'Our air freight solutions are designed for urgent, high-value, and '
      'time-sensitive shipments requiring faster transit and reliable handling.',
      <String>[
        'Airport-to-Airport',
        'Door-to-Door Air Cargo',
        'Express Cargo Handling',
        'Consolidation Services',
        'Priority Shipments',
        'DG Cargo Coordination',
      ],
    ),
    _DetailService(
      'CUSTOMS CLEARANCE',
      'Customs Clearance Solutions',
      'We assist businesses with customs documentation and cargo clearance '
      'processes to ensure compliant and efficient cargo movement.',
      <String>[
        'Import Customs Clearance',
        'Export Customs Clearance',
        'Documentation Handling',
        'HS Code Assistance',
        'Duty & Compliance Support',
      ],
    ),
    _DetailService(
      'TRANSPORTATION',
      'Inland Transportation',
      'Efficient cargo transportation and last-mile delivery solutions with '
      'operational coordination and shipment tracking support.',
      <String>[
        'Container Transportation',
        'Trailer Coordination',
        'Pickup & Delivery',
        'Factory Stuffing Coordination',
        'Intercity Cargo Movement',
      ],
    ),
    _DetailService(
      'WAREHOUSING',
      'Warehousing & Distribution',
      'Flexible warehousing and cargo handling solutions designed to improve '
      'inventory management and supply chain operations.',
      <String>[
        'Cargo Storage',
        'Inventory Handling',
        'Distribution Support',
        'Cargo Packaging',
        'Loading & Unloading',
      ],
    ),
    _DetailService(
      'PROJECT CARGO',
      'Project Cargo & Specialized Logistics',
      'Specialized logistics planning and handling solutions for oversized, '
      'heavy-lift, and industrial cargo shipments.',
      <String>[
        'Heavy Equipment Handling',
        'ODC Cargo Coordination',
        'Industrial Cargo Transport',
        'Route Planning',
        'Specialized Shipment Support',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const EyebrowLabel('OUR SERVICES'),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Freight Forwarding & Logistics Services',
              style: text.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Integrated logistics solutions designed to support global cargo '
              'movement with efficiency, visibility, and operational reliability.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (isMobile)
              Column(
                children: <Widget>[
                  for (final _DetailService svc in _services)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                      child: _DetailCard(service: svc),
                    ),
                ],
              )
            else
              Column(
                children: <Widget>[
                  for (int i = 0; i < _services.length; i++) ...[
                    if (i > 0) const SizedBox(height: AppSpacing.xl),
                    _DetailCard(service: _services[i]),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailService {
  const _DetailService(
    this.category,
    this.title,
    this.description,
    this.items,
  );
  final String category;
  final String title;
  final String description;
  final List<String> items;
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.service});
  final _DetailService service;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EyebrowLabel(service.category),
        const SizedBox(height: AppSpacing.sm),
        Text(service.title, style: text.headlineMedium),
        const SizedBox(height: AppSpacing.md),
        Text(service.description, style: text.bodyMedium),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Services Include:',
          style: text.labelLarge?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final String item in service.items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 6, right: AppSpacing.sm),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(item, style: text.bodyMedium),
                ),
              ],
            ),
          ),
      ],
    );

    return isMobile
        ? content
        : Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.xl),
                  child: content,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: 240,
                  color: const Color(0xFFF4F6F8),
                  child: Center(
                    child: Text(
                      service.category,
                      style: text.labelMedium?.copyWith(
                        color: AppColors.textTertiary,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class _ProcessSection extends StatelessWidget {
  const _ProcessSection();

  static const List<_ProcessStep> _steps = <_ProcessStep>[
    _ProcessStep('1', 'Shipment Inquiry', 'Share cargo details and shipment requirements.'),
    _ProcessStep('2', 'Planning & Quotation', 'Receive optimized freight and routing solutions.'),
    _ProcessStep('3', 'Cargo Coordination', 'Pickup, documentation, customs, and carrier handling.'),
    _ProcessStep('4', 'Delivery & Tracking', 'Real-time updates and final delivery coordination.'),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.black,
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Freight Process',
                style: text.headlineLarge?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (isMobile)
                Column(
                  children: <Widget>[
                    for (final _ProcessStep step in _steps)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: _StepCard(step: step),
                      ),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    for (int i = 0; i < _steps.length; i++) ...[
                      Expanded(child: _StepCard(step: _steps[i])),
                      if (i < _steps.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.accentMuted,
                            size: 18,
                          ),
                        ),
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

class _ProcessStep {
  const _ProcessStep(this.number, this.title, this.body);
  final String number;
  final String title;
  final String body;
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});
  final _ProcessStep step;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      color: AppColors.charcoal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            color: AppColors.accent,
            alignment: Alignment.center,
            child: Text(
              step.number,
              style: text.labelLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            step.title,
            style: text.titleMedium?.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            step.body,
            style: text.bodyMedium?.copyWith(
              color: AppColors.textOnDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _IndustriesSection extends StatelessWidget {
  const _IndustriesSection();

  static const List<String> _industries = <String>[
    'Automotive',
    'Engineering Goods',
    'Electronics',
    'Textile & Garments',
    'Retail & E-commerce',
    'Machinery',
    'Chemicals',
    'Pharma',
    'Industrial Cargo',
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: const Color(0xFFF4F6F8),
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Industries We Support',
              style: text.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                for (final String industry in _industries)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm + 4,
                    ),
                    color: AppColors.white,
                    child: Text(
                      industry,
                      style: text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientSection extends StatelessWidget {
  const _ClientSection();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.white,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Trusted Logistics Coordination For Growing Businesses',
              style: text.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'We support importers, exporters, traders, manufacturers, and '
                'supply chain partners with dependable freight forwarding '
                'services tailored to operational requirements.',
                style: text.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: const Color(0xFFF4F6F8),
      child: ContentContainer(
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Modern Logistics Solutions Built Around Your Supply Chain',
                    style: text.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'We provide customized freight forwarding and logistics '
                    'services designed to simplify international cargo movement. '
                    'From shipment planning and carrier coordination to customs '
                    'clearance and final delivery, our team ensures smooth '
                    'operational handling at every stage.',
                    style: text.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'With strong overseas partnerships and responsive '
                    'communication, we help businesses move cargo with greater '
                    'visibility, efficiency, and control.',
                    style: text.bodyMedium,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xl),
                      child: Text(
                        'Modern Logistics Solutions Built Around Your Supply Chain',
                        style: text.headlineLarge,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'We provide customized freight forwarding and logistics '
                          'services designed to simplify international cargo '
                          'movement. From shipment planning and carrier '
                          'coordination to customs clearance and final delivery, '
                          'our team ensures smooth operational handling at every '
                          'stage.',
                          style: text.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'With strong overseas partnerships and responsive '
                          'communication, we help businesses move cargo with '
                          'greater visibility, efficiency, and control.',
                          style: text.bodyMedium,
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

class _CtaSection extends StatelessWidget {
  const _CtaSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.black,
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: <Widget>[
              Text(
                'Looking for Reliable Freight Forwarding Support?',
                style: text.headlineLarge?.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Text(
                  'Connect with our logistics team for customized shipping '
                  'solutions and responsive operational support.',
                  style: text.bodyMedium?.copyWith(
                    color: AppColors.textOnDarkSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MxButton(
                    label: 'Get Freight Quote',
                    onPressed: () {},
                  ),
                  const SizedBox(width: AppSpacing.md),
                  MxButton(
                    label: 'Contact Us',
                    filled: false,
                    onPressed: () {},
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

class _FinalCta extends StatelessWidget {
  const _FinalCta();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final TextTheme text = Theme.of(context).textTheme;

    return Container(
      color: AppColors.white,
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: <Widget>[
              Text(
                'Need Customized Logistics Solutions?',
                style: text.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Text(
                  'Our team is ready to support your import and export operations '
                  'with reliable freight coordination and responsive logistics '
                  'support.',
                  style: text.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MxButton(
                    label: 'Request Quote',
                    onPressed: () {},
                  ),
                  const SizedBox(width: AppSpacing.md),
                  MxButton(
                    label: 'Speak With Our Team',
                    filled: false,
                    onPressed: () {},
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
