import 'package:flutter/material.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/models/content_models.dart';
import 'animated_counter.dart';

/// A horizontal strip of large numeric statistics with captions.
///
/// Collapses from a row into a wrap on narrow screens. Used in the home,
/// about, and network screens.
class StatsStrip extends StatelessWidget {
  const StatsStrip({
    super.key,
    required this.stats,
    this.onDark = false,
    this.showDividers = true,
  });

  final List<StatItem> stats;
  final bool onDark;
  final bool showDividers;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isMobile = AppBreakpoints.isMobile(constraints.maxWidth);
        if (isMobile) {
          return Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.lg,
            children: <Widget>[
              for (final StatItem stat in stats)
                _StatCell(stat: stat, onDark: onDark),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < stats.length; i++) ...<Widget>[
              Expanded(child: _StatCell(stat: stats[i], onDark: onDark)),
              if (showDividers && i < stats.length - 1)
                Container(
                  width: 1,
                  height: 48,
                  color: Theme.of(context).dividerColor,
                ),
            ],
          ],
        );
      },
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.stat, required this.onDark});

  final StatItem stat;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedCounter(
          value: stat.value,
          style: text.displayMedium?.copyWith(
            fontSize: 38,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          stat.label,
          style: text.labelMedium?.copyWith(letterSpacing: 1.4),
        ),
      ],
    );
  }
}
