import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mxworld/core/constants/app_spacing.dart';
import 'package:mxworld/core/theme/app_colors.dart';
import 'package:mxworld/views/widgets/common/mx_button.dart';
import 'package:mxworld/views/widgets/common/under_development.dart';

/// Top navigation bar rendered above every screen.
///
/// Adapts the foreground color to the screen background via [onDark], collapses
/// the link row into a menu button on mobile, and highlights the active route.
class MxNavBar extends StatelessWidget {
  const MxNavBar({super.key, required this.currentRoute, this.onDark = false});

  final String currentRoute;
  final bool onDark;

  static const List<({IconData icon, String title, String route})> _links =
      <({IconData icon, String title, String route})>[
    (icon: Icons.home_outlined, title: 'Home', route: '/home'),
    (
      icon: Icons.miscellaneous_services_outlined,
      title: 'Services',
      route: '/services'
    ),
    (icon: Icons.call, title: 'Contact', route: '/contact'),
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
                for (int i = 0; i < _links.length; i++)
                  _NavIcon(
                    icon: i == 2 ? _links[i].icon : _links[i].title,
                    route: _links[i].route,
                    isActive: currentRoute == _links[i].route,
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

String _routeLabel(String route) {
  switch (route) {
    case '/home':
      return 'Home';
    case '/services':
      return 'Services';
    case '/contact':
      return 'Contact';
    default:
      return '';
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.route,
    required this.isActive,
    required this.fg,
  });

  final dynamic icon;
  final String route;
  final bool isActive;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon is IconData)
              Icon(
                icon,
                color: fg.withValues(alpha: isActive ? 1 : 0.65),
                size: 22,
              ),
            if (icon is String)
              Text(
                icon,
                style: TextStyle(
                  color: fg.withValues(alpha: isActive ? 1 : 0.65),
                  fontSize: 12,
                ),
              ),
            const SizedBox(height: 4),
            Container(
              height: 1.5,
              width: 14,
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
            child: Row(
              children: [
                Icon(
                  link.icon,
                  color: AppColors.white.withValues(
                    alpha: currentRoute == link.route ? 1 : 0.7,
                  ),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  _routeLabel(link.route),
                  style: TextStyle(
                    color: AppColors.white.withValues(
                      alpha: currentRoute == link.route ? 1 : 0.7,
                    ),
                    fontWeight: currentRoute == link.route
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
