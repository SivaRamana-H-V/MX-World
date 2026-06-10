import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import 'mx_footer.dart';
import 'mx_nav_bar.dart';

/// Persistent shell that wraps all content routes with the shared nav bar,
/// scrollable content area, and footer — so navigation between pages never
/// rebuilds the chrome.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    child,
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
