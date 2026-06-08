import 'package:go_router/go_router.dart';

import '../../views/screens/about/about_screen.dart';
import '../../views/screens/contact/contact_screen.dart';
import '../../views/screens/global_network/global_network_screen.dart';
import '../../views/screens/home/home_screen.dart';
import '../../views/screens/services/services_screen.dart';
import '../../views/screens/splash/splash_screen.dart';
import 'app_transitions.dart';

/// Tracks whether the splash screen has completed its animation.
///
/// On web the browser URL is preserved across reloads, so without this guard
/// go_router would skip the splash route when the user refreshes. The redirect
/// below ensures every app start begins at the splash route.
bool splashComplete = false;

/// Declarative route table for the application.
///
/// Uses [go_router] for web-friendly URL navigation and deep linking. Every
/// content route renders through [AppTransitions.goRouterPage] so navigation
/// shares one premium slide-and-fade motion; the splash route uses a plain
/// cross-fade into the home page.
abstract final class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (!splashComplete && state.uri.path != '/') return '/';
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => AppTransitions.fadePage(
          state: state,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => AppTransitions.goRouterPage(
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) => AppTransitions.goRouterPage(
          state: state,
          child: const AboutScreen(),
        ),
      ),
      GoRoute(
        path: '/services',
        pageBuilder: (context, state) => AppTransitions.goRouterPage(
          state: state,
          child: const ServicesScreen(),
        ),
      ),
      GoRoute(
        path: '/network',
        pageBuilder: (context, state) => AppTransitions.goRouterPage(
          state: state,
          child: const GlobalNetworkScreen(),
        ),
      ),
      GoRoute(
        path: '/contact',
        pageBuilder: (context, state) => AppTransitions.goRouterPage(
          state: state,
          child: const ContactScreen(),
        ),
      ),
    ],
  );
}
