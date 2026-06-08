import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import 'mx_footer.dart';
import 'mx_nav_bar.dart';

/// Page scaffold that composes the sticky-feeling nav bar, a scrolling body of
/// sections, and the shared footer.
///
/// [navOnDark] controls the nav bar's foreground color so it remains legible
/// whether the first section is light or dark. [sections] are stacked in a
/// single scroll view; each section manages its own full-bleed background.
class MxPageScaffold extends StatelessWidget {
  const MxPageScaffold({
    super.key,
    required this.currentRoute,
    required this.sections,
    this.navOnDark = false,
    this.scrollController,
  });

  final String currentRoute;
  final List<Widget> sections;
  final bool navOnDark;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          navOnDark ? AppColors.black : AppColors.offWhite,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            MxNavBar(currentRoute: currentRoute, onDark: navOnDark),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ...sections,
                    const MxFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Constrains its child to the max content width and applies the page gutter.
///
/// Use inside sections to keep text and grids aligned to the design's content
/// column on very wide displays.
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
