import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Optimized page transitions with reduced latency.
///
/// Uses a fast 250 ms slide with [Curves.fastOutSlowIn] — the quick initial
/// acceleration eliminates perceived delay while the slow tail feels polished.
/// Fade is omitted to reduce GPU compositing layers.
abstract final class AppTransitions {
  const AppTransitions._();

  static const Duration _duration = Duration(milliseconds: 150);
  static const Curve _curve = Curves.fastOutSlowIn;

  static Widget _slide(Animation<double> animation, Widget child) {
    final Animation<double> eased = CurvedAnimation(
      parent: animation,
      curve: _curve,
      reverseCurve: _curve.flipped,
    );

    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(eased);

    return SlideTransition(position: slide, child: child);
  }

  static CustomTransitionPage<void> goRouterPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: _duration,
      reverseTransitionDuration: _duration,
      child: child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return _slide(animation, child);
      },
    );
  }

  static PageRouteBuilder<T> slideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: _duration,
      reverseTransitionDuration: _duration,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return _slide(animation, child);
      },
    );
  }

  static CustomTransitionPage<void> fadePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: _duration,
      child: child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: child,
        );
      },
    );
  }
}
