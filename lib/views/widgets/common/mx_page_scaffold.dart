import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';

/// Wraps sections in a non-scrollable list so they get unbounded layout
/// constraints, avoiding overflow when placed inside the AppShell's scroll
/// view.
class MxPageScaffold extends StatelessWidget {
  const MxPageScaffold({
    super.key,
    required this.sections,
  });

  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: sections,
    );
  }
}

/// Constrains its child to the max content width and applies the page gutter.
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
