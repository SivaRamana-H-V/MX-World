import 'package:flutter/material.dart';

import 'package:mxworld/core/constants/app_spacing.dart';

/// Stacks page sections vertically inside the [AppShell] scroll view.
///
/// A plain [Column] — the parent `SliverFillRemaining(hasScrollBody: true)`
/// provides unbounded main-axis constraints, so the Column never overflows.
class MxPageScaffold extends StatelessWidget {
  const MxPageScaffold({super.key, required this.sections});

  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    );
  }
}

/// Constrains its child to the max content width and applies the page gutter.
///
/// Canonical definition — do not duplicate this class in screen files.
class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.vertical = AppSpacing.section,
  });

  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: AppSpacing.pageGutter(width)
          .copyWith(top: vertical, bottom: vertical),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
