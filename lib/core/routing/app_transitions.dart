import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized, high-end page transitions shared across the app.
///
/// The signature motion is a "slide-and-fade": the incoming page rises a short
/// distance from below while fading in, over 500 ms, with an elegant
/// [Curves.easeInOutCubic] ease. Keeping the slide distance small (a few
/// percent of the viewport) avoids large repaints and guarantees a snappy,
/// premium feel at 60 FPS on CanvasKit.
abstract final class AppTransitions {
  const AppTransitions._();

  static const Duration _duration = Duration(milliseconds: 500);
  static const Curve _curve = Curves.easeInOutCubic;

  /// Builds the shared slide-and-fade transition for a given [child].
  ///
  /// Used by both [goRouterPage] (declarative routing) and [slideFadeRoute]
  /// (imperative `Navigator.push`) so every navigation looks identical.
  static Widget _slideFade(Animation<double> animation, Widget child) {
    final Animation<double> eased = CurvedAnimation(
      parent: animation,
      curve: _curve,
      reverseCurve: _curve.flipped,
    );

    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(eased);

    return FadeTransition(
      opacity: eased,
      child: SlideTransition(position: slide, child: child),
    );
  }

  /// Wraps a screen in a [CustomTransitionPage] for use in `go_router`'s
  /// `pageBuilder`, applying the shared slide-and-fade transition.
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
        return _slideFade(animation, child);
      },
    );
  }

  /// A drop-in replacement for [MaterialPageRoute] when pushing imperatively
  /// via [Navigator.push], applying the same slide-and-fade motion.
  static PageRouteBuilder<T> slideFadeRoute<T>(Widget page) {
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
        return _slideFade(animation, child);
      },
    );
  }

  /// A quick cross-fade used for the splash -> home handoff so the brand mark
  /// dissolves directly into the landing page without any slide.
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
