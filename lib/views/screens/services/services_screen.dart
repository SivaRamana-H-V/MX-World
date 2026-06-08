import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/safe_network_image.dart';

/// Services screen: a stack of full-bleed editorial panels, one per service
/// line, each overlaying a title, description, and action affordance on a
/// darkened photograph.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MxPageScaffold(
      currentRoute: '/services',
      navOnDark: true,
      sections: <Widget>[
        for (final ServiceItem service in ContentRepository.services)
          _ServicePanel(service: service),
      ],
    );
  }
}

class _ServicePanel extends StatelessWidget {
  const _ServicePanel({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      height: isMobile ? 360 : 420,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeNetworkImage(url: service.imageUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  AppColors.black.withValues(alpha: 0.88),
                  AppColors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.pageGutter(width)
                .copyWith(top: AppSpacing.lg, bottom: AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${service.index} | ${service.category}',
                      style: text.labelMedium?.copyWith(
                        color: AppColors.textOnDarkSecondary,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            service.title,
                            style: (isMobile
                                    ? text.headlineLarge
                                    : text.displayMedium)
                                ?.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxWidth: 460),
                            child: Text(
                              service.description,
                              style: text.bodyMedium?.copyWith(
                                color: AppColors.textOnDarkSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) _ActionAffordance(label: service.actionLabel),
                  ],
                ),
                if (isMobile) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  _ActionAffordance(label: service.actionLabel),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionAffordance extends StatelessWidget {
  const _ActionAffordance({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                letterSpacing: 1.4,
              ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderDark),
          ),
          child: const Icon(Icons.arrow_forward,
              size: 14, color: AppColors.white,),
        ),
      ],
    );
  }
}
