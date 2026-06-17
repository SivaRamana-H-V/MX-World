import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';

/// Stacks page sections vertically inside the [AppShell] scroll view.
///
/// Previously used [ListView] with [shrinkWrap: true], which forced Flutter to
/// lay out every section before painting the first frame — causing 1–1.5 s
/// routing lag. A [Column] builds children inline in the existing scroll
/// viewport, giving the first frame immediate paint.
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
