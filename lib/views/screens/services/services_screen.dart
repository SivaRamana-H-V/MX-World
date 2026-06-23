import 'package:flutter/material.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/services/content_repository.dart';
import 'package:mxworld/views/widgets/common/eyebrow_label.dart';
import 'package:mxworld/views/widgets/common/mx_page_scaffold.dart';


class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MxPageScaffold(
      sections: <Widget>[
        _ServiceHeroBlock(
          eyebrow: 'GLOBAL FORWARDING',
          title: 'Air Freight',
          description:
              'Our air freight solutions are designed for urgent, high-value, and time-sensitive shipments requiring faster transit and reliable handling.',
          iconText: 'AIRPORT-TO-AIRPORT',
          imageUrl:
              ContentRepository.airFreightImage, // Using network paths now
          subServices: [
            'Airport-to-Airport Logistics',
            'Door-to-Door Air Cargo Delivery',
            'Express Cargo Sorting & Routing',
            'Consolidation Services',
            'Priority Time-Definite Shipments',
            'DG Cargo Coordination & Compliance',
          ],
        ),
        _ServiceHeroBlock(
          eyebrow: 'MARITIME LOGISTICS',
          title: 'Sea Freight',
          description:
              'We provide reliable FCL and LCL shipping solutions through trusted carrier partnerships and international logistics networks.',
          iconText: 'PORT COORDINATION',
          imageUrl: ContentRepository.seaFreightImage,
          subServices: [
            'Full Container Load (FCL)',
            'Less than Container Load (LCL)',
            'Import & Export Terminal Handling',
            'Buyer’s Consolidation Frameworks',
            'Port Customs Coordination',
            'Documentation Support & Manifesting',
          ],
        ),
        _ServiceHeroBlock(
          eyebrow: 'COMPLIANCE & STORAGE',
          title: 'Import & Export',
          description:
              'We assist businesses with customs documentation, HS Code validation, and warehouse storage placement to ensure compliant and efficient cargo movement.',
          iconText: 'CUSTOMS CLEARANCE',
          imageUrl: ContentRepository.importExportImage,
          subServices: [
            'Import Customs Clearance Protocol',
            'Export Manifest Certification',
            'HS Code Tariff Assistance',
            'Duty & Boundary Compliance Auditing',
          ],
        ),
        _ServiceHeroBlock(
          eyebrow: 'TIME-CRITICAL LOGISTICS',
          title: 'Express Cargo',
          description:
              'Our express cargo solutions are optimized for high-velocity cross-docking tracking and rapid industrial supply components.',
          iconText: 'PRIORITY HANDLING',
          imageUrl: ContentRepository.expressCargoImage,
          subServices: [
            'Intercity Cargo Movement',
            'Priority Express Tracking',
            'Last-Mile Courier Fleet Dispatch',
            'Time-Definite Delivery Routing',
          ],
        ),
        _ServiceHeroBlock(
          eyebrow: 'FULFILLMENT ARCHITECTURE',
          title: 'Door to Door',
          description:
              'Efficient end-to-end multi-modal handling. Moving your products directly from factory floors to target client nodes seamlessly.',
          iconText: 'LAST-MILE LOGISTICS',
          imageUrl: ContentRepository.doorToDoorImage,
          subServices: [
            'Container Terminal Trucking',
            'Factory Stuffing Coordination',
            'Secure Hand-to-Hand Delivery',
            'Regional Distribution Warehousing',
          ],
        ),
      ],
    );
  }
}

class _ServiceHeroBlock extends StatefulWidget {
  final String eyebrow;
  final String title;
  final String description;
  final String iconText;
  final String imageUrl;
  final List<String> subServices;

  const _ServiceHeroBlock({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.iconText,
    required this.imageUrl,
    required this.subServices,
  });

  @override
  State<_ServiceHeroBlock> createState() => _ServiceHeroBlockState();
}

class _ServiceHeroBlockState extends State<_ServiceHeroBlock> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.fastOutSlowIn,
        // Height changes smoothly contextually if open or shut
        height: _isExpanded ? (isMobile ? 660 : 720) : (isMobile ? 460 : 580),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    AppColors.black.withValues(alpha: 0.95),
                    AppColors.black.withValues(alpha: 0.30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: AppSpacing.pageGutter(width).copyWith(
                bottom: AppSpacing.xl,
                top: AppSpacing.xl,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upper block layout elements row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EyebrowLabel(widget.eyebrow),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              widget.title,
                              style: (isMobile
                                      ? text.displayMedium
                                      : text.displayLarge)
                                  ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 580),
                              child: Text(
                                widget.description,
                                style: text.bodyLarge?.copyWith(
                                  color: AppColors.textOnDarkSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isMobile)
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 300),
                                turns: _isExpanded ? 0.25 : 0.0,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                widget.iconText,
                                style: text.labelMedium?.copyWith(
                                  color: AppColors.white,
                                  letterSpacing: 1.8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // Expandable child container metadata segment
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 400),
                    alignment: Alignment.topLeft,
                    firstChild:
                        const SizedBox(width: double.infinity, height: 0),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 1,
                            color: Colors.white38,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'SERVICES INCLUDE:',
                            style: text.labelSmall?.copyWith(
                              color: AppColors.textOnDarkTertiary,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          // Responsive layout rendering mapping for items list grid content
                          isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.subServices
                                      .map(
                                        (item) => _SubServiceItem(label: item),
                                      )
                                      .toList(),
                                )
                              : Wrap(
                                  spacing: AppSpacing.xl,
                                  runSpacing: AppSpacing.sm,
                                  children: widget.subServices
                                      .map(
                                        (item) => SizedBox(
                                          width:
                                              (width / 2) - AppSpacing.xl * 2,
                                          child: _SubServiceItem(label: item),
                                        ),
                                      )
                                      .toList(),
                                ),
                        ],
                      ),
                    ),
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
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

class _SubServiceItem extends StatelessWidget {
  final String label;
  const _SubServiceItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 14, color: AppColors.white),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

