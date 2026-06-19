import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';

/// Column of links rendered in the footer.
@immutable
class FooterColumn {
  const FooterColumn(this.title, this.items);
  final String title;
  final List<String> items;
}

/// The dark global footer shown at the bottom of every screen.
///
/// Lays out the brand blurb plus several link columns, collapsing into a
/// single column on mobile, and a legal bar beneath.
class MxFooter extends StatelessWidget {
  const MxFooter({super.key, this.columns});

  final List<FooterColumn>? columns;

  static const List<FooterColumn> _defaultColumns = <FooterColumn>[
    FooterColumn('TRANSPORTATION', <String>[
      'Sea Freight',
      'Air Freight',
      'Road Transport',
      'Rail Logistics',
      'Intermodal',
    ]),
    FooterColumn('SOLUTIONS', <String>[
      '4PL Integration',
      'Cold Chain',
      'Customs Clearance',
      'Warehousing',
      'Project Logistics',
    ]),
    FooterColumn('DIGITAL SERVICES', <String>[
      'API Integration',
      'Real-Time Tracking',
      'Analytics Suite',
      'Digital Twin',
      'Blockchain Docs',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool useRowLayout = width >= 900;
    final TextTheme text = Theme.of(context).textTheme;

    final Widget brand = SizedBox(
      width: useRowLayout ? 280 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/logo_dark.png',
            height: 40,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'A global leader in freight forwarding and supply chain '
            'management. We engineer the future of trade through data-driven '
            'precision and a network of 85,000 professionals.',
            style: text.bodyMedium?.copyWith(
              color: AppColors.textOnDarkSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: <Widget>[
              for (final IconData icon in <IconData>[
                Icons.share_outlined,
                Icons.language_outlined,
                Icons.hub_outlined,
              ])
                Container(
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Icon(icon, size: 16, color: AppColors.white),
                ),
            ],
          ),
        ],
      ),
    );

    final List<FooterColumn> effectiveColumns =
        columns ?? _defaultColumns;

    final List<Widget> linkColumns = <Widget>[
      for (final FooterColumn col in effectiveColumns)
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                col.title,
                style: text.labelMedium?.copyWith(
                  color: AppColors.textOnDarkTertiary,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final String item in col.items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
                  child: Text(
                    item,
                    style: text.bodyMedium?.copyWith(
                      color: AppColors.textOnDarkSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ];

    return ColoredBox(
      color: AppColors.black,
      child: Padding(
        padding: AppSpacing.pageGutter(width)
            .copyWith(top: AppSpacing.section, bottom: AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (useRowLayout)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 280, child: brand),
                  const Spacer(),
                  for (int i = 0; i < linkColumns.length; i++) ...[
                    if (i > 0) const SizedBox(width: 40),
                    Flexible(child: linkColumns[i]),
                  ],
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  brand,
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    spacing: AppSpacing.xl,
                    runSpacing: AppSpacing.xl,
                    children: linkColumns,
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.section),
            const Divider(color: AppColors.borderDark, height: 1),
            const SizedBox(height: AppSpacing.lg),
            _LegalBar(isCompact: !useRowLayout),
          ],
        ),
      ),
    );
  }
}

class _LegalBar extends StatelessWidget {
  const _LegalBar({required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textOnDarkTertiary,
          letterSpacing: 0.8,
        );
    final Widget copyright = Text(
      '© 2026 MX WORLD GLOBAL LOGISTICS. ALL RIGHTS RESERVED.',
      style: style,
    );
    final Widget developer = GestureDetector(
      onTap: () => launchUrl(Uri.parse('https://www.notedquicly.com')),
      child: Text(
        'Design and Developed by Noted Quicly',
        style: style?.copyWith(
          color: AppColors.accent,
          decoration: TextDecoration.underline,
        ),
      ),
    );
    final Widget links = Wrap(
      spacing: AppSpacing.lg,
      children: <Widget>[
        for (final String legal in <String>[
          'PRIVACY POLICY',
          'TERMS OF SERVICE',
          'CODE OF ETHICS',
        ])
          GestureDetector(
            onTap: () => context.go('/contact'),
            child: Text(legal, style: style),
          ),
      ],
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          copyright,
          const SizedBox(height: 8),
          developer,
          const SizedBox(height: 12),
          links,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        copyright,
        const SizedBox(width: 24),
        developer,
        const Spacer(),
        Flexible(child: links),
      ],
    );
  }
}
