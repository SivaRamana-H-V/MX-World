import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import 'mx_footer.dart';
import 'mx_nav_bar.dart';
import 'page_scroll_notifier.dart';

/// Persistent shell wrapping all content routes with the shared nav bar,
/// scrollable content area, and footer.
///
/// A single [NotificationListener] intercepts scroll events from the
/// [SingleChildScrollView] and updates [_scrollOffset]. All [RevealOnScroll]
/// and [AnimatedCounter] descendants subscribe to this one notifier instead of
/// each attaching their own [ScrollPosition] listener — eliminating 14+ per-
/// frame element-tree traversals that caused scroll frame drops.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0);

  @override
  void dispose() {
    _scrollOffset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String route = GoRouterState.of(context).uri.path;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            MxNavBar(currentRoute: route, onDark: false),
            Expanded(
              child: PageScrollNotifier(
                notifier: _scrollOffset,
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (ScrollUpdateNotification n) {
                    _scrollOffset.value = n.metrics.pixels;
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        widget.child,
                        const MxFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
