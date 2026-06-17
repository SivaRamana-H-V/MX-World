import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import 'mx_button.dart';
import 'under_development.dart';

/// Top navigation bar rendered above every screen.
///
/// Adapts the foreground color to the screen background via [onDark], collapses
/// the link row into a menu button on mobile, and highlights the active route.
class MxNavBar extends StatelessWidget {
  const MxNavBar({super.key, required this.currentRoute, this.onDark = false});

  final String currentRoute;
  final bool onDark;

  static const List<({String label, String route})> _links =
      <({String label, String route})>[
    (label: 'Portfolio', route: '/home'),
    (label: 'About', route: '/about'),
    (label: 'Services', route: '/services'),
    (label: 'Contact', route: '/contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final Color fg = onDark ? AppColors.white : AppColors.black;
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = width < 768;

    return Container(
      padding: AppSpacing.pageGutter(width).copyWith(top: 18, bottom: 18),
      color: onDark ? AppColors.black : AppColors.offWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => context.go('/home'),
            child: Image.asset(
              onDark
                  ? 'assets/images/logo_dark.png'
                  : 'assets/images/logo_light.png',
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
          if (isMobile)
            _MobileMenuButton(currentRoute: currentRoute, fg: fg)
          else
            Row(
              children: <Widget>[
                for (final link in _links)
                  _NavLink(
                    label: link.label,
                    route: link.route,
                    isActive: currentRoute == link.route,
                    fg: fg,
                  ),
                const SizedBox(width: AppSpacing.lg),
                MxButton(
                  label: 'Track Shipment',
                  onDark: onDark,
                  onPressed: () => showUnderDevelopment(context),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.route,
    required this.isActive,
    required this.fg,
  });

  final String label;
  final String route;
  final bool isActive;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: fg.withValues(alpha: isActive ? 1 : 0.65),
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 1.5,
              width: 18,
              color: isActive ? fg : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.currentRoute, required this.fg});

  final String currentRoute;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: fg),
      color: AppColors.nearBlack,
      onSelected: (String route) => context.go(route),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (final link in MxNavBar._links)
          PopupMenuItem<String>(
            value: link.route,
            child: Text(
              link.label,
              style: TextStyle(
                color: AppColors.white.withValues(
                  alpha: currentRoute == link.route ? 1 : 0.7,
                ),
                fontWeight: currentRoute == link.route
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
